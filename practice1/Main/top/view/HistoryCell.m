//
//  HistoryCell.m
//  practice1
//
//  Created by Apple on 16/1/4.
//  Copyright © 2016年 zjj. All rights reserved.
//

#import "HistoryCell.h"
#import "HistoryModel.h"
@implementation HistoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setHistoryModel:(HistoryModel *)historyModel {
    
    if (_historyModel != historyModel) {
        _historyModel = historyModel;
    
        self.chapterLabel.text = _historyModel.chapter;
        self.bookNameLabel.text = _historyModel.bookName;
    }
    
    
}

@end
