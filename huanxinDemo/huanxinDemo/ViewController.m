//
//  ViewController.m
//  huanxinDemo
//
//  Created by WJ on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "ViewController.h"
#import <EaseMob.h>
#import "UIView+WJFoundation.h"
#import "RegisterViewController.h"
#import "FriendListViewController.h"

@interface ViewController ()
/** 用户名 */
@property (nonatomic, strong) UITextField *userNameTextField;
/** 用户密码 */
@property (nonatomic, strong) UITextField *userPasswordTextField;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginButton;
/** 注册按钮 */
@property (nonatomic, strong) UIButton *registerButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NSNotFound;
    self.title = @"登录界面";
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 80, 50)];
    userNameLabel.text = @"用户名";
    userNameLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:userNameLabel];
    
    self.userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(userNameLabel.x + userNameLabel.width + 10, userNameLabel.y, 250, 50)];
    self.userNameTextField.borderStyle = 3;
    self.userNameTextField.placeholder = @"请输入用户名";
    [self.view addSubview:self.userNameTextField];
    
    UILabel *userPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(userNameLabel.x, userNameLabel.y + userNameLabel.height + 10, userNameLabel.width, userNameLabel.height)];
    userPasswordLabel.text = @"密码";
    userPasswordLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:userPasswordLabel];
    
    self.userPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.userNameTextField.x, userPasswordLabel.y, self.userNameTextField.width, self.userNameTextField.height)];
    self.userPasswordTextField.placeholder = @"请输入密码";
    self.userPasswordTextField.borderStyle = 3;
    [self.view addSubview:self.userPasswordTextField];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginButton.frame = CGRectMake(170, 300, 50, 50);
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [self.loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(didClickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registerButton.frame = CGRectMake(170, 350, 50, 50);
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(jumpToRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];
    
}

- (void)didClickLoginButton:(UIButton *)sender {
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.userNameTextField.text password:self.userPasswordTextField.text completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error) {
            [self.navigationController pushViewController:[[FriendListViewController alloc] init] animated:YES];
        } else {
            
            NSLog(@"用户名或密码错误");
        }
        
    } onQueue:dispatch_get_main_queue()];
    
}

- (void)jumpToRegister:(UIButton *)sender {
    
    [self.navigationController presentViewController:[[RegisterViewController alloc] init] animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
