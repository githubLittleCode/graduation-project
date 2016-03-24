//
//  ContentViewController.h
//  practice1
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "ViewController.h"


@class MyTableViewCellModel;
@class BookViewController;

@interface ContentViewController : ViewController
{
    NSMutableArray *dataArray;
    NSMutableArray *commentArray;
    UITableView *_tableView;
    BOOL checkChapter;
    //评论区cell高度
    CGFloat cellHeight;
    //评论去选中单元格下标
    NSInteger selectIndex;

}
@property(nonatomic,strong)MyTableViewCellModel *model;

@property(nonatomic,strong)MyTableViewCellModel *selectModel;


@property(nonatomic,weak)BookViewController *bookVc;

@end
