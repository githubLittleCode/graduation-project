//
//  ReadHistoryViewController.h
//  practice1
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "ViewController.h"
@class MyTableViewCellModel;

@interface ReadHistoryViewController : ViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    //存储从数据库取出来的数据的数组
    NSMutableArray *dataArray;
    //存储所有电子书信息的数组
    NSMutableArray *modelDataArray;
    //存储章节目录信息的数组
    NSMutableArray *commentArray;
    MyTableViewCellModel *model1;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;

@end
