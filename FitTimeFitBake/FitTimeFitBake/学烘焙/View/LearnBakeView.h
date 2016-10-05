//
//  LearnBakeView.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/21.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
//要跳转的页面
#import "ScrollViewDetailViewController.h"
#import "AllTypeViewController.h"
@interface LearnBakeView : UIView

@property(nonatomic, copy)void(^goToPicController)(ScrollViewDetailViewController * vc, NSString * typeStr, NSString * idStr);


@end
