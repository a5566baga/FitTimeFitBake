//
//  LearnBakeTableViewCell.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/21.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearnBakeModel.h"
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

@interface LearnBakeTableViewCell : UITableViewCell

/**
 轮播图的跳转
 */
@property(nonatomic, copy)void(^goToPicDetail)(ScrollViewDetailViewController * vc, NSString * type, NSString * idStr);

/**
 分类食谱的跳转
 */
@property(nonatomic, copy)void(^goToFoodTypeDetail)(AllTypeViewController * vc, NSString * type, NSString * idStr);
@property(nonatomic, copy)void(^goToSelectTypeDetail)(SelectTypeViewController * vc, NSString * type, NSString * idStr);

/**
 拼团的跳转
 */
@property(nonatomic, strong)void(^goToTuanVC)();
@property(nonatomic, strong)void(^goToPinShoppingDetail)(PinShoppingViewController * vc, NSString * type, NSString * idStr);

/**
 精选菜单的跳转
 */
@property(nonatomic, strong)void(^goToChoiceMenuDetail)(ChoiceMenuViewController * vc, NSString * type, NSString * idStr);

/**
 发现的跳转
 */
@property(nonatomic, strong)void(^goToFoundDetial)(FoundViewController * vc, NSString * type, NSString * idStr);

/**
 热门的跳转
 */
@property(nonatomic, strong)void(^goToHotDetail)(HotDetailViewController * vc, NSString * type, NSString * idStr);

/**
 食谱达人跳转
 */
@property(nonatomic, strong)void(^goToRecioeDetail)(RecipeGuyViewController * vc, NSString * type, NSString * idStr);

/**
 日常活动的跳转
 */
@property(nonatomic, strong)void(^goToDailyDetail)(DailyActivityViewController * vc, NSString * type, NSString * idStr);

/**
 大课堂的跳转
 */
@property(nonatomic, strong)void(^goToBigClassDetail)(BigClassViewController * vc, NSString * type, NSString * idStr);

/**
 牛气部落的跳转
 */
@property(nonatomic, strong)void(^goToNiuMemberDetail)(NiuDetailViewController * vc, NSString * type, NSString * idStr);

-(void)setCellStyle:(LearnBakeModel *)model;

@end
