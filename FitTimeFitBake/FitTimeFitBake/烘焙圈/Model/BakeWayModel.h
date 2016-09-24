//
//  BakeWayModel.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/23.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Comment_bakeWay,Data_bakeWay,Visitclient_bakeWay;
@interface BakeWayModel : NSObject

@property (nonatomic, assign) NSInteger likeNum;

@property (nonatomic, assign) NSInteger clientId;

@property (nonatomic, strong) Visitclient_bakeWay *visitClient;

@property (nonatomic, assign) NSInteger commentNum;

@property (nonatomic, copy) NSString *clientName;

@property (nonatomic, assign) BOOL isGoldTitle;

@property (nonatomic, strong) Comment_bakeWay *comment;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) BOOL canShield;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, strong) NSArray<NSString *> *image;

@property (nonatomic, assign) NSInteger rewardNum;

@property (nonatomic, copy) NSString *introduce;

@property (nonatomic, copy) NSString *clientImage;

@end
@interface Comment_bakeWay : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSArray<Data_bakeWay *> *data;

@end

@interface Data_bakeWay : NSObject

@property (nonatomic, copy) NSString *coverSummary;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *clientName;

@property (nonatomic, copy) NSString *clientSign;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger beautyNum;

@property (nonatomic, assign) NSInteger commentContentId;

@property (nonatomic, assign) NSInteger easyNum;

@property (nonatomic, copy) NSString *shareTitle;

@property (nonatomic, assign) NSInteger hotNum;

@property (nonatomic, assign) NSInteger commentClientId;

@property (nonatomic, copy) NSString *clientImage;

@property (nonatomic, copy) NSString *commentClientImage;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *coverImage;

@property (nonatomic, copy) NSString *coverTitle;

@property (nonatomic, assign) NSInteger rootCommentContentId;

@property (nonatomic, copy) NSString *commentClientName;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, assign) NSInteger clientId;

@property (nonatomic, copy) NSString *prefixTitle;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger contentCommentId;

@end

@interface Visitclient_bakeWay : NSObject

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

