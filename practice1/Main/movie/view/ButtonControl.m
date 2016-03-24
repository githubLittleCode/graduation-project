//
//  ButtonControl.m
//  practice1
//
//  Created by Apple on 15/12/8.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "ButtonControl.h"

@implementation ButtonControl

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image titlt:(NSString *)title 
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2 -10, 5, 20, 20)];
        
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        CGFloat height = imageView.frame.size.height;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, height + 5, self.frame.size.width, 20)];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:label];
        [self addSubview:imageView];
        
    }
   
    return self;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
