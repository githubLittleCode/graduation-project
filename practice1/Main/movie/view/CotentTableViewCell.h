//
//  CotentTableViewCell.h
//  practice1
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentViewModel;

@interface CotentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentNameLabel;
@property(nonatomic,strong)ContentViewModel *model;

@end
