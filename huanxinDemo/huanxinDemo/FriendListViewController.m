//
//  FriendListViewController.m
//  huanxinDemo
//
//  Created by WJ on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "FriendListViewController.h"
#import "AddFriendViewController.h"
#import "ChatViewViewController.h"
#import <EaseMob.h>

@interface FriendListViewController ()<UITableViewDelegate, UITableViewDataSource, EMChatManagerDelegate,EMChatManagerBuddyDelegate>
/** 朋友列表 */
@property (nonatomic, strong) NSMutableArray *friendList;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FriendListViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton:)];
    self.title = @"好友";
    
    [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        if (!error) {
            [self.friendList removeAllObjects];
            [self.friendList addObjectsFromArray:buddyList];
            [self.tableView reloadData];
        }
    } onQueue:dispatch_get_main_queue()];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.friendList = [[NSMutableArray alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend:)];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    // 签协议
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

/** 注销用户 */
- (void)cancelButton:(UIButton *)sender {
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

/** 添加好友 */
- (void)addFriend:(UIButton *)sender {
    [self.navigationController pushViewController:[[AddFriendViewController alloc] init] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"1234";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    EMBuddy *buddy = self.friendList[indexPath.row];
    cell.textLabel.text = buddy.username;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatViewViewController *chat = [[ChatViewViewController alloc] init];
    
    EMBuddy *buddy = self.friendList[indexPath.row];
    chat.userName = buddy.username;
    [self.navigationController pushViewController:chat  animated:YES];
    
}

- (void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"收到来自%@的好友请求", username] message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defarulAction = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        EMError *error;
        if ([[EaseMob sharedInstance].chatManager acceptBuddyRequest:username error:&error]) {
            NSLog(@"发送同意成功");
            [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
                if (!error) {
                    [self.friendList removeAllObjects];
                    [self.friendList addObjectsFromArray:buddyList];
                    [self.tableView reloadData];
                }
                
            } onQueue:dispatch_get_main_queue()];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        EMError *error;
        if ([[EaseMob sharedInstance].chatManager rejectBuddyRequest:username reason:nil error:&error]) {
            NSLog(@"拒绝");
        }
    }];
    
    [alert addAction:defarulAction];
    [alert addAction:cancelAction];
    [self showDetailViewController:alert sender:nil];
}

- (void)didAcceptedByBuddy:(NSString *)username {
    [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        if (!error) {
            [self.friendList removeAllObjects];
            [self.friendList addObjectsFromArray:buddyList];
            [self.tableView reloadData];
        }
        
    } onQueue:dispatch_get_main_queue()];
    
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
