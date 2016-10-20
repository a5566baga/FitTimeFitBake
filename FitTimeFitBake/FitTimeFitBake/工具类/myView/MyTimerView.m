//
//  MyTimerView.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/14.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MyTimerView.h"

@interface MyTimerView ()

@property(nonatomic, strong)UILabel * hourLabel;
@property(nonatomic, strong)UILabel * minLabel;
@property(nonatomic, strong)UILabel * secLabel;
@property(nonatomic, strong)UILabel * maoLabel1;
@property(nonatomic, strong)UILabel * maoLabel2;

@property(nonatomic, copy)NSString * benginTime;
@property(nonatomic, copy)NSString * endTime;
//未开始的显示
@property(nonatomic, strong)UILabel * notNowLabel;
//结束的样式
@property(nonatomic, strong)UILabel * endLabel;
@property(nonatomic, assign)NSInteger leftTime;

@property(nonatomic, strong)NSTimer * timer;

@end

@implementation MyTimerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma mark
#pragma mark ======== 设置样式,倒计时
-(void)initForView:(NSInteger)leftTime{
    
    NSInteger hour = leftTime/60/60;
    NSInteger min = leftTime/60%60;
    NSInteger sec = leftTime%60;
    
    float labelWidth = (self.width-10)/3;
    _hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, labelWidth)];
    _hourLabel.text = [NSString stringWithFormat:@"%02ld", hour];
    _hourLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_hourLabel];
    
    _minLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth+5, 0, labelWidth, labelWidth)];
    _minLabel.text = [NSString stringWithFormat:@"%02ld", min];
    _minLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_minLabel];
    
    _secLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-labelWidth, 0, labelWidth, labelWidth)];
    _secLabel.text = [NSString stringWithFormat:@"%02ld", sec];
    _secLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_secLabel];
    
    _maoLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth, 0, 5, labelWidth)];
    _maoLabel1.text = @":";
    _maoLabel1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_maoLabel1];
    
    _maoLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(2*labelWidth+5, 0, 5, labelWidth)];
    _maoLabel2.text = @":";
    _maoLabel2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_maoLabel2];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(myTimer) userInfo:nil repeats:YES];
}
//未开始
-(void)initForNotNowView:(NSString *)beginTime{
    _notNowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _notNowLabel.textAlignment = NSTextAlignmentCenter;
    _notNowLabel.textColor = [UIColor redColor];
    _notNowLabel.text = @"活动尚未开始";
    [self addSubview:_notNowLabel];
}
-(void)initForOverView{
    _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _endLabel.textAlignment = NSTextAlignmentCenter;
    _endLabel.textColor = [UIColor redColor];
    _endLabel.text = @"活动已经结束";
    [self addSubview:_endLabel];
}
-(void)myTimer{
    if (_leftTime > 0) {
        _leftTime--;
        NSInteger hour = _leftTime/60/60;
        NSInteger min = _leftTime/60%60;
        NSInteger sec = _leftTime%60;
        _hourLabel.text = [NSString stringWithFormat:@"%02ld", hour];
        _minLabel.text = [NSString stringWithFormat:@"%02ld", min];
        _secLabel.text = [NSString stringWithFormat:@"%02ld", sec];
    }else{
        [self initForOverView];
    }
}
#pragma mark
#pragma mark ======== 计时器数字颜色, 时间字符串
-(void)setTimerView:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor{
    _hourLabel.textColor = textColor;
    _hourLabel.font = font;
    _hourLabel.backgroundColor = bgColor;
    
    _minLabel.textColor = textColor;
    _minLabel.font = font;
    _minLabel.backgroundColor = bgColor;
    
    _secLabel.textColor = textColor;
    _secLabel.font = font;
    _secLabel.backgroundColor = bgColor;
    
    _maoLabel1.font = font;
    _maoLabel2.font = font;
    
    _notNowLabel.font = font;
    _endLabel.font = font;
}
-(void)setTimerBeginTime:(NSString *)beginTime endTime:(NSString *)endTime{
    _benginTime = beginTime;
    _endTime = endTime;
    
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * beginDate = [fmt dateFromString:_benginTime];
    NSDate * endDate = [fmt dateFromString:_endTime];
    
    NSDate * nowDate = [[NSDate alloc] init];
    
     double secs = [beginDate timeIntervalSinceDate:nowDate];
    if (secs < 0) {
//        已经开始
        double leftSec = [endDate timeIntervalSinceDate:nowDate];
        _leftTime = leftSec;
        [self initForView:_leftTime];
    }else{
//        没有开始
        fmt.dateFormat = @"yyyy年MM月dd日开始";
        NSString * beginStr = [fmt stringFromDate:beginDate];
        [self initForNotNowView:beginStr];
    }
}


@end
