//
//  NiuTableViewCell.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/13.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NiuModel.h"
#import "BakeWayModel.h"

@interface NiuTableViewCell : UITableViewCell

@property(nonatomic, copy)void(^changeTypeBlock)(NSInteger index);

/**
 *  上面电器推荐
 */
-(void)setUpModel:(NiuModel *)upModels;
/**
 *  类别
 */
-(void)setUpArray:(NSArray *)titleArray index:(NSInteger )index;
/**
 * 下面的cell样式
 */
-(void)setDownModel:(BakeWayModel *)downModel;

@end
