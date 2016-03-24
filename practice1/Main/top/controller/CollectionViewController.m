//
//  CollectionViewController.m
//  practice1
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionCell.h"
#import "ContentViewController.h"
@interface CollectionViewController ()  <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    

    
}

#pragma mark UIcollectionView delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return _dataArray.count
    ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    cell.backgroundColor = [UIColor colorWithWhite:0.843 alpha:1.000];
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyTableViewCellModel *model = _dataArray[indexPath.row];
    ContentViewController *contentVC = [[ContentViewController alloc]init];
    contentVC.model = model;
    [self.navigationController pushViewController:contentVC animated:YES];
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
