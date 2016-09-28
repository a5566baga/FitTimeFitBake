//
//  TuanShopModel.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/27.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "TuanShopModel.h"

@implementation TuanShopModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    // 模型的desc属性对应着字典中的description
    return @{@"descriptions" : @"description"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"component" : [Component_Tuan class]};
}

@end


@implementation Item_Tuan

+ (NSDictionary *)objectClassInArray{
    return @{@"image" : [Image_Tuan class]};
}

@end


@implementation Image_Tuan

@end


@implementation Component_Tuan

@end


