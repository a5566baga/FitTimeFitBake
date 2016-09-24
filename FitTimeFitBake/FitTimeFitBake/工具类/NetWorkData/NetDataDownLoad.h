//
//  NetDataDownLoad.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/23.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>

@protocol NetDataDownLoadDelegate <NSObject>

- (void)downloadDataFinshed;
- (void)downloadDataFailed;

@end

@interface NetDataDownLoad : NSObject

@property(nonatomic, strong)NSDictionary * dataDic;
@property (nonatomic,weak) id<NetDataDownLoadDelegate> delegate;
@property(nonatomic, strong)AFHTTPSessionManager * manager;

-(void)GET:(NSString *)Url params:(NSDictionary *)params;

@end
