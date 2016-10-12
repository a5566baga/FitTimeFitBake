//
//  SelectTypeModel.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/10.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Comment_Type,Visitclient_Type,Step_Type,Material_Type;
@interface SelectTypeModel : NSObject

@property (nonatomic, strong) NSArray *classifyRecommend;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *prefixTitle;

@property (nonatomic, strong) NSArray *classifyId;

@property (nonatomic, assign) NSInteger dishNum;

@property (nonatomic, copy) NSString *coverTitle;

@property (nonatomic, assign) NSInteger likeNum;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, strong) NSArray<Step_Type *> *step;

@property (nonatomic, assign) NSInteger thankNum;

@property (nonatomic, copy) NSString *tip;

@property (nonatomic, strong) NSArray<Material_Type *> *material;

@property (nonatomic, copy) NSString *clientName;

@property (nonatomic, strong) Comment_Type *comment;

@property (nonatomic, copy) NSString *coverSummary;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger commentNum;

@property (nonatomic, copy) NSString *clientSign;

@property (nonatomic, assign) NSInteger beautyNum;

@property (nonatomic, strong) NSArray *classifyName;

@property (nonatomic, assign) NSInteger hateNum;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger rewardNum;

@property (nonatomic, assign) NSInteger contentRecipeId;

@property (nonatomic, assign) NSInteger shareNum;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger collectNum;

@property (nonatomic, copy) NSString *classifyPrefixTitle;

@property (nonatomic, copy) NSString *coverImage;

@property (nonatomic, strong) Visitclient_Type *visitClient;

@property (nonatomic, assign) NSInteger easyNum;

@property (nonatomic, assign) NSInteger contentClientTotalId;

@property (nonatomic, assign) CGFloat hotNum;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *shareTitle;

@property (nonatomic, assign) NSInteger clientId;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *clientImage;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger visitNum;

@end
@interface Comment_Type : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray *data;

@end

@interface Visitclient_Type : NSObject

@property (nonatomic, copy) NSString *rewardTime;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, assign) NSInteger sendClientId;

@property (nonatomic, copy) NSString *clientName;

@property (nonatomic, assign) NSInteger rewardNum;

@property (nonatomic, assign) NSInteger thankNum;

@property (nonatomic, copy) NSString *thankTime;

@property (nonatomic, copy) NSString *visitTime;

@property (nonatomic, assign) NSInteger contentClientRewardId;

@property (nonatomic, assign) NSInteger shareNum;

@property (nonatomic, assign) NSInteger likeNum;

@property (nonatomic, assign) NSInteger visitNum;

@property (nonatomic, copy) NSString *clientImage;

@property (nonatomic, assign) NSInteger recvClientId;

@property (nonatomic, assign) NSInteger contentType;

@property (nonatomic, assign) NSInteger contentClientId;

@property (nonatomic, assign) NSInteger clientId;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *collectTime;

@property (nonatomic, copy) NSString *likeTime;

@property (nonatomic, copy) NSString *shareTime;

@property (nonatomic, assign) NSInteger collectNum;

@end

@interface Step_Type : NSObject

@property (nonatomic, assign) NSInteger contentRecipeStepId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *text;

@end

@interface Material_Type : NSObject

@property (nonatomic, assign) NSInteger contentRecipeMaterialId;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *weight;

@end

