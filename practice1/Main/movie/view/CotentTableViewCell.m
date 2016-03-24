//
//  CotentTableViewCell.m
//  practice1
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "CotentTableViewCell.h"
#import "ContentViewModel.h"
@implementation CotentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ContentViewModel *)model
{
    _model = model;
    
    _contentLabel.text = _model.content;
    _contentLabel.textColor = [UIColor blackColor];
    
    _contentNameLabel.textColor = [UIColor blackColor];
    _contentNameLabel.text = _model.contentName;


}

@end
