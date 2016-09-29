//
//  MyOtherWayLoginButton.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/28.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MyOtherWayLoginButton.h"

@implementation MyOtherWayLoginButton

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.width, self.width);
    self.titleLabel.frame = CGRectMake(0, self.width, self.width, self.height-self.width);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
