//
//  PinTuanTableViewCell.h
//  FitTimeFitBake
//
//  Created by 张增强 on 16/10/10.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinTuanTableViewCell : UITableViewCell

@property(nonatomic, strong)void(^scrollToTop)();
@property(nonatomic, strong)void(^scrollToDown)();

-(void)setCellValue:(NSString *)htmlStr;

@end
