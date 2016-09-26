//
//  MyZanButton.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/25.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MyZanButton.h"

@implementation MyZanButton

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 2, self.height*0.8, self.height-4);
    self.titleLabel.frame = CGRectMake(self.width-20, 0, 20, self.height);
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
}

@end
