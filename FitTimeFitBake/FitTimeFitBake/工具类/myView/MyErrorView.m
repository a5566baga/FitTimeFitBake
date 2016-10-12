//
//  MyErrorView.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/12.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MyErrorView.h"

@interface MyErrorView ()

@property(nonatomic, strong)UIImageView * errPic;

@end

@implementation MyErrorView

-(UIView *)createErrorView{
    UIView * errView = [[UIView alloc] initWithFrame:self.frame];
    
    return errView;
}

@end
