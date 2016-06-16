//
//  ChatViewViewController.m
//  huanxinDemo
//
//  Created by WJ on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "ChatViewViewController.h"
#import <EaseMob.h>
#import "SendMessageView.h"
#import "UIView+WJFoundation.h"
@interface ChatViewViewController ()<UITableViewDelegate, UITableViewDataSource, EMChatManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) EMConversation *conversation;
@property (nonatomic, strong) SendMessageView *messageView;

@end

@implementation ChatViewViewController

-(void)loadView
{
    [super loadView];
    self.title = self.userName;
    self.navigationController.navigationBar.translucent = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 114)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setAllowsSelection:NO];
    self.messageView = [[SendMessageView alloc] initWithFrame:CGRectMake(0, self.view.height - 114, self.view.width, 50)];
    __weak typeof(self) weakSelf = self;
    self.messageView.buttonClicked = ^(NSString *sendMessage) {
        [weakSelf sendMessageWithDraftText:sendMessage];
    };
    [self.view addSubview:self.messageView];
    
    
    [self reloadChatRecords];
    
    [self registerForKeyboardNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

/**
 *  使用草稿发送一条消失
 *
 *  @param draftText 草稿
 */
- (void)sendMessageWithDraftText:(NSString *)draftText {
    
    EMChatText *chatText = [[EMChatText alloc] initWithText:draftText];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:chatText];
    
    EMMessage *message = [[EMMessage alloc] initWithReceiver:self.userName bodies:@[body]];
   // 单聊模式
    message.messageType = eMessageTypeChat;
    
    [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil prepare:^(EMMessage *message, EMError *error) {
        
    } onQueue:dispatch_get_main_queue() completion:^(EMMessage *message, EMError *error) {
     
        [self reloadChatRecords];
        
    } onQueue:dispatch_get_main_queue()];
}

- (void)didReceiveMessage:(EMMessage *)message {
    
    [self reloadChatRecords];
}

- (void)reloadChatRecords {
    self.conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.userName conversationType:eConversationTypeChat];
    
    [self.tableView reloadData];
    
    if ([self.conversation loadAllMessages].count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.conversation loadAllMessages].count - 1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
    }
}

/**
 *  通知中心
 */
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didKeyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didKeyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
}

/**
 *  移除通知中心
 */
- (void)removeForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  键盘将要弹出
 *
 *  @param notification 通知
 */
- (void)didKeyboardWillShow:(NSNotification *)notification {
    
    NSDictionary * info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    NSLog(@"%f", keyboardSize.height);
    
    //输入框位置动画加载
//    [self begainMoveUpAnimation:keyboardSize.height];
    
    [self.messageView setFrame:CGRectMake(0, self.view.height - (keyboardSize.height + 50), self.messageView.width, self.messageView.height)];
    
//    [self.tableView layoutIfNeeded];
    //
    if ([self.conversation loadAllMessages].count > 1) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_conversation.loadAllMessages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - keyboardSize.height - self.messageView.height);
}

/**
 *  键盘将要隐藏
 *
 *  @param notification 通知
 */
- (void)didKeyboardWillHide:(NSNotification *)notification {
    
    [self begainMoveUpAnimation:0];
}

/**
 *  开始执行键盘改变后对应视图的变化
 *
 *  @param height 键盘的高度
 */
- (void)begainMoveUpAnimation:(CGFloat)height {
    
            
        [self.messageView setFrame:CGRectMake(0, self.view.height - (height + 50), self.messageView.width, self.messageView.height)];

    
    
    [self.tableView layoutIfNeeded];
//
    if ([self.conversation loadAllMessages].count > 1) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_conversation.loadAllMessages.count - 1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
    }
    
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height - height- 50);
}

# pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.conversation.loadAllMessages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    EMMessage * message = _conversation.loadAllMessages[indexPath.row];
    
    EMTextMessageBody * body = [message.messageBodies lastObject];
    
    //判断发送的人是否是当前聊天的人,左边是对面发过来的,右边是自己发过去的
    if ([message.to isEqualToString:self.userName]) {
        
        cell.detailTextLabel.text = body.text;
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.textLabel.text = @"";
        cell.textLabel.textColor = [UIColor blueColor];
        
    } else {
        
        cell.detailTextLabel.text = @"";
        cell.textLabel.text = body.text;
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.textLabel.textColor = [UIColor blueColor];
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
