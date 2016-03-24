//
//  ContentTableViewCell2.h
//  practice1
//
//  Created by Apple on 15/12/24.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTableViewCellModel;

@interface ContentTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *view;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (nonatomic,strong)MyTableViewCellModel *model;
@end
