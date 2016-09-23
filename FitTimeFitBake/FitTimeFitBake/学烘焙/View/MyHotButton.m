//
//  MyHotButton.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/22.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MyHotButton.h"

@interface MyHotButton ()



@end

@implementation MyHotButton

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.height, self.height);
    self.titleLabel.frame = CGRectMake(self.height+10, 0, self.width-self.height-10, self.height/2);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor blackColor];
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.frame = CGRectMake(self.height+10, CGRectGetMaxY(self.titleLabel.frame), self.width-self.height-10, self.height/2-5);
    _textLabel.textColor = [UIColor grayColor];
    _textLabel.font = [UIFont systemFontOfSize:11];
    _textLabel.textAlignment = NSTextAlignmentLeft;
    _textLabel.text = _detailStr;
    [self addSubview:_textLabel];
}

@end
