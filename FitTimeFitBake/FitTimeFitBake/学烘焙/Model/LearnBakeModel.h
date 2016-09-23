//
//  LearnBakeModel.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/20.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item_Bake;
@interface LearnBakeModel : NSObject

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) NSInteger style;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, copy) NSString *moreLink;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, strong) NSArray<Item_Bake *> *item;

@end
@interface Item_Bake : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger groupNum;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *groupBuyEndTime;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) BOOL isValidActivity;

@property (nonatomic, assign) NSInteger joinNum;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isSuccessGroupBuy;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, assign) NSInteger categoryItemId;

@property (nonatomic, assign) NSInteger groupBuyContentId;

@property (nonatomic, assign) NSInteger activityContentId;

@property (nonatomic, copy) NSString *groupBuyBeginTime;

@property (nonatomic, assign) BOOL isActivity;

@property (nonatomic, assign) NSInteger showFlag;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, copy) NSString *introduce;

@end

