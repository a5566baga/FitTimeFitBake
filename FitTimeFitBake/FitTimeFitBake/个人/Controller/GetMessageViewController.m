//
//  GetMessageViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/7.
//  Copyright © 2016年 张增强. All rights reserved.
//  验证短信验证码视图

#import "GetMessageViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+DeprecatedMethods.h>
#import <SMS_SDK/Extend/SMSSDK+ExtexdMethods.h>


#define TOP_MARGIN 15
#define LEFT_MARGIN 15

@interface GetMessageViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)UIImageView * textBgView;
@property(nonatomic, strong)UITextField * messageCodeField;
@property(nonatomic, strong)UIButton * timerButton;
@property(nonatomic, strong)NSTimer * timer;
@property(nonatomic, assign)NSInteger seconds;

@property(nonatomic, strong)UILabel * warnLabel;
@property(nonatomic, strong)UIButton * submitCodeButton;

@property(nonatomic, strong)UIView * errorView;
@property(nonatomic, strong)UILabel * errorLabel;

@end

@implementation GetMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initForWarnningView];
    [self initForTextView];
    [self initForTimerView];
}

#pragma mark
#pragma mark ============= 提示信息
-(void)initForWarnningView{
    _warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*LEFT_MARGIN, TOP_MARGIN+64, self.view.width-2*LEFT_MARGIN, 15)];
    _warnLabel.text = @"请输入手机收到的验证码：";
    _warnLabel.textColor = [UIColor grayColor];
    _warnLabel.textAlignment = NSTextAlignmentLeft;
    _warnLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_warnLabel];
}

#pragma mark
#pragma mark ============= 输入文本框和提交按钮
-(void)initForTextView{
    _textBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_warnLabel.frame)+TOP_MARGIN, self.view.width, 45)];
    _textBgView.backgroundColor = [UIColor whiteColor];
    _textBgView.userInteractionEnabled = YES;
    [self.view addSubview:_textBgView];
    
    _messageCodeField = [[UITextField alloc] init];
    _messageCodeField.frame = CGRectMake(2*LEFT_MARGIN, 0, _textBgView.width/3*2, _textBgView.height);
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithString:@"请输入手机验证码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor grayColor]}];
    _messageCodeField.attributedPlaceholder = attrStr;
    _messageCodeField.textAlignment = NSTextAlignmentLeft;
    _messageCodeField.delegate = self;
    [_messageCodeField setTintColor:[UIColor colorWithRed:0.75 green:0.74 blue:0.76 alpha:1.00]];
    [self.textBgView addSubview:_messageCodeField];
    
    _submitCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(LEFT_MARGIN, CGRectGetMaxY(_textBgView.frame)+2*TOP_MARGIN, self.view.width-2*LEFT_MARGIN, 45)];
    [_submitCodeButton setBackgroundImage:[[UIImage imageNamed:@"loginBtnBg"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [_submitCodeButton setBackgroundImage:[[UIImage imageNamed:@"loginBtnBgClick"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
    [_submitCodeButton setTitle:@"提交" forState:UIControlStateNormal];
    _submitCodeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_submitCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _submitCodeButton.layer.cornerRadius = 5;
    _submitCodeButton.clipsToBounds = YES;
    [_submitCodeButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitCodeButton];
}
//提交短信验证码
#warning message
-(void)submitAction:(UIButton *)btn{
    ZZQLog(@"短信验证码");
    SMSSDKUserInfo* userInfo=[[SMSSDKUserInfo alloc] init];
    userInfo.phone = _phoneNum;
    [SMSSDK submitUserInfoHandler:userInfo result:^(NSError *error) {
        if (!error) {
//            验证成功
#warning 跳转到个人页面
        }else{
//            验证失败
            [self initForSuccessOrErrorView:@"验证码有错"];
        }
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_messageCodeField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_messageCodeField resignFirstResponder];
    return YES;
}

#pragma mark
#pragma mark ============= 定时器倒计时60s,重发短信
-(void)initForTimerView{
    _seconds = 60;
    
    _timerButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width-80, 0, 80, _textBgView.height)];
    [_timerButton setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00]];
    _timerButton.userInteractionEnabled = NO;
    NSAttributedString * timerAttrStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld s", _seconds] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor grayColor]}];
    [_timerButton setAttributedTitle:timerAttrStr forState:UIControlStateNormal];
    _timerButton.layer.borderWidth = 1;
    _timerButton.layer.borderColor = [UIColor grayColor].CGColor;
    [_timerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_timerButton addTarget:self action:@selector(timerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.textBgView addSubview:_timerButton];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(myTimer) userInfo:nil repeats:YES];
}
-(void)myTimer{
    if (_seconds > 0) {
        _seconds--;
        NSAttributedString * timerAttrStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld s", _seconds] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor grayColor]}];
        [_timerButton setAttributedTitle:timerAttrStr forState:UIControlStateNormal];
    }else{
        _timer.fireDate = [NSDate distantFuture];
        NSAttributedString * timerAttrStr = [[NSAttributedString alloc] initWithString:@"重新获取" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor blackColor]}];
        [_timerButton setAttributedTitle:timerAttrStr forState:UIControlStateNormal];
        _timerButton.userInteractionEnabled = YES;
    }
}
-(void)timerAction:(UIButton *)button{
//    重新发短信
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNum zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            _seconds = 60;
            NSLog(@"获取短息验证码成功");
            _timer.fireDate = [NSDate distantPast];
            [self initForSuccessOrErrorView:@"发送成功"];
        } else {
            NSLog(@"错误信息：%@",error);
            [self initForSuccessOrErrorView:@"发送失败,请重试"];
        }
    }];
}

#pragma mark
#pragma mark ============= 页面提示 成功/失败 信息
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
#pragma mark ============= 设置页面基本设置
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"爱烘焙爱生活";
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
