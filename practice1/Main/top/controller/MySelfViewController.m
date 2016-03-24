//
//  MySelfViewController.m
//  practice1
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "MySelfViewController.h"
#import "BookViewController.h"
#import "MyTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CollectionViewController.h"
#import "ReadHistoryViewController.h"
#import "MyTableViewCellModel.h"

@interface MySelfViewController ()

@end

@implementation MySelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我";
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor grayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    
    NSUInteger size =  [[SDImageCache sharedImageCache]getSize];
    sizeLabel.text = [NSString stringWithFormat:@"%.1f M", size/1024/1024.0];
    
    _imageView.layer.cornerRadius = _imageView.frame.size.width/2;
    _imageView.layer.masksToBounds = YES;
    if (_bookVc.selectImage == 1) {
        
        _imageView.image = [UIImage imageNamed:@"woman.jpg"];
    }
    else
         _imageView.image = [UIImage imageNamed:@"man.jpg"];
    
    NSUserDefaults *de = [NSUserDefaults standardUserDefaults]
    ;
    _accountLabel.text = [de objectForKey:@"account"];
    
    
}

- (void)setBookVc:(BookViewController *)bookVc{
   
    if (_bookVc != bookVc) {
        _bookVc = bookVc;
        _bookVc.block = ^(){
          
           [self setCollectionModel:_bookVc.collectionModel];
        };
    }
}

- (void)setCollectionModel:(MyTableViewCellModel *)collectionModel{
    
    if (_collectionModel != collectionModel) {
        _collectionModel = collectionModel;
        
        [_collectionArray addObject:_collectionModel];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 1) {
        exit(0);
    }
    if (indexPath.section == 2&& indexPath.row == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"确定要清楚缓存吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache]clearDisk];
            sizeLabel.text = @"0.0 M";
        }]];
        
        [self presentViewController:alert animated:YES completion:NULL];
    }
    
    else if (indexPath.row ==0 && indexPath.section == 1)
    {
    
        CollectionViewController *collectionVc = [self.storyboard instantiateViewControllerWithIdentifier:@"collectionVc"];
        collectionVc.dataArray = [NSMutableArray arrayWithArray:_collectionArray];
        
        [self.navigationController pushViewController:collectionVc animated:YES];
    
    }
    else if (indexPath.row ==1 && indexPath.section == 1)
    {
        ReadHistoryViewController *readVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ReadHistroy"];
        [self.navigationController pushViewController:readVc animated:YES];
        
    }

    
    
    
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
