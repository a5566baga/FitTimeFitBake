//
//  NiuModel.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/13.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Image_Niu;
@interface NiuModel : NSObject


@property (nonatomic, copy) NSString *feature;

@property (nonatomic, assign) NSInteger itemType;

@property (nonatomic, copy) NSString *coverSummary;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *clientName;

@property (nonatomic, copy) NSString *clientSign;

@property (nonatomic, assign) NSInteger contentItemId;

@property (nonatomic, strong) NSArray<Image_Niu *> *image;

@property (nonatomic, assign) NSInteger beautyNum;

@property (nonatomic, copy) NSString *link;

@property (nonatomic, assign) NSInteger payPrice;

@property (nonatomic, assign) NSInteger easyNum;

@property (nonatomic, copy) NSString *shareTitle;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) CGFloat hotNum;

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

//@property (nonatomic, copy) NSString *description;


@end
@interface Image_Niu : NSObject

@property (nonatomic, assign) NSInteger contentItemImageId;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *url;

@end

