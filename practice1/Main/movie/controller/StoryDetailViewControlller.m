//
//  StoryDetailViewControlller.m
//  practice1
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "StoryDetailViewControlller.h"
#import "DetailCell.h"
#import "ContentViewModel.h"
#import "SinaWeibo.h"
#import "AFNetworking.h"
#import "ContentViewController.h"

#define boundry @"AZJ02x"

#define kAppKey @"1272710322"
#define kAppSecret @"b860325a743dc56acd06556845be43e0"
#define kAppRebackUrl @"http://www.huiwen.com"

@interface StoryDetailViewControlller () <SinaWeiboDelegate>

@end

@implementation StoryDetailViewControlller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //向左轻扫手势
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(nextNotice:)];
    swip.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [_tableView addGestureRecognizer:swip];
    
    [self creatRightItem];
    
    //向右轻扫手势
    UISwipeGestureRecognizer *swip1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(lastNotice:)];
    swip1.direction = UISwipeGestureRecognizerDirectionRight;
    
    [_tableView addGestureRecognizer:swip1];

    
    self.navigationController.navigationBar.translucent = NO;

}

-(UIStatusBarStyle)preferredStatusBarStyle
{

    return UIStatusBarStyleLightContent;

}

- (void)creatRightItem {
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 10)];
    [button setBackgroundImage:[UIImage imageNamed:@"more_select_setting.png"] forState:UIControlStateNormal];

    [button addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)shareAction{
   
    _sinaweibo = [[SinaWeibo alloc]initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRebackUrl andDelegate:self];
    model = _modelArray[0];
    [_sinaweibo logIn];
    
}

#pragma -mark Sinaweibo delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    
    [self uploadData];
}

- (void)uploadData{
    
    NSURL *url = [NSURL URLWithString:@"https://upload.api.weibo.com/2/statuses/upload.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    
    //设置请求头
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; charset=utf-8;boundary=%@",boundry] forHTTPHeaderField:@"Content-Type"];
    //设置请求体
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"man" ofType:@"jpg"];
    NSData *imagedata = [NSData dataWithContentsOfFile:path];
    
    NSData *bodyData = [self creatBodyData:imagedata];
    
    //创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:bodyData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"上传成功");
    }];
    
    [task resume];
    
}

- (NSData *)creatBodyData:(NSData *)imageData{
    
    //表示用户登录的令牌
    NSString *accessToken = _sinaweibo.accessToken;
    NSString *text = [NSString stringWithFormat:@"我正在爱阅读上阅读%@,非常好看的一本书，推荐给大家", model.storyName];
    //拼接请求体
    
    NSMutableString *bodyStr = [NSMutableString string];
    //(1)拼接令牌
    [bodyStr appendFormat:@"--%@\r\n", boundry];
    [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"access_token\"\r\n\r\n" ];
    [bodyStr appendFormat:@"%@\r\n",accessToken];
    
    //拼接微博文字
    [bodyStr appendFormat:@"--%@\r\n", boundry];
    [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"status\"\r\n\r\n"];
    [bodyStr appendFormat:@"%@\r\n",text];
    
    //拼接图片数据
    [bodyStr appendFormat:@"--%@\r\n", boundry];
    [bodyStr appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"file\"\r\n"];
    [bodyStr appendFormat:@"Content-Type: application/octet-stream\r\n\r\n"];
    NSData *textData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *totalData = [NSMutableData data];
    [totalData appendData:textData];
    [totalData appendData:imageData];
    
    NSString *str1 = [NSString stringWithFormat:@"\r\n--%@--\r\n",boundry];
    [totalData appendData:[str1 dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //拼接结束符
    return totalData;

}


-(void)viewWillLayoutSubviews
{

  [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nextNotice:) name:@"next" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(lastNotice:) name:@"last" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popAction:) name:@"pop" object:nil];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    self.navigationController.navigationBarHidden = NO;

}


-(void)popAction:(NSNotification *)noti
{
    ContentViewController *bookVc = [[ContentViewController alloc]init];
    bookVc.model = self.bookModel;
    [self.navigationController pushViewController:bookVc animated:YES];

}

-(void)nextNotice:(NSNotification *)noti
{
    
    if (_selectIndex != (_modelArray.count - 1)) {
        
        //往数据库添加数据
        unsigned int count = 0;
        UserDB *useDb = [UserDB sharedUserDB];
        HistoryModel *modelH = [[HistoryModel alloc]init];
        ContentViewModel *model1 = _modelArray[_selectIndex];
        modelH.bookName = model1.storyName;
        modelH.chapter =  model1.content;
        count  = [useDb lastNumber];
        if (count == -1) {
            NSLog(@"获取数据库记录数出错");
        }
        modelH.number = count + 1;
        
        [useDb  insertTable:modelH];

        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:(_selectIndex + 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

        CATransition *transition = [CATransition animation];
        transition.type = @"pageCurl";
        transition.duration = 1.0;
        transition.subtype = kCATransitionFromRight;
        
        [_tableView.layer addAnimation:transition forKey:nil];
        
        _selectIndex = _selectIndex + 1;
    }
}

-(void)lastNotice:(NSNotification *)noti
{
    if (_selectIndex != 0) {
        
        //往数据库添加数据
        UserDB *useDb = [UserDB sharedUserDB];
        HistoryModel *modelH = [[HistoryModel alloc]init];
        ContentViewModel *model1 = _modelArray[_selectIndex];
        modelH.bookName = model1.storyName;
        modelH.chapter =  model1.content;
        unsigned int count = [useDb lastNumber];
        if (count == -1) {
            NSLog(@"获取数据库记录数出错");
        }
        modelH.number = count + 1;
        
        [useDb  insertTable:modelH];
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:(_selectIndex - 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        CATransition *transition = [CATransition animation];
        transition.type = @"pageCurl";
        transition.duration = 1.0;
        transition.subtype = kCATransitionFromLeft;
        
        [_tableView.layer addAnimation:transition forKey:nil];

        
        _selectIndex = _selectIndex - 1;

    }

}

//加载小说数据
//-(void)_loadData
//{
//        
//    _dataSelfArray = [[NSMutableArray alloc]init];
//
//    for (int i = 0; i < _modelArray.count;i++) {
//        ContentViewModel *model1 = [[ContentViewModel alloc]init];
//        model1.story =((ContentViewModel *)_modelArray[i]).story ;
//        model1.contentName =((ContentViewModel *) [_modelArray objectAtIndex:i]).contentName;
//        model1.content = ((ContentViewModel *) [_modelArray objectAtIndex:i]).content;
//        
//        [_dataSelfArray addObject:model1];
//        
//    }
//    [_tableView reloadData];
//    
//}



#pragma mark - UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return   _modelArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storyCell" forIndexPath:indexPath];
    
    cell.model = _modelArray[indexPath.row];
  
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
