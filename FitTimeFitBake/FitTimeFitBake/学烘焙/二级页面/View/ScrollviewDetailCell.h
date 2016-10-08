//
//  ScrollviewDetailCell.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/8.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepModel.h"

@interface ScrollviewDetailCell : UITableViewCell

-(void)setCellStyle:(StepModel *)model index:(NSInteger)index;

@end
