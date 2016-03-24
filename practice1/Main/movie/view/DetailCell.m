//
//  DetailCell.m
//  practice1
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "DetailCell.h"
#import "ContentViewModel.h"
@implementation DetailCell

- (void)awakeFromNib {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchView)];
    tap.numberOfTapsRequired = 1;
    [self.textView addGestureRecognizer:tap];
    
    [_fontSizeSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    fontSize = 17;
    fontColor = [UIColor blackColor];
    bgColor = [UIColor colorWithRed:0.635 green:0.714 blue:0.561 alpha:1.000];
    self.flag = NO;
}

//随着滑动条的滑动，页面字体随着变化
-(void)sliderAction:(UISlider *)slider
{
    _textView.font = [UIFont systemFontOfSize:slider.value];
    fontSize = slider.value;

}

-(void)setModel:(ContentViewModel *)model
{
    if (_model != model) {
        _model = model;
        
        _chaptNameLabel.text =[NSString stringWithFormat:@"%@ %@", _model.content,_model.contentName];
        _textView.text = _model.story;
        _textView.font =[UIFont systemFontOfSize:fontSize];
        self.backgroundColor = bgColor;
        _textView.textColor = fontColor;
        _topView.hidden = YES;
        _bottomView.hidden = YES;
    }


}

//点击屏幕中央出现设置视图
-(void)touchView
{

    self.flag = !self.flag;
    self.topView.hidden = !self.flag;
    self.chaptNameLabel.hidden = !self.flag;
    if (self.flag == NO) {
        self.textView.transform = CGAffineTransformMakeTranslation(0, -50);
    }
    else if (self.flag == YES)
    {
        self.textView.transform = CGAffineTransformIdentity;
    
    }
    self.bottomView.hidden = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)greenButtonAction:(id)sender {
    
    self.backgroundColor = [UIColor colorWithRed:0.635 green:0.714 blue:0.561 alpha:1.000];
    _textView.textColor = [UIColor blackColor];
    _chaptNameLabel.textColor = [UIColor blackColor];
    fontColor = [UIColor blackColor];
    bgColor = [UIColor colorWithRed:0.635 green:0.714 blue:0.561 alpha:1.000];
}

- (IBAction)grayButtonAction:(id)sender {
    
    self.backgroundColor = [UIColor grayColor];
    _textView.textColor = [UIColor whiteColor];
    _chaptNameLabel.textColor = [UIColor whiteColor];
    fontColor = [UIColor whiteColor];
    bgColor  = [UIColor grayColor];
}

- (IBAction)blackButtonAction:(id)sender {
    
    self.backgroundColor = [UIColor blackColor];
    _textView.textColor = [UIColor whiteColor];
    _chaptNameLabel.textColor = [UIColor whiteColor];
    fontColor = [UIColor whiteColor];
    bgColor = [UIColor blackColor];
}

- (IBAction)whiteButtonAction:(id)sender {
    
    self.backgroundColor = [UIColor whiteColor];
    _textView.textColor = [UIColor blackColor];
    _chaptNameLabel.textColor = [UIColor blackColor];
    fontColor = [UIColor blackColor];
    bgColor = [UIColor whiteColor];
}

- (IBAction)nextChapter:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"next" object:self];
    
}

- (IBAction)setButtonAction:(id)sender {
    
    self.bottomView.hidden = !self.bottomView.hidden;
}
- (IBAction)lastButtonAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"last" object:self];
}
- (IBAction)menuButtonAction:(id)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pop" object:self];
}
@end
