//
//  CollectionCell.m
//  practice1
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "CollectionCell.h"
#import "MyTableViewCellModel.h"
#import "UIImageView+WebCache.h"
@implementation CollectionCell

-(void)setModel:(MyTableViewCellModel *)model
{
    if (_model != model) {
        _model = model;
        
        [_imageView sd_setImageWithURL:_model.imageDic[@"medium"]];
        _bookNameLabel.text = _model.title;
        _typeNameLabel.text =[NSString stringWithFormat:@"类型:%@", _model.subType] ;
        _authorNameLabel.text =[NSString stringWithFormat:@"作者:%@", _model.authorName] ;
    }


}

@end
