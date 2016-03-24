//
//  ContentTableViewCell2.m
//  practice1
//
//  Created by Apple on 15/12/24.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "ContentTableViewCell2.h"
#import "MyTableViewCellModel.h"
#import "UIImageView+WebCache.h"
@implementation ContentTableViewCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(MyTableViewCellModel *)model{
    if (_model != model) {
        _model = model;
        
        _view.layer.cornerRadius = _view.frame.size.width/2;
        _view.layer.masksToBounds = YES;
        [_view sd_setImageWithURL:_model.imageUrl];
        _titleLabel.text = _model.title;
        _timeLabel.text = [NSString stringWithFormat:@"%.1f", [_model.average floatValue]];
        _commentLabel.text = _model.comment;
        
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
