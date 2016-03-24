//
//  DetailCell.h
//  practice1
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentViewModel;

@interface DetailCell : UITableViewCell
{

    UIColor *bgColor;
    UIColor *fontColor;
    CGFloat fontSize;

}
@property(nonatomic,assign)BOOL flag;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UISlider *fontSizeSlider;

@property (weak, nonatomic) IBOutlet UILabel *chaptNameLabel;

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)menuButtonAction:(id)sender;
@property(nonatomic,weak)ContentViewModel *model;
- (IBAction)greenButtonAction:(id)sender;
- (IBAction)grayButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;
- (IBAction)blackButtonAction:(id)sender;
- (IBAction)whiteButtonAction:(id)sender;
- (IBAction)nextChapter:(id)sender;
- (IBAction)setButtonAction:(id)sender;

- (IBAction)lastButtonAction:(id)sender;

@end
