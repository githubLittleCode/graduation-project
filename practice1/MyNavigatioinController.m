//
//  MyNavigatioinController.m
//  practice1
//
//  Created by Apple on 15/12/8.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "MyNavigatioinController.h"

@interface MyNavigatioinController ()

@end

@implementation MyNavigatioinController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"daohanglan.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName:[UIColor whiteColor]
                          };
    self.navigationBar.titleTextAttributes = dic;
    
//    self.navigationBar.translucent = NO;
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    UIStatusBarStyle style = [self.topViewController preferredStatusBarStyle];
    return style;
   

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
