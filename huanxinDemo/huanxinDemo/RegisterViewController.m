//
//  RegisterViewController.m
//  huanxinDemo
//
//  Created by WJ on 16/6/16.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "RegisterViewController.h"
#import <EaseMob.h>
@interface RegisterViewController ()
/** 用户名 */
@property(nonatomic, strong)UITextField *userNameTextField;
/** 密码 */
@property(nonatomic, strong)UITextField *passwordTextField;
/** 注册按钮 */
@property(nonatomic, strong)UIButton *registerButton;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"登陆界面";
    
    UILabel *usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 80, 50)];
    usernameLabel.text = @"用户名";
    usernameLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:usernameLabel];
    
    self.userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(usernameLabel.frame.origin.x + usernameLabel.frame.size.width + 10, usernameLabel.frame.origin.y, 250, 50)];
    self.userNameTextField.borderStyle = 3;
    self.userNameTextField.placeholder = @"请输入用户名";
    [self.view addSubview:self.userNameTextField];
    
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(usernameLabel.frame.origin.x, usernameLabel.frame.origin.y + usernameLabel.frame.size.height + 10, usernameLabel.frame.size.width, usernameLabel.frame.size.height)];
    passwordLabel.text = @"密码";
    passwordLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:passwordLabel];
    
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.userNameTextField.frame.origin.x, passwordLabel.frame.origin.y, self.userNameTextField.frame.size.width, self.userNameTextField.frame.size.height)];
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.borderStyle = 3;
    [self.view addSubview:self.passwordTextField];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registerButton.frame = CGRectMake(170, 330, 50, 50);
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(didClickedRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(170, 280, 50, 50);
    backButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

}

- (void)didClickedRegisterButton:(UIButton *)sender {
    
    // 注册
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.userNameTextField.text password:self.passwordTextField.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        if (!error) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            
        }
    } onQueue:dispatch_get_main_queue()];
    
}

- (void)backAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.passwordTextField resignFirstResponder];
    [self.userNameTextField resignFirstResponder];
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
