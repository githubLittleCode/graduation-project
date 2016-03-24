//
//  ContentViewController.m
//  practice1
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "ContentViewController.h"
#import "BookViewController.h"
#import "ContentViewModel.h"
#import "CotentTableViewCell.h"
#import "MyTableViewCellModel.h"
#import "StoryDetailViewControlller.h"
#import "CollectionViewController.h"
#import "ContentTableViewCell2.h"
static BOOL flag = NO;
@interface ContentViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求评论数据
//    [self requestComment];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight )];
   
    cellHeight = 102;
    //获取章节目录信息
    [self takeContent];
    
    //获取评论信息
    [self takeComment];
    
    self.tabBarController.tabBar.translucent = NO;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];

    _tableView.backgroundColor = [UIColor greenColor];
    
    //注册单元格
    [_tableView registerNib:[UINib nibWithNibName:@"ContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"identifying"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ContentTableViewCell2" bundle:nil] forCellReuseIdentifier:@"contentCell2"];
    
    self.view.backgroundColor  =[UIColor whiteColor];
    _tableView.backgroundColor = [UIColor clearColor];
    
    self.title = _model.title;
    
    checkChapter = NO;
    
}


-(void)takeContent
{
    dataArray = [[NSMutableArray alloc]init];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:_model.plistName ofType:@"plist"];
    NSArray *data  = [NSArray arrayWithContentsOfFile:path];
    
    NSString *path1 = [[NSBundle mainBundle]pathForResource:_model.plistContentName ofType:@"plist"];
    NSArray *data1 = [NSArray arrayWithContentsOfFile:path1];
    
    NSString *patr = [[NSBundle mainBundle]pathForResource:_model.detail ofType:@"plist"];
    NSArray *detailArray = [NSArray arrayWithContentsOfFile:patr];
    
    [dataArray addObject:[NSNull null]];
    [dataArray addObject:[NSNull null]];
    for (int i = 0; i < data1.count; i++) {
        
        ContentViewModel *model1 = [[ContentViewModel alloc]init];
        model1.content = data1[i];
        model1.contentName = data[i];
        model1.story = detailArray[i];
        model1.storyName = self.model.title;
        [dataArray addObject:model1];
        
    }
    [_tableView reloadData];
    
}

//获取评论数据
- (void)takeComment{
    
    commentArray = [[NSMutableArray alloc]init];
    
    NSString *str = [[NSBundle mainBundle]pathForResource:@"movie_comment" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:str];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *arr = dic[@"list"];
        
    for (NSDictionary *detailDic in arr) {
        
        MyTableViewCellModel *model = [[MyTableViewCellModel alloc]init];
        
        model.title = detailDic[@"nickname"];
        model.average = detailDic[@"rating"];
        model.imageUrl =[NSURL URLWithString:detailDic[@"userImage"]] ;
        model.comment = detailDic[@"content"];
        
        [commentArray addObject:model];
        
    }
    
    [_tableView reloadData];
    
}

#pragma mark UItableViewCell delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return dataArray.count + commentArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {

            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
        if (cell  == nil) {
        
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 80, 113)];
            
            [view sd_setImageWithURL:_model.imageDic[@"medium"]];
            [cell addSubview:view];
            
            UILabel *labelContent = [[UILabel alloc]initWithFrame:CGRectMake(135, 9, 140, 38)];
            labelContent.textAlignment = NSTextAlignmentLeft;
            
            labelContent.text = _model.title;
            labelContent.font = [UIFont systemFontOfSize:17];
            [cell addSubview:labelContent];
            
            UILabel *labelContentName = [[UILabel alloc]initWithFrame:CGRectMake(135, 100, 140, 28)];        labelContentName.text =[NSString stringWithFormat:@"作者:%@",_model.authorName];
            labelContentName.textAlignment = NSTextAlignmentLeft;
            [cell addSubview:labelContentName];
            
            
            //收藏按钮
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(210, 60, 70, 25)];
            [button setImage:[UIImage imageNamed:@"shoucang.jpg"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(collectionButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
            
            //开始阅读按钮
            
            UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(135, 60, 70, 25)];
            [button1 setImage:[UIImage imageNamed:@"read.jpg"] forState:UIControlStateNormal];
            [button1 addTarget:self action:@selector(readButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:button1];

        }
            return cell;
    }
    
    else if(indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secCell"];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 70, 42)];
            label.text = @"查看目录";
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentLeft;
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, 70, 42)];
            label1.text = [NSString stringWithFormat:@"完结共%ld章",(dataArray.count - 2)];
            label1.font = [UIFont systemFontOfSize:11];
            label1.textColor = [UIColor colorWithWhite:0.732 alpha:1.000];
            label1.textAlignment = NSTextAlignmentLeft;

            
            [cell.contentView addSubview:label];
            [cell.contentView addSubview:label1];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }

    else if(indexPath.row >=2 &&indexPath.row <= dataArray.count - 1) {
        CotentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifying" forIndexPath:indexPath];
        cell.model = dataArray[indexPath.row];
        
        return cell;
    }
    else
        
    {   ContentTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell2" forIndexPath:indexPath];
        cell.model = commentArray[indexPath.row - dataArray.count];
        return cell;
    }
    
    
}

-(void)readButton:(UIButton *)sender
{
    [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
}

-(void)collectionButton:(UIButton *)sender
{
    
    _bookVc.collectionModel = _model;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 134;
    }
    else if (indexPath.row > 1 && indexPath.row <= (dataArray.count - 1))
    {
        if (checkChapter == NO) {
            return 0;
        }
        else if (checkChapter == YES)
            return 42;
    }
    else if (indexPath.row > (dataArray.count - 1))
    {
        if (indexPath.row != selectIndex) {
            return 102;
        }
       else
        return cellHeight;
 
    }
    return 42;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //选中查看章节目录的单元格时响应的方法
    if (indexPath.row == 1) {
        checkChapter = !checkChapter;
        [tableView reloadData];
        return;
    }
    else if (indexPath.row > 1 && indexPath.row <= (dataArray.count - 1)){
        
    //选中目录中的某一章会直接跳到那章的页面
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StoryDetailViewControlller *storyVc = [story instantiateViewControllerWithIdentifier:@"story"];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:dataArray];
    [arr removeObjectAtIndex:0];
    [arr removeObjectAtIndex:0];
        storyVc.bookModel = self.model;
    storyVc.modelArray  = [NSArray arrayWithArray: arr];
    storyVc.selectIndex = indexPath.row - 2;
    storyVc.navigationController.navigationBarHidden = YES;
    [self.navigationController  pushViewController:storyVc animated:YES];
        
    //往数据库添加数据
        UserDB *useDb = [UserDB sharedUserDB];
        HistoryModel *model = [[HistoryModel alloc]init];
        ContentViewModel *model1 = dataArray[indexPath.row];
        model.bookName = self.model.title;
        model.chapter = model1.content;
        unsigned int count = [useDb lastNumber];
        if (count == -1) {
                NSLog(@"获取数据库记录数出错");
            }
        model.number = count + 1;
                
        [useDb insertTable:model];
        
    }
    else if (indexPath.row > (dataArray.count - 1)){
        selectIndex = indexPath.row;
        
        //根据文字多少设置选中单元格的高度
        ContentTableViewCell2 *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:0]];
        
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        
        CGRect rect = [cell.commentLabel.text boundingRectWithSize:CGSizeMake(200, 1600) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:13],
                                                                                                                                                     NSParagraphStyleAttributeName : style
                                                                                                                                                     } context:nil];
        cellHeight = rect.size.height + 102;
        
        [_tableView reloadData];
        
    }


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
