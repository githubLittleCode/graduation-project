//
//  MyTableViewCellModel.h
//  practice1
//
//  Created by Apple on 15/12/9.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTableViewCellModel : NSObject
@property(nonatomic,strong)NSNumber *average;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *year;

@property(nonatomic,strong)NSDictionary *imageDic;
@property(nonatomic,strong)NSURL *imageUrl;
@property(nonatomic,copy)NSString *comment;

@property(nonatomic,copy)NSString *authorName;

@property(nonatomic,copy)NSString *subType;

@property(nonatomic,copy)NSString *plistName;

@property(nonatomic,copy)NSString *detail;

@property(nonatomic,copy)NSString *plistContentName;
@end
