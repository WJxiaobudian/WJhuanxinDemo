//
//  AddFriendViewController.m
//  huanxinDemo
//
//  Created by WJ on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "AddFriendViewController.h"
#import <EaseMob.h>
@interface AddFriendViewController ()

/** 用户名 */
@property (nonatomic, strong) UITextField *userNameTextField;


@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 80, 50)];
    usernameLabel.text = @"用户名";
    usernameLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:usernameLabel];
    
    self.userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(usernameLabel.frame.origin.x + usernameLabel.frame.size.width + 10, usernameLabel.frame.origin.y, 250, 50)];
    self.userNameTextField.borderStyle = 3;
    self.userNameTextField.placeholder = @"请输入用户名";
    [self.view addSubview:self.userNameTextField];
    
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addButton.frame = CGRectMake(170, 300, 50, 50);
    addButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(didClickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];

}

- (void)didClickAddButton:(UIButton *)sender {
    EMError *error;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:self.userNameTextField.text message:@"我想加你为好友" error:&error];
    if (!isSuccess && !error) {
        
    }
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
