//
//  MySelfViewController.h
//  practice1
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "ViewController.h"
@class  MyTableViewCellModel;

@class BookViewController;

@interface MySelfViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
{

    __weak IBOutlet UILabel *sizeLabel;
    NSMutableArray *dataArray;
    NSArray *nameArray;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property(nonatomic,copy)MyTableViewCellModel *collectionModel;
@property(nonatomic,weak)BookViewController *bookVc;
@property(nonatomic,strong)NSMutableArray  *collectionArray;

@end
