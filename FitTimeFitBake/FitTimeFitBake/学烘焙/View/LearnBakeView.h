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
#import "PinShoppingViewController.h"
#import "ChoiceMenuViewController.h"
#import "FoundViewController.h"
#import "HotDetailViewController.h"
#import "RecipeGuyViewController.h"
#import "DailyActivityViewController.h"
#import "BigClassViewController.h"
#import "NiuDetailViewController.h"
#import "SelectTypeViewController.h"
#import "LearnBakeTableViewCell.h"

@interface LearnBakeView : UIView

@property(nonatomic, strong)LearnBakeTableViewCell * cell;

//轮播图跳转
@property(nonatomic, copy)void(^goToPicController)(ScrollViewDetailViewController * vc, NSString * typeStr, NSString * idStr);

/**
 分类食谱的跳转
 */
@property(nonatomic, copy)void(^goToFoodTypeDetailController)(AllTypeViewController * vc, NSString * type, NSString * idStr);
@property(nonatomic, copy)void(^goToSelectTypeDetailController)(SelectTypeViewController * vc, NSString * type, NSString * idStr);

/**
 拼团的跳转
 */
@property(nonatomic, strong)void(^goToTuanVCController)();
@property(nonatomic, strong)void(^goToPinShoppingDetailController)(PinShoppingViewController * vc, NSString * type, NSString * idStr);

/**
 精选菜单的跳转
 */
@property(nonatomic, strong)void(^goToChoiceMenuDetailController)(ChoiceMenuViewController * vc, NSString * type, NSString * idStr);

/**
 发现的跳转
 */
@property(nonatomic, strong)void(^goToFoundDetialController)(FoundViewController * vc, NSString * type, NSString * idStr);

/**
 热门的跳转
 */
@property(nonatomic, strong)void(^goToHotDetailController)(HotDetailViewController * vc, NSString * type, NSString * idStr);

/**
 食谱达人跳转
 */
@property(nonatomic, strong)void(^goToRecioeDetailController)(RecipeGuyViewController * vc, NSString * type, NSString * idStr);

/**
 日常活动的跳转
 */
@property(nonatomic, strong)void(^goToDailyDetailController)(DailyActivityViewController * vc, NSString * type, NSString * idStr);

/**
 大课堂的跳转
 */
@property(nonatomic, strong)void(^goToBigClassDetailController)(BigClassViewController * vc, NSString * type, NSString * idStr);

/**
 牛气部落的跳转
 */
@property(nonatomic, strong)void(^goToNiuMemberDetailController)(NiuDetailViewController * vc, NSString * type, NSString * idStr);


@end
