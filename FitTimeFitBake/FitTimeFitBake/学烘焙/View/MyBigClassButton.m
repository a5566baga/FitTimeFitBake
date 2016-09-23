//
//  MyBigClassButton.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/22.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MyBigClassButton.h"

@implementation MyBigClassButton

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.height, self.height);
    self.imageView.layer.cornerRadius = self.height/2;
    
    self.titleLabel.frame = CGRectMake(self.height+10, 0, self.width-self.height-10, self.height);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
}

@end
