//
//  StarView.m
//  practice1
//
//  Created by Apple on 15/12/10.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "StarView.h"

@implementation StarView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self _creatView];

    }
    return self;
}

-(void)_creatView
{
    //创建灰色和黄色星星view
    UIImage *yellow = [UIImage imageNamed:@"yellow@2x.png"];
    UIImage *gray = [UIImage imageNamed:@"gray@2x.png"];

    
    yellowStar  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, yellow.size.height * 5, yellow.size.height)];
    
    yellowStar.backgroundColor = [UIColor   colorWithPatternImage:yellow];
    
    UIView *grayStar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, yellow.size.height * 5, yellow.size.height)];
    grayStar.backgroundColor = [UIColor  colorWithPatternImage:gray];
    
    //设置starView的宽度为高度的五倍
    CGFloat starWidth = self.frame.size.height * 5 + 10;
    CGRect selfFrame = self.frame;
    selfFrame.size.width = starWidth;
    self.frame = selfFrame;
    
    //对黄色和灰色星星视图进行缩放使得星星刚好填充starView
    CGFloat scale = self.frame.size.height/yellow.size.height;
    
    grayStar.transform = CGAffineTransformMakeScale(scale, scale);
    yellowStar.transform = CGAffineTransformMakeScale(scale, scale);
      //设置放大后星星视图的起点为(0, 0)
    CGRect f1 = yellowStar.frame;
    CGRect f2 = grayStar.frame;
    
    f1.origin = CGPointZero;
    f2.origin = CGPointZero;
    
    yellowStar.frame = f1;
    grayStar.frame = f2;

    
    
    
    [self addSubview:grayStar];
    [self addSubview:yellowStar];

}

-(void)setRating:(float)rating
{
    //根据评分设置黄色星星的缩放比例
    _rating = rating;
    CGRect fr = yellowStar.frame;
    fr.size.width = _rating/10 * yellowStar.frame.size.width;
    
    yellowStar.frame = fr;

}


@end
