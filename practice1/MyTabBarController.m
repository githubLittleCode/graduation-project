//
//  MyTabBarController.m
//  practice1
//
//  Created by Apple on 15/12/8.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "MyTabBarController.h"
#import "ButtonControl.h"
#import "MySelfViewController.h"
#import "BookViewController.h"
#import "MyNavigatioinController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self _creatTabBar];
    self.tabBar.translucent = NO;
    
}



-(void)_creatTabBar
{
    CGFloat width = kScreenWidth/3;
    CGFloat height = self.tabBar.frame.size.height;
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"daohanglan.jpg"];
    
    for (UIView *view in self.tabBar.subviews) {
        
       
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    
    NSArray *imageArray = @[
                            
          [UIImage imageNamed:@"more_info.png"],
          [UIImage imageNamed:@"more_search.png"],

           [UIImage imageNamed:@"msg_select_new.png"],

                            ];
   
    NSArray *titleArray = @[@"书架", @"搜索", @"我"];
    
    for (int i = 0; i < titleArray.count; i++) {
        
        ButtonControl *button = [[ButtonControl alloc]initWithFrame:CGRectMake(i * width, 0, width, height)image:imageArray[i] titlt:titleArray[i]];
    
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
          button.tag = i;

        if (_selectView == nil) {
            _selectView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
//            _selectView.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
            _selectView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
            [self.tabBar addSubview:_selectView];
        }
        
        
        [self.tabBar addSubview:button];
        
        
    }
    




}

-(void)viewWillAppear:(BOOL)animated
{

    //显示调用，不写是在[self _creatTabBar]之后调用，会显示storyBoard里面的东西。
      [super viewWillAppear:animated];
    [self _creatTabBar];

}


-(void)buttonAction:(UIButton *)sender
{

    self.selectedIndex = sender.tag;
    
    [UIView animateWithDuration:0.15 animations:^{
         _selectView.center = sender.center;
    }];
   

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
