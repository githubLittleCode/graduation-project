//
//  BookViewController.h
//  practice1
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "ViewController.h"

typedef void(^MyBlocks)();

@class MyTableViewCellModel;
@class ContentViewController;

@interface BookViewController : ViewController <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    UICollectionView * _collectionView;
    UIView * _viewTableView ;
    NSMutableArray * dataArray;
//    UIImage *_selectImage;
//    NSString *_account;
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,assign) NSInteger selectImage;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,strong) MyBlocks block;

@property (nonatomic,strong) MyTableViewCellModel *collectionModel;
@property (strong, nonatomic) UIView *viewForBegin;
@property (strong, nonatomic) UITextField *accountTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIImageView *womanImageView;
@property (strong, nonatomic) UIImageView *manImageVIew;
@property (strong, nonatomic) UIButton *loadButton;
@property (strong, nonatomic) UIButton *logInButton;
@end
