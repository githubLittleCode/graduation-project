//
//  MyTableViewCell.h
//  practice1
//
//  Created by Apple on 15/12/9.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTableViewCellModel;
@class StarView;

@interface MyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet StarView *starView;


@property (weak, nonatomic) IBOutlet UIImageView *image;


@property (weak, nonatomic) IBOutlet UILabel *average;

@property (weak, nonatomic) IBOutlet UILabel *year;

@property(nonatomic,strong)MyTableViewCellModel *model;

@end
