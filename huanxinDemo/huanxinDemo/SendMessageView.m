//
//  SendMessageView.m
//  huanxinDemo
//
//  Created by WJ on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "SendMessageView.h"

@interface SendMessageView ()
@property (nonatomic, strong) UITextField *sendMessageField;
@property (nonatomic, strong) UIButton *sendButton;

@end
@implementation SendMessageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    [self setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
    
    self.sendMessageField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 100, self.frame.size.height - 10)];
    [self.sendMessageField setBorderStyle:(UITextBorderStyleRoundedRect)];
    [self.sendMessageField setPlaceholder:@"说点什么呢"];
    [self.sendMessageField setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:self.sendMessageField];
    
    self.sendButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.sendButton setFrame:CGRectMake(self.frame.size.width - 90, 5, 85, self.frame.size.height - 10)];
    [self.sendButton setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:128 / 255.0 alpha:1]];
    [self.sendButton setTitle:@"发送" forState:(UIControlStateNormal)];
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [self.sendButton.layer setMasksToBounds:YES];
    [self.sendButton.layer setCornerRadius:4];
    [self.sendButton addTarget:self action:@selector(didSendButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_sendButton];

}

- (void)didSendButtonClicked:(UIButton *)sender {
    
    if (self.buttonClicked) {
        self.buttonClicked(_sendMessageField.text);
    }
    self.sendMessageField.text = @"";
}

- (NSString *)sendMessage {
    return _sendMessageField.text;
}
@end
