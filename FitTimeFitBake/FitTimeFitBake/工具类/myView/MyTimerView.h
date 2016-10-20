//
//  MyTimerView.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/14.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTimerView : UIView

-(void)setTimerView:(UIColor *)textColor font:(UIFont *)font bgColor:(UIColor *)bgColor;

-(void)setTimerBeginTime:(NSString *)beginTime endTime:(NSString *)endTime;

@end
