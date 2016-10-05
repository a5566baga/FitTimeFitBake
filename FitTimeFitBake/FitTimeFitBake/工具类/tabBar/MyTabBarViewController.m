//
//  MyTabBarViewController.m
//  FitTimeFitBake
//
//  Created by 张增强 on 16/9/20.
//  Copyright © 2016年 张增强. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "MyNavigationViewController.h"
#import "LearnBakeViewController.h"
#import "BakeWayViewController.h"
#import "ShoppingViewController.h"
#import "QuestionViewController.h"
#import "MeViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController
+(void)initialize{
//    修改tabBar的字体颜色
    NSDictionary * attribute = @{NSFontAttributeName:[UIFont fontWithName:@"BebasNeue" size:12],NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary * selectedAttr =  @{NSFontAttributeName:[UIFont fontWithName:@"BebasNeue" size:12],NSForegroundColorAttributeName:[UIColor colorWithRed:0.65 green:0.22 blue:0.19 alpha:1.00]};
    
    //凡事有UI_APPEARANCE_SELECTOR都可以设置成全局。
    //eg: [UINavigationBar appearance]
    UITabBarItem * item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attribute forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStyleWithImage:@"book" selectImage:@"book_sel" viewController:[[LearnBakeViewController alloc] init] title:@"学烘焙"];
    
    [self setStyleWithImage:@"quanzi" selectImage:@"quanzi_sel" viewController:[[BakeWayViewController alloc] init] title:@"烘焙圈"];
    
    [self setStyleWithImage:@"shop" selectImage:@"shop_sel" viewController:[[ShoppingViewController alloc] init] title:@"团装备"];
    
    [self setStyleWithImage:@"question" selectImage:@"question_sel" viewController:[[QuestionViewController alloc] init] title:@"问答"];
    
    [self setStyleWithImage:@"me" selectImage:@"me_sel" viewController:[[MeViewController alloc] init] title:@"小窝"];
    
}

-(void)setStyleWithImage:(NSString *)imageStr selectImage:(NSString *)selectImageStr viewController:(UIViewController *)viewController title:(NSString *)title{
    viewController.title = title;
    MyNavigationViewController * nvc = [[MyNavigationViewController alloc] initWithRootViewController:viewController];
    [nvc.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [nvc.tabBarItem setImage:[UIImage imageNamed:imageStr]];
    [nvc.tabBarItem setSelectedImage:[UIImage imageNamed:selectImageStr]];
    
    [self addChildViewController:nvc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
