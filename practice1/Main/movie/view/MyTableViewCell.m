//
//  MyTableViewCell.m
//  practice1
//
//  Created by Apple on 15/12/9.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "MyTableViewCell.h"
#import "MyTableViewCellModel.h"
#import "UIImageView+WebCache.h"
#import "StarView.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code

}


-(void)setModel:(MyTableViewCellModel *)model
{
    _model = model;
    
    NSString *medium = [_model.imageDic objectForKey:@"medium"];
    NSURL *url = [NSURL URLWithString:medium];
    
    [_image sd_setImageWithURL:url];
    
    _title.text = _model.title;
    
    _year.text = model.year;
    
    _average.text  =[NSString stringWithFormat:@"%.1f",[_model.average floatValue]];
    
    
    StarView *star = [[StarView alloc]initWithFrame:CGRectMake(0, 0, 0, 25)];
    
    star.rating = [_model.average floatValue];
//    _starView.backgroundColor = [UIColor grayColor];
    [_starView addSubview:star];
    
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
