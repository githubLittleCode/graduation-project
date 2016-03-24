//
//  ReadHistoryViewController.m
//  practice1
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "ReadHistoryViewController.h"
#import "HistoryCell.h"
#import "HistoryModel.h"
#import "MyTableViewCellModel.h"
#import "ContentViewModel.h"
#import "StoryDetailViewControlller.h"

@interface ReadHistoryViewController ()

@end

@implementation ReadHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    modelDataArray = [[NSMutableArray alloc]init];
    dataArray = [[NSMutableArray alloc]init];
   
    model1 = [[MyTableViewCellModel alloc]init];
    [self takeMessage];
     _collectionVIew.backgroundColor = [UIColor whiteColor];
    self.title = @"我的阅历";
    
}

- (void)viewWillLayoutSubviews{
    
    commentArray = nil;
    commentArray = [[NSMutableArray alloc]init];
    
    [self loadDataFromSqlite];
}

-(void)takeMessage
{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"us_box" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    
    
    NSArray *arr = dic[@"subjects"];
    
    for (NSDictionary *detailDic in arr) {
        
        
        MyTableViewCellModel *model = [[MyTableViewCellModel alloc]init];
        NSDictionary *messageDic = detailDic[@"subject"];
        model.title = messageDic[@"title"];
        model.plistName = messageDic[@"id"];
        model.plistContentName = [NSString stringWithFormat:@"%@章节名", messageDic[@"id"]];
        model.imageDic = messageDic[@"images"];
        model.year = messageDic[@"year"];
        model.average = [messageDic[@"rating"] objectForKey:@"average"];
        model.subType = [messageDic objectForKey:@"original_title"];
        model.authorName = messageDic[@"subtype"];
        model.detail = [NSString stringWithFormat:@"%@Detail",messageDic[@"id"]];
        
        [modelDataArray addObject:model];
        
    }
    
    
}


- (void)loadDataFromSqlite {
    
    UserDB *userDb = [UserDB sharedUserDB];
    
    dataArray = (NSMutableArray *)[userDb queryData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionView delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HistoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"historyCell" forIndexPath:indexPath];
    cell.historyModel = dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HistoryCell *cell =((HistoryCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0]]);
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StoryDetailViewControlller *storyVc = [story instantiateViewControllerWithIdentifier:@"story"];
    [self marryModel:cell];
    storyVc.bookModel = model1;
    [self takeContent];
    
    //根据当前单元格的章节信息跳转到相应的界面
    int index = 0;
    NSLog(@"%@", commentArray);
    for (int i = 2; i < commentArray.count; i++) {
        ContentViewModel *model = commentArray[i];
        if ([cell.chapterLabel.text isEqualToString:model.content]) {
            index = i - 2;
        }
        else
            continue;
    }
    [commentArray removeObjectAtIndex:0];
    [commentArray removeObjectAtIndex:0];
    
    [self.navigationController pushViewController:storyVc animated:YES];
    storyVc.modelArray = [NSArray arrayWithArray:commentArray];
    commentArray = nil;
    storyVc.selectIndex = (NSInteger)index;
    
    
}

-(void)takeContent
{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:model1.plistName ofType:@"plist"];
    NSArray *data  = [NSArray arrayWithContentsOfFile:path];
    
    NSString *path1 = [[NSBundle mainBundle]pathForResource:model1.plistContentName ofType:@"plist"];
    NSArray *data1 = [NSArray arrayWithContentsOfFile:path1];
    
    NSString *patr = [[NSBundle mainBundle]pathForResource:model1.detail ofType:@"plist"];
    NSArray *detailArray = [NSArray arrayWithContentsOfFile:patr];
    
    [commentArray addObject:[NSNull null]];
    [commentArray addObject:[NSNull null]];
    for (int i = 0; i < data1.count; i++) {
        
        ContentViewModel *modelD = [[ContentViewModel alloc]init];
        modelD.content = data1[i];
        modelD.contentName = data[i];
        modelD.story = detailArray[i];
        modelD.storyName = model1.title;
        [commentArray addObject:modelD];
        
    }
    
}



- (void)marryModel:(HistoryCell *)cell {
    
    
    for (MyTableViewCellModel *model in modelDataArray) {
        if([model.title isEqualToString:cell.bookNameLabel.text]){
            model1 = model;
            return;
        }
        else
            continue;
    }

    
}

@end
