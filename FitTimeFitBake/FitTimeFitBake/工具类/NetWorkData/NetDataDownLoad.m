//
//  NetDataDownLoad.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/23.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "NetDataDownLoad.h"

@interface NetDataDownLoad ()

@end

@implementation NetDataDownLoad

-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        NSSet * set = [NSSet setWithObjects:@"text/javascript", @"application/json", nil];
        [_manager.responseSerializer setAcceptableContentTypes:set];
    }
    return _manager;
}

-(void)GET:(NSString *)Url params:(NSDictionary *)params{
    [self.manager GET:Url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _dataDic = [NSDictionary dictionaryWithDictionary:responseObject];
        if (_delegate && [_delegate respondsToSelector:@selector(downloadDataFinshed)]) {
            [_delegate downloadDataFinshed];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_delegate && [_delegate respondsToSelector:@selector(downloadDataFinshed)]) {
            [_delegate downloadDataFailed];
        }
    }];
}

@end
