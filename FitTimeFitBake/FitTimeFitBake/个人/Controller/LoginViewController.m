//
//  LoginViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/28.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MyOtherWayLoginButton.h"

#define TOP_MARGIN 30
#define LEFT_MARGIN 20
#define MARGIN 10

@interface LoginViewController ()<UITextFieldDelegate>
//填写信息
@property(nonatomic, strong)UIView * textBgView;
@property(nonatomic, strong)UIView * lineView;
@property(nonatomic, strong)UITextField * phoneNumberField;
@property(nonatomic, strong)UITextField * passwordField;
//登录按钮
@property(nonatomic, strong)UIButton * loginButton;
@property(nonatomic, strong)UIButton * forgetButton;
//第三方登录
@property(nonatomic, strong)UIImageView * leftView;
@property(nonatomic, strong)UILabel * otherWayLabel;
@property(nonatomic, strong)UIImageView * rightView;
@property(nonatomic, strong)MyOtherWayLoginButton * QQButton;
@property(nonatomic, strong)MyOtherWayLoginButton * weChatButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initForTitleView];
    [self initForLoginMessageView];
    [self initForLoginButtonView];
    [self initForOtherWayLoginView];
}

#pragma mark
#pragma mark ========== 创建导航栏的Button和背景色
-(void)initForTitleView{
    self.title = @"登录";
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    UIBarButtonItem * backItem = [UIBarButtonItem itemWithImage:@"app_images_navigationbar_navigation_back" HightImage:@"app_images_navigationbar_navigation_back" target:self action:@selector(backToAction:)];
    self.navigationController.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton * registerItem = [UIButton buttonWithType:UIButtonTypeCustom];
    registerItem.frame = CGRectMake(0, 0, 40, 30);
    registerItem.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerItem setTitle:@"注册" forState:UIControlStateNormal];
    [registerItem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [registerItem setTitleColor:[UIColor colorWithRed:0.65 green:0.22 blue:0.19 alpha:1.00] forState:UIControlStateHighlighted];
    [registerItem addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:registerItem];
    
}
-(void)backToAction:(UIButton *)btn{
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)registerAction:(UIButton *)btn{
    RegisterViewController * registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark
#pragma mark ========== 填写信息view
-(void)initForLoginMessageView{
    float textFieldHeight = 40;
    _textBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+TOP_MARGIN, self.view.width, textFieldHeight*2)];
    _textBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_textBgView];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(_textBgView.frame)+textFieldHeight, self.view.width, 1)];
    _lineView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    [self.view addSubview:_lineView];
    
    float fieldWidth = self.view.width-LEFT_MARGIN;
    _phoneNumberField = [[UITextField alloc] init];
    _phoneNumberField.frame = CGRectMake(LEFT_MARGIN, 5, fieldWidth, 30);
    NSAttributedString * attrStr = [[NSAttributedString alloc]initWithString:@"手机号" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor grayColor]}];
    _phoneNumberField.attributedPlaceholder = attrStr;
    _phoneNumberField.textAlignment = NSTextAlignmentLeft;
    _phoneNumberField.clearButtonMode = UITextFieldViewModeAlways;
    _phoneNumberField.delegate = self;
    [self.textBgView addSubview:_phoneNumberField];
    
    _passwordField = [[UITextField alloc] init];
    _passwordField.frame = CGRectMake(LEFT_MARGIN, textFieldHeight+5, fieldWidth, 30);
    attrStr = [[NSAttributedString alloc]initWithString:@"密码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor grayColor]}];
    _passwordField.attributedPlaceholder = attrStr;
    _passwordField.textAlignment = NSTextAlignmentLeft;
    _passwordField.clearButtonMode = UITextFieldViewModeAlways;
    _passwordField.secureTextEntry = YES;
    _passwordField.delegate = self;
    [self.textBgView addSubview:_passwordField];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneNumberField resignFirstResponder];
    [_passwordField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_phoneNumberField resignFirstResponder];
    [_passwordField resignFirstResponder];
    return YES;
}
#pragma mark
#pragma mark ========== 登录和忘记密码按钮
-(void)initForLoginButtonView{
    _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_textBgView.frame)+20, self.view.width-20, 35)];
    [_loginButton setBackgroundImage:[[UIImage imageNamed:@"loginBtnBg"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[[UIImage imageNamed:@"loginBtnBgClick"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    _loginButton.clipsToBounds = YES;
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.cornerRadius = 5;
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    _forgetButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width-80, CGRectGetMaxY(_loginButton.frame)+10, 70, 15)];
    [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgetButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _forgetButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_forgetButton addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetButton];
}
-(void)loginAction:(UIButton *)btn{
#warning 登录响应
}
-(void)forgetAction:(UIButton *)btn{
    RegisterViewController * registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
#pragma mark
#pragma mark =========== 第三方登录按钮
-(void)initForOtherWayLoginView{
    float width = (self.view.width-2*MARGIN)/3;
    _leftView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, CGRectGetMaxY(_forgetButton.frame)+30, width, 1)];
    _leftView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_leftView];
    _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN+2*width, CGRectGetMaxY(_forgetButton.frame)+30, width, 1)];
    _rightView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_rightView];
    
    _otherWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN+width, CGRectGetMaxY(_forgetButton.frame)+25, width, 10)];
    _otherWayLabel.font = [UIFont systemFontOfSize:12];
    _otherWayLabel.textColor = [UIColor grayColor];
    _otherWayLabel.textAlignment = NSTextAlignmentCenter;
    _otherWayLabel.text = @"使用社交账号登录";
    [self.view addSubview:_otherWayLabel];
    
#warning 第三方登录
    float btnWidth = (self.view.width)/7;
    _QQButton = [[MyOtherWayLoginButton alloc] initWithFrame:CGRectMake(2*btnWidth, CGRectGetMaxY(_otherWayLabel.frame)+30, btnWidth, btnWidth*1.8)];
    [_QQButton setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [_QQButton setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateHighlighted];
    _QQButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_QQButton setTitle:@"QQ" forState:UIControlStateNormal];
    [_QQButton setTitleColor:[UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00] forState:UIControlStateNormal];
    [self.view addSubview:_QQButton];
    
    _weChatButton = [[MyOtherWayLoginButton alloc] initWithFrame:CGRectMake(4*btnWidth, CGRectGetMaxY(_otherWayLabel.frame)+30, btnWidth, btnWidth*1.8)];
    [_weChatButton setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    [_weChatButton setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateHighlighted];
    _weChatButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_weChatButton setTitle:@"微信" forState:UIControlStateNormal];
    [_weChatButton setTitleColor:[UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00] forState:UIControlStateNormal];
    [self.view addSubview:_weChatButton];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
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
