//
//  BookCollectionViewCell.m
//  practice1
//
//  Created by Apple on 15/12/20.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "BookCollectionViewCell.h"
#import "MyTableViewCellModel.h"
#import "UIImageView+WebCache.h"

@implementation BookCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(MyTableViewCellModel *)model
{
    if (_model != model) {
        _model = model;
        [_imageView sd_setImageWithURL:_model.imageDic[@"medium"]];
    }

}

@end
