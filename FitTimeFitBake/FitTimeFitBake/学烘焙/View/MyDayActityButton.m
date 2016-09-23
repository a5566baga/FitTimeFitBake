//
//  MyDayActityButton.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/22.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MyDayActityButton.h"
#import <UIImage+GIF.h>

@interface MyDayActityButton ()

@property(nonatomic, strong)UILabel * numLael;

@end

@implementation MyDayActityButton

-(void)layoutSubviews{
    [super layoutSubviews];
    float width = self.width/5;
    self.titleLabel.frame = CGRectMake(0, 0, width*4, self.height);
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;;
    
    _numLael = [[UILabel alloc] init];
    _numLael.frame = CGRectMake(width*4, 0, width, self.height);
    _numLael.textAlignment = NSTextAlignmentRight;
    _numLael.textColor = [UIColor grayColor];
    _numLael.font = [UIFont systemFontOfSize:13];
    _numLael.text = [NSString stringWithFormat:@"%@人参与", _numPepleStr];
    [self addSubview:_numLael];
    
    if ([_gifNameStr isEqualToString:@"new"]) {
        CGSize mySize = CGSizeMake(CGFLOAT_MAX, self.height);
        CGSize size = [self.titleLabel.text boundingRectWithSize:mySize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        _flagPic = [[UIImageView alloc] init];
        _flagPic.frame = CGRectMake(size.width+5, 2, 35, 13);
        UIImage * gifImg = [UIImage sd_animatedGIFNamed:_gifNameStr];
        _flagPic.image = gifImg;
        [self addSubview:_flagPic];
    }
}

@end
