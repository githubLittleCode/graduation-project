//
//  HistoryCell.h
//  practice1
//
//  Created by Apple on 16/1/4.
//  Copyright © 2016年 zjj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HistoryModel;

@interface HistoryCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *bookNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chapterLabel;


@property (weak,nonatomic) HistoryModel *historyModel;

@end
