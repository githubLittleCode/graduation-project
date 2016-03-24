//
//  SearchViewController.m
//  practice1
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "SearchViewController.h"
#import "ContentViewController.h"
#import "MyTableViewCellModel.h"
#import "WebViewController.h"


@interface SearchViewController () <UITextFieldDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"搜索";
    
    //创建搜索框
    [self _creatInputTextFied];
    
    //创建推荐目录
    [self _creatRecommond];
    
    //加载数据
    [self _loadData];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

-(void)_loadData
{
    dataArray = [[NSMutableArray alloc]init];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"us_box" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    
    
    NSArray *arr = dic[@"subjects"];
    
    for (NSDictionary *detailDic in arr) {
        
        
        MyTableViewCellModel *model = [[MyTableViewCellModel alloc]init];
        NSDictionary *messageDic = detailDic[@"subject"];
        model.title = messageDic[@"title"];
        model.imageDic = messageDic[@"images"];
        model.year = messageDic[@"year"];
        model.average = [messageDic[@"rating"] objectForKey:@"average"];
        model.plistName = messageDic[@"id"];
        model.plistContentName = [NSString stringWithFormat:@"%@章节名", messageDic[@"id"]];
        model.authorName = messageDic[@"subtype"];
        model.detail = [NSString stringWithFormat:@"%@Detail", messageDic[@"id"]];
        [dataArray addObject:model];
        
    }

}

-(void)_creatInputTextFied

{

    field = [[UITextField alloc]initWithFrame:CGRectMake(45, 110, kScreenWidth - 90, 40)];
    field.borderStyle = UITextBorderStyleRoundedRect;
    
    field.clearsOnBeginEditing = YES;
    field.clearButtonMode = UITextFieldViewModeAlways;
    field.delegate = self;
    //创建搜索按钮
    UIButton *rightButton = [[UIButton alloc]init];
    rightButton.frame = CGRectMake(260, 110, 30, 40);
    [rightButton setImage:[UIImage imageNamed:@"more_search_on.png"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    field.placeholder = @"请输入书名";
    
    field.rightView = rightButton;
    field.rightViewMode = UITextFieldViewModeAlways;
    
    field.textColor = [UIColor blackColor];
    field.keyboardType = UIKeyboardTypeWebSearch;
    
    [self.view addSubview:field];

}
//搜索按钮响应的方法
-(void)rightButtonAction:(UIButton *)sender
{

    [self buttonAction:nil withString:field.text];
}

//热门推荐
-(void)_creatRecommond
{
    UILabel *label;
    
    if (kScreenWidth <= 320) {
         label = [[UILabel alloc]initWithFrame:CGRectMake(105, 150, 100, 60)];
    }
    else if (kScreenWidth > 320){
        label = [[UILabel alloc]initWithFrame:CGRectMake(105, 150, 100, 60)];
    }
   
    label.text = @"热门搜索";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:label];
    
    NSArray *nameArray = @[@"三国演义", @"至此终年", @"他来了请闭眼",@"陆小凤传奇全集" , @"最美遇见你",  @"谁是谁的谁", @"城府", @"迟阳", @"边城"];

    for (int i = 0 ; i < nameArray.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(85, 200  + i * 30, 150, 30)];
//        button.titleLabel.text = nameArray[i];
        [button setTitle:nameArray[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor colorWithRed:0.572 green:0.820 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        button.tag = i + 100;

        [button addTarget:self action:@selector(buttonAction:withString:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
    }
}
-(void)buttonAction:(UIButton *)sender withString:(NSString *)str
{
    
    ContentViewController *contentVc = [[ContentViewController alloc]init];
    if (sender != nil) {
        NSString *str1 = sender.titleLabel.text;
        contentVc.model = [self marryData:str1];
    }
    else
    {    if ([self marryData:str] == nil) {
        
        WebViewController *web = [[WebViewController alloc]init];
        [self.navigationController pushViewController:web animated:NO];
        return;
        }
        else
        contentVc.model = [self marryData:str];
    }

    
    
    [self.navigationController pushViewController:contentVc animated:YES];

}

-(MyTableViewCellModel *)marryData:(NSString *)str
{
    MyTableViewCellModel *model;
    
    for (int i = 0 ; i < dataArray.count; i ++)
    {
        
       model = dataArray[i];
        if ([model.title isEqualToString:str])
        {
            break;
        }
        else
        {
            if (i == dataArray.count - 1) {
                return nil;
            }
            else
            continue;
        }
    }
    
    return model;
}

#pragma mark UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [self buttonAction:nil withString:field.text];

    [field resignFirstResponder];
    
    field.text = nil;
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
