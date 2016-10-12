//
//  MyBackTopButton.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/12.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MyBackTopButton.h"

@implementation MyBackTopButton

+(UIButton *)backButton{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"backTop"] forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    return backButton;
}

@end
