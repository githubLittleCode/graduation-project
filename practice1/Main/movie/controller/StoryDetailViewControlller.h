//
//  StoryDetailViewControlller.h
//  practice1
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SinaWeibo;
@class ContentViewModel;
@class MyTableViewCellModel;

@interface StoryDetailViewControlller : UIViewController <UIWebViewDelegate, UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataArray;
    NSMutableArray *_dataSelfArray;
    SinaWeibo *_sinaweibo;
    ContentViewModel *model ;
}
@property (nonatomic, weak) MyTableViewCellModel *bookModel;
@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,strong)NSArray *modelArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;




@end
