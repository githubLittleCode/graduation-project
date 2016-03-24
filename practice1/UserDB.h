//
//  UserDB.h
//  practice1
//
//  Created by Apple on 16/1/3.
//  Copyright © 2016年 zjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@class HistoryModel;

@interface UserDB : NSObject
{
        NSString *filePath;
}

+ (instancetype)sharedUserDB;

- (void)createTable;
- (void)insertTable:(HistoryModel *)model;
- (NSArray *)queryData;
- (void)deleteTable:(int)number;
- (unsigned int)lastNumber;

@end
