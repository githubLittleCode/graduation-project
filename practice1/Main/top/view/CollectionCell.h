//
//  CollectionCell.h
//  practice1
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTableViewCellModel;

@interface CollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *bookNameLabel;
@property(nonatomic,weak)MyTableViewCellModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
