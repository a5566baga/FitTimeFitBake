//
//  TuanShopModel.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/27.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>



@class Item_Tuan,Image_Tuan,Component_Tuan;
@interface TuanShopModel : NSObject


@property (nonatomic, copy) NSString *beginTime;

@property (nonatomic, copy) NSString *prefixTitle;

@property (nonatomic, copy) NSString *couponLink;

@property (nonatomic, assign) NSInteger contentGroupbuyId;

@property (nonatomic, copy) NSString *coverTitle;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger groupBuyType;

@property (nonatomic, assign) BOOL isJoin;

@property (nonatomic, copy) NSString *descriptions;

@property (nonatomic, copy) NSString *clientName;

@property (nonatomic, copy) NSString *coverSummary;

@property (nonatomic, assign) NSInteger sort;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *clientSign;

@property (nonatomic, strong) NSArray<Component_Tuan *> *component;

@property (nonatomic, assign) NSInteger beautyNum;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, assign) NSInteger groupNum;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) BOOL isSuccess;

@property (nonatomic, assign) NSInteger isShow;

@property (nonatomic, copy) NSString *coverImage;

@property (nonatomic, assign) BOOL haveCoupon;

@property (nonatomic, assign) NSInteger easyNum;

@property (nonatomic, assign) NSInteger couponPrice;

@property (nonatomic, assign) NSInteger hotNum;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, strong) Item_Tuan *item;

@property (nonatomic, copy) NSString *shareTitle;

@property (nonatomic, assign) NSInteger clientId;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *clientImage;

@property (nonatomic, assign) NSInteger point;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) NSArray *joinClient;

@property (nonatomic, assign) NSInteger amount;


@end

@interface Item_Tuan : NSObject

@property (nonatomic, copy) NSString *feature;

@property (nonatomic, copy) NSString *coverSummary;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *clientName;

@property (nonatomic, copy) NSString *clientSign;

@property (nonatomic, assign) NSInteger contentItemId;

@property (nonatomic, strong) NSArray<Image_Tuan *> *image;

@property (nonatomic, assign) NSInteger beautyNum;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) NSInteger payPrice;

@property (nonatomic, assign) NSInteger easyNum;

@property (nonatomic, copy) NSString *shareTitle;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger hotNum;

@property (nonatomic, copy) NSString *clientImage;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *coverImage;

@property (nonatomic, copy) NSString *coverTitle;

@property (nonatomic, assign) NSInteger originPrice;

@property (nonatomic, copy) NSString *model;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, assign) NSInteger clientId;

@property (nonatomic, copy) NSString *prefixTitle;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *description;

@end

@interface Image_Tuan : NSObject

@property (nonatomic, assign) NSInteger contentItemImageId;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *url;

@end

@interface Component_Tuan : NSObject

@property (nonatomic, assign) NSInteger contentGroupbuyComponentId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, assign) NSInteger itemContentId;

@property (nonatomic, copy) NSString *modifyTime;

@end

