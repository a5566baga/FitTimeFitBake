//
//  QuestionModel.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/28.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

@interface QuestionModel : NSObject

@property (nonatomic, assign) NSInteger contentQuestionAnswerTimelineId;

@property (nonatomic, copy) NSString *coverSummary;

@property (nonatomic, copy) NSString *modifyTime;

@property (nonatomic, copy) NSString *clientName;

@property (nonatomic, copy) NSString *clientSign;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger beautyNum;

@property (nonatomic, copy) NSString *contentCreateTime;

@property (nonatomic, assign) NSInteger easyNum;

@property (nonatomic, copy) NSString *shareTitle;

@property (nonatomic, assign) NSInteger hotNum;

@property (nonatomic, assign) NSInteger operation;

@property (nonatomic, assign) NSInteger answerNum;

@property (nonatomic, copy) NSString *clientImage;

@property (nonatomic, assign) NSInteger contentQuestionId;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *coverImage;

@property (nonatomic, copy) NSString *coverTitle;

@property (nonatomic, assign) NSInteger popularity;

@property (nonatomic, assign) NSInteger contentId;

@property (nonatomic, assign) NSInteger clientId;

@property (nonatomic, copy) NSString *prefixTitle;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *descriptions;

@end
