//
//  UserDB.m
//  practice1
//
//  Created by Apple on 16/1/3.
//  Copyright © 2016年 zjj. All rights reserved.
//

#import "UserDB.h"
#import <sqlite3.h>
#import "HistoryModel.h"

@implementation UserDB

+ (instancetype)sharedUserDB {
   
    static UserDB *instance = nil;
    static dispatch_once_t onceTocken;
        dispatch_once(&onceTocken, ^{
            
            instance = [[UserDB alloc]init];
            [instance copyDb];
            
        });
    return instance;
    
}

//程序第一次启动时，要把程序包中的文件拷贝到沙盒中才可以进行修改
- (void)copyDb {
   
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:[self getFielPath]]) {
        
        NSString *srcDBFile = [[NSBundle mainBundle] pathForResource:@"mydatabase" ofType:@"sqlite"];
        
        BOOL result = [manager copyItemAtPath:srcDBFile toPath:[self getFielPath] error:nil];
        
        if (result) {
            
            //创建表
            [self createTable];
            
        }
        else {
            
            NSLog(@"创建数据库文件失败");
        }
        
    }
    
    
    
}
- (NSString *)getFielPath{
    
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", @"mydatabase.sqlite"];
    NSLog(@"%@", path);
    return path;
}

-(void)createTable{
  
    filePath = [self getFielPath];
    sqlite3 *pDb = NULL;
    
    //打开成功pDb为一个有效地址，指向数据库
    int result = sqlite3_open([filePath UTF8String], &pDb);
    if (result != SQLITE_OK) {
        NSLog(@"打开失败");
        return;
    }
    
    //创建table
    
    NSString *sql = @"create table history(id integer,name text,chapter text)";
    //执行SQL语句
    char *error = NULL;
   int result1 = sqlite3_exec(pDb, [sql UTF8String], NULL, NULL, &error);
    if (result1 != SQLITE_OK) {
        NSLog(@"创建表失败");
        sqlite3_close(pDb);
        return;
    }
    
    sqlite3_close(pDb);
}

//插入数据
- (void)insertTable:(HistoryModel *)model{
    
    sqlite3 *sqliteHandle = NULL;
  //1\打开数据库
    int result = sqlite3_open([[self getFielPath] UTF8String], &sqliteHandle);
    if (result != SQLITE_OK) {
        sqlite3_close(sqliteHandle);
        return;
    }
    sqlite3_stmt *pStmt;
  //构造SQL语句 编译语句
   
    NSString *sql = @"insert into history(id,name,chapter) values(?,?,?)";
    
   result = sqlite3_prepare_v2(sqliteHandle, [sql UTF8String], -1, &pStmt, NULL);
    if (result != SQLITE_OK) {
        sqlite3_close(sqliteHandle);
        return;
    }
   
    //添加数据
    sqlite3_bind_int(pStmt, 1, model.number);
    sqlite3_bind_text(pStmt, 2, [model.bookName UTF8String], -1, NULL);
    sqlite3_bind_text(pStmt, 3, [model.chapter UTF8String], -1, NULL);
    
    //执行一步
   result = sqlite3_step(pStmt);
    if (result != SQLITE_OK) {
        sqlite3_finalize(pStmt);
        sqlite3_close(sqliteHandle);
        return;
    }
    sqlite3_finalize(pStmt);
    //关闭
    sqlite3_close(sqliteHandle);
    
}

- (void)deleteTable:(int)number{
    sqlite3 *sqliteHandle = NULL;

    int result = sqlite3_open([[self getFielPath] UTF8String], &sqliteHandle);
    if (result != SQLITE_OK) {
        sqlite3_close(sqliteHandle);
        return;
    }
    sqlite3_stmt *pStmt;
    
    NSString *sql = @"delete from history where id like ?;";
    
    result = sqlite3_prepare(sqliteHandle, [sql UTF8String], -1, &pStmt, NULL);
    if (result != SQLITE_OK) {
        sqlite3_finalize(pStmt);
        sqlite3_close(sqliteHandle);
        return;
    }
    
    
    sqlite3_bind_int(pStmt, 1, number);
    
    result = sqlite3_step(pStmt);
    
    if (result != SQLITE_ROW) {
        sqlite3_finalize(pStmt);
        sqlite3_close(sqliteHandle);
        return;
    }
    sqlite3_finalize(pStmt);
    sqlite3_close(sqliteHandle);
    
    
}

- (NSArray *)queryData {
   
    sqlite3 *sqliteHandle = NULL;

    NSMutableArray *arr = [NSMutableArray array];
    //1\打开数据库
    int result = sqlite3_open([[self getFielPath] UTF8String], &sqliteHandle);
    if (result != SQLITE_OK) {
        sqlite3_close(sqliteHandle);
        return arr;
    }
    sqlite3_stmt *pStmt;
    
    NSString *sql = @"select *from history order by id desc;";
    
    result = sqlite3_prepare(sqliteHandle, [sql UTF8String], -1, &pStmt, NULL);
    
    while (sqlite3_step(pStmt) == SQLITE_ROW) {
        HistoryModel *model = [[HistoryModel alloc]init];
        
        model.bookName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(pStmt, 1)];
        model.number = sqlite3_column_int(pStmt, 0);
        
        model.chapter = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(pStmt, 2)];
        [arr addObject:model];
    }
    sqlite3_finalize(pStmt);
    sqlite3_close(sqliteHandle);
    return arr;
    
}

- (unsigned int)lastNumber{
  
    sqlite3 *sqliteHandle = NULL;
    unsigned int count =0;
    //1\打开数据库
    int result = sqlite3_open([[self getFielPath] UTF8String], &sqliteHandle);
    if (result != SQLITE_OK) {
        sqlite3_close(sqliteHandle);
        return -1;
    }
    sqlite3_stmt *pStmt;

    NSString *sql = @"select count(*) from history;";
    result = sqlite3_prepare(sqliteHandle, [sql UTF8String], -1, &pStmt, NULL);
    if (result != SQLITE_OK) {
        sqlite3_finalize(pStmt);
        sqlite3_close(sqliteHandle);
        return -1;
    }
    result = sqlite3_step(pStmt);
    
    if (result != SQLITE_ROW) {
        sqlite3_finalize(pStmt);
        sqlite3_close(sqliteHandle);
        return -1;
    }
    
    count = sqlite3_column_int(pStmt, 0);
    
    sqlite3_finalize(pStmt);
    sqlite3_close(sqliteHandle);
    return count;
    
}

@end
