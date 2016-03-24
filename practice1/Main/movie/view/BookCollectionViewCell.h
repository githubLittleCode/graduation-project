//
//  BookCollectionViewCell.h
//  practice1
//
//  Created by Apple on 15/12/20.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTableViewCellModel;

@interface BookCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong)MyTableViewCellModel *model;

@end
