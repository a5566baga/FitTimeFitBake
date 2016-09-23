//
//  MyFoundButton.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/22.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MyFoundButton.h"

@implementation MyFoundButton

-(void)layoutSubviews{
    [super layoutSubviews];
    float margin = 10;
    self.imageView.frame = CGRectMake(margin, margin, self.width-2*margin, self.width-2*margin);
    self.imageView.layer.cornerRadius = (self.width-2*margin)/2;
    self.titleLabel.frame = CGRectMake(0, self.width, self.width, 20);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor blackColor];
}

@end
