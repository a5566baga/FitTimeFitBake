//
//  RegisterViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/28.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "RegisterViewController.h"
#import "GetMessageViewController.h"
#import <SMS_SDK/SMSSDK.h>

#define TOP_MARGIN 30
#define LEFT_MARGIN 20
#define HEIGHT_MARGIN 40

@interface RegisterViewController ()<UITextFieldDelegate>
//提示信息
@property(nonatomic, strong)UILabel * warningLabel;
//输入文本框
@property(nonatomic, strong)UIImageView * bgView;
@property(nonatomic, strong)UIImageView * lineView;
@property(nonatomic, strong)UITextField * phoneNumField;
@property(nonatomic, strong)UITextField * yanzhengField;
//验证码

//按钮
@property(nonatomic, strong)UIButton * getMessageButton;

@property(nonatomic, strong)UIView * errorView;
@property(nonatomic, strong)UILabel * errorLabel;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initForTitleView];
    [self initForWarningMessageView];
    [self initFotTextFieldView];
    [self initForYanZheng];
    [self initForButton];
}
#pragma mark
#pragma mark =========== 创建title的内容，导航内容
-(void)initForTitleView{
    self.title = @"爱烘焙爱生活";
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    UIBarButtonItem * backItem = [UIBarButtonItem itemWithImage:@"app_images_navigationbar_navigation_back" HightImage:@"app_images_navigationbar_navigation_back" target:self action:@selector(backToAction:)];
    self.navigationController.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)backToAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark ========== 上面的提示信息
-(void)initForWarningMessageView{
    _warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, 64+TOP_MARGIN, self.view.width-2*LEFT_MARGIN, 15)];
    _warningLabel.text = @"请确保你的手机畅通，能接收验证码信息";
    _warningLabel.textAlignment = NSTextAlignmentLeft;
    _warningLabel.font = [UIFont systemFontOfSize:12];
    _warningLabel.textColor = [UIColor grayColor];
    [self.view addSubview:_warningLabel];
}
#pragma mark
#pragma mark =========== 中间的输入框
-(void)initFotTextFieldView{
    _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_warningLabel.frame)+20, self.view.width, 2*HEIGHT_MARGIN)];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgView];
    
    _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, HEIGHT_MARGIN, self.view.width, 1)];
    _lineView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    _lineView.userInteractionEnabled = YES;
    [self.bgView addSubview:_lineView];
    
    _phoneNumField = [[UITextField alloc] initWithFrame:CGRectMake(LEFT_MARGIN, 0, _bgView.width-LEFT_MARGIN, HEIGHT_MARGIN)];
    _phoneNumField.textAlignment = NSTextAlignmentLeft;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor grayColor]}];
    _phoneNumField.attributedPlaceholder = attrStr;
    _phoneNumField.clearButtonMode = UITextFieldViewModeAlways;
    _phoneNumField.delegate = self;
    [self.bgView addSubview:_phoneNumField];
    
    _yanzhengField = [[UITextField alloc] initWithFrame:CGRectMake(LEFT_MARGIN, HEIGHT_MARGIN, _bgView.width-LEFT_MARGIN, HEIGHT_MARGIN)];
    attrStr = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor grayColor]}];
    _yanzhengField.attributedPlaceholder = attrStr;
    _yanzhengField.textAlignment = NSTextAlignmentLeft;
    _yanzhengField.clearButtonMode = UITextFieldViewModeAlways;
    _yanzhengField.secureTextEntry = YES;
    _yanzhengField.delegate = self;
    [self.bgView addSubview:_yanzhengField];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneNumField resignFirstResponder];
    [_yanzhengField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_phoneNumField resignFirstResponder];
    [_yanzhengField resignFirstResponder];
    return YES;
}
#pragma mark
#pragma mark ============ 验证码
-(void)initForYanZheng{
    
}
#pragma mark
#pragma mark ============ 确认按钮
-(void)initForButton{
    _getMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_bgView.frame)+HEIGHT_MARGIN, self.view.width-20, HEIGHT_MARGIN)];
    [_getMessageButton setBackgroundImage:[[UIImage imageNamed:@"loginBtnBg"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [_getMessageButton setBackgroundImage:[[UIImage imageNamed:@"loginBtnBgClick"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [_getMessageButton setTitle:@"获取验证码短信" forState:UIControlStateNormal];
    [_getMessageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _getMessageButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _getMessageButton.layer.cornerRadius = 5;
    _getMessageButton.clipsToBounds = YES;
    [_getMessageButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getMessageButton];
}
//获取验证码
-(void)registerAction:(UIButton *)button{
//    判断验证码和手机号是否都写了
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNumField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            GetMessageViewController * getMessageVC = [[GetMessageViewController alloc] init];
            [getMessageVC setPhoneNum:_phoneNumField.text];
            [self.navigationController pushViewController:getMessageVC animated:YES];
        } else {
            [self initForSuccessOrErrorView:@"手机号/验证码错误"];
        }
    }];
}

#pragma mark
#pragma mark ========= 错误信息提示
-(void)initForSuccessOrErrorView:(NSString *)messageText{
    //    重新获取得到新验证码提示
    //    提交显示验证码输入错误提示
    if (_errorView != nil) {
        [_errorView removeFromSuperview];
    }
    _errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    _errorView.center = self.view.center;
    _errorView.layer.cornerRadius = 5;
    _errorView.clipsToBounds = YES;
    _errorView.backgroundColor = [UIColor blackColor];
    _errorView.alpha = 0;
    [self.view addSubview:_errorView];
    _errorLabel = [[UILabel alloc] initWithFrame:_errorView.bounds];
    _errorLabel.textAlignment = NSTextAlignmentCenter;
    _errorLabel.font = [UIFont systemFontOfSize:13];
    _errorLabel.textColor = [UIColor whiteColor];
    _errorLabel.text = messageText;
    [self.errorView addSubview:_errorLabel];
    
    [UIView animateWithDuration:0.8 animations:^{
        _errorView.alpha = 0.8;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 animations:^{
            _errorView.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

#pragma mark
#pragma mark ====== 隐藏tabBar和显示
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
