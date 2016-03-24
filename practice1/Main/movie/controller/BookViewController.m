//
//  BookViewController.m
//  practice1
//
//  Created by Apple on 15/12/11.
//  Copyright © 2015年 zjj. All rights reserved.
//

#import "BookViewController.h"
#import "MyTableViewCellModel.h"
#import "MyTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ContentViewController.h"
#import "BookCollectionViewCell.h"
#import "MyNavigatioinController.h"
#import "MyTabBarController.h"
#import "MySelfViewController.h"
#import "ModalViewController.h"

@interface BookViewController () <UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate, UITextFieldDelegate>

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建小说列表视图
    [self _creatTableView];
    //加载开始界面
    [self creatViewForBegin];
    
    _selectImage = 0;
    
    if (_tableView.hidden == YES) {
        self.title = @"登录";
        self.tabBarController.tabBar.hidden = YES;
    }
    else if(_tableView.hidden == NO)
    {
        self.title = @"书架";
        self.tabBarController.tabBar.hidden = NO;
    }
    
    _collectionModel = [[MyTableViewCellModel alloc]init];
    
    self.navigationController.navigationBar.translucent = NO;

    //创建旋转button
//    [self _creatButton];
    
    [self takeMessage];


}

- (void)sendMessage {
    
    MyNavigatioinController *navi = [self.tabBarController.viewControllers objectAtIndex:2] ;
    MySelfViewController *myVc = [navi.viewControllers objectAtIndex:0];
    
    myVc.bookVc = self;
    myVc.collectionArray = [[NSMutableArray alloc]init];
}


- (void)creatViewForBegin {
    
    _viewForBegin = [[UIView alloc]initWithFrame:self.view.bounds];
    _viewForBegin.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_viewForBegin];
    //男生头像视图
    _manImageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(37, 26, 80, 80)];
    _manImageVIew.image = [UIImage imageNamed:@"man.jpg"];
    [_viewForBegin addSubview:_manImageVIew];
    //女生头像视图
    _womanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(196, 26, 80, 80)];
    _womanImageView.image = [UIImage imageNamed:@"woman.jpg"];
    [_viewForBegin addSubview:_womanImageView];
    
    //输入账号的输入框
    _accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(37, 130, 238, 40)];
    _accountTextField.placeholder = @"请输入账号";
    _accountTextField.delegate = self;
    _accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    _accountTextField.textAlignment = NSTextAlignmentLeft;
    [_viewForBegin addSubview:_accountTextField];
    
    //输入密码的输入框
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(37, 195, 238, 40)];
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.delegate = self;
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.secureTextEntry = YES;
    _accountTextField.textAlignment = NSTextAlignmentLeft;
    [_viewForBegin addSubview:_passwordTextField];
    
    //登录按钮
    _loadButton = [[UIButton alloc]initWithFrame:CGRectMake(37, 255, 238, 35)];
    _loadButton.backgroundColor = [UIColor colorWithRed:0.435 green:0.671 blue:1.000 alpha:1.000];
    [_loadButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loadButton addTarget:self action:@selector(loadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_viewForBegin addSubview:_loadButton];
    
    //注册按钮
    _logInButton = [[UIButton alloc]initWithFrame:CGRectMake(37, 300, 238, 35)];
    _logInButton.backgroundColor = [UIColor colorWithRed:0.435 green:0.671 blue:1.000 alpha:1.000];
    [_logInButton setTitle:@"注册" forState:UIControlStateNormal];
    [_logInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_logInButton addTarget:self action:@selector(logInButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_viewForBegin addSubview:_logInButton];

    
    _manImageVIew.layer.cornerRadius = 40;
    _manImageVIew.layer.masksToBounds = YES;
    _manImageVIew.userInteractionEnabled = YES;
    _manImageVIew.alpha = 0.5;
    
    _womanImageView.layer.cornerRadius = 40;
    _womanImageView.layer.masksToBounds = YES;
    _womanImageView.userInteractionEnabled = YES;
    _womanImageView.alpha = 0.5;
    
    UIButton *manButton = [[UIButton alloc]initWithFrame:_manImageVIew.bounds];
    [_manImageVIew addSubview:manButton];
    [manButton addTarget:self action:@selector(manAction:) forControlEvents:UIControlEventTouchUpInside ];
    
    UIButton *womanButton = [[UIButton alloc]initWithFrame:_womanImageView.bounds];
    [_womanImageView addSubview:womanButton];
    [womanButton addTarget:self action:@selector(womanAction:) forControlEvents:UIControlEventTouchUpInside ];
    
}

//注册按钮响应方法

- (void)logInButtonAction:(UIButton *)sender {
    
    [self presentViewController:[[ModalViewController alloc]init] animated:YES completion:NULL];
    
}

//登录按钮响应方法
- (void)loadButtonAction:(UIButton *)sender {
    
    if(_accountTextField.text.length != 0 && _passwordTextField.text.length != 0 && _selectImage != 0)
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@", [defaults objectForKey:@"account"]);
    NSLog(@"%@", [defaults objectForKey:@"selectImage"]);
    NSLog(@"%@", [defaults objectForKey:@"password"]);

    if ([_accountTextField.text isEqualToString:[defaults objectForKey:@"account"]]){
        
        if([_passwordTextField.text isEqualToString:[defaults objectForKey:@"password"]]) {
            
           if( _selectImage == [[defaults objectForKey:@"selectImage"] integerValue])
            {
        
             _viewForBegin.hidden = YES;
             _tableView.hidden = NO;
        
             self.navigationController.navigationBarHidden = NO;
             self.tabBarController.tabBar.hidden = NO;
        
             self.title = @"书架";
        
             CATransition *animation = [[CATransition alloc]init];
             animation.type = @"suckEffect";
             animation.subtype = kCATransitionFromRight;
             animation.duration = 1.5;
        
             [_viewForBegin.layer addAnimation:animation forKey:nil];
             _account = _accountTextField.text;
        
            [self sendMessage];
        }
      }
    }
    else{
        
        _accountTextField.text = nil;
        _passwordTextField.text = nil;
        
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"账号或密码输入不正确" message:@"请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert1 animated:YES completion:NULL];
        [alert1 performSelector:@selector(dismissViewControllerAnimated:completion:) withObject:nil afterDelay:1.6];
        

    }
}
    else{
      
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"信息输入不完全" message:@"请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:NULL];
        [alert performSelector:@selector(dismissViewControllerAnimated:completion:) withObject:nil afterDelay:1.6];
    }
    
}

//选中男人图片按钮响应方法
- (void)manAction:(UIButton *)sender {
    
    _womanImageView.alpha = 0.6;
    _manImageVIew.alpha = 1;
    _selectImage = 2;
}


//选中女人图片按钮响应方法
- (void)womanAction:(UIButton *)sender {
   
    _manImageVIew.alpha = 0.6;
    _womanImageView.alpha = 1;
    _selectImage = 1;
}


//收藏的按钮点击后响应的方法
- (void)setCollectionModel:(MyTableViewCellModel *)collectionModel{
    
    if (_collectionModel != collectionModel) {
        _collectionModel = collectionModel;
        _block();
    }
}


-(void)takeMessage
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
        model.plistName = messageDic[@"id"];
        model.plistContentName = [NSString stringWithFormat:@"%@章节名", messageDic[@"id"]];
        model.imageDic = messageDic[@"images"];
        model.year = messageDic[@"year"];
        model.average = [messageDic[@"rating"] objectForKey:@"average"];
        model.subType = [messageDic objectForKey:@"original_title"];
        model.authorName = messageDic[@"subtype"];
        model.detail = [NSString stringWithFormat:@"%@Detail",messageDic[@"id"]];
        
        [dataArray addObject:model];
        
    }
        [_tableView reloadData];
//    [_collectionView reloadData];
    
    
    
    
}

//-(void)_creatButton
//{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
//    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button1.frame = view.frame;
//    [button1 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home@2x.png"] forState:UIControlStateNormal];
//    button1.tag = 101;
//    [button1 setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateNormal];
//    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [view addSubview:button1];
//    
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame = view.frame;
//    [button2 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home@2x.png"] forState:UIControlStateNormal];
//    [button2 setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
//    button2.tag = 102;
//    button2.hidden = YES;
//    
//    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    
//    [view addSubview:button2];
//    
//    
//    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:view];
//    
//    self.navigationItem.rightBarButtonItem = right;
//    
//}

//-(void)buttonAction:(UIButton *)button
//{
////    jumpButton.hidden = !jumpButton;
//    
//    UIButton *button1 =(UIButton *)[button.superview viewWithTag:101];
//    button1.hidden = !button1.hidden;
//    
//    UIButton *button2 =(UIButton *)[button.superview viewWithTag:102];
//    button2.hidden = !button2.hidden;
//    
//    _tableView.hidden = !_tableView;
//    _collectionView.hidden = !_collectionView.hidden;
//    
//    [UIView transitionWithView:button.superview duration:0.15 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        [button.superview exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//    } completion:NULL];
//    
//    [UIView transitionWithView:self.view  duration:0.15 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//    } completion:NULL];
//    
//    
//    
//    
//}

-(void)_creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor lightGrayColor];
    _tableView.hidden = YES;
    _tableView.rowHeight = 120;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"identifier"];
    
    [self.view addSubview:_tableView];
    
    
}

#pragma mark -UITextField   delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self loadButtonAction:nil];
    [_passwordTextField resignFirstResponder];
    return YES;
}




//-(void)_creatView
//{
//    
////    UIImage *image = [UIImage imageNamed:@"bg_shujia.jpg"];
//    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    flowLayout.itemSize = CGSizeMake(100, 118);
////    flowLayout.minimumInteritemSpacing = 5;
//    flowLayout.minimumLineSpacing = 10;
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    
//    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) collectionViewLayout:flowLayout];
//    _collectionView.scrollEnabled = YES;
//    _collectionView.showsHorizontalScrollIndicator = YES;
//    
//    _collectionView.userInteractionEnabled = YES;
//    
//    _collectionView.backgroundColor = [UIColor whiteColor];
//    
//    [_collectionView registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collection"];
//    
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//    
//    
//    
//    [self.view addSubview:_collectionView];
//    
//}

#pragma mark - UICollectionView delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  
    return dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    cell.selected = NO;
    cell.model = dataArray[indexPath.row];
    
    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120, 138);

}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    BookCollectionViewCell *cell = (BookCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:0]];
//    [self bookButtonAction:cell];
//}

-(void)bookButtonAction:(MyTableViewCell *)cell
{
        
   ContentViewController *contentVc = [[ContentViewController alloc]init];
    
    contentVc.model = cell.model;
    contentVc.selectModel = cell.model;
    contentVc.navigationController.navigationBarHidden = NO;
    contentVc.bookVc = self;
    [self.navigationController pushViewController:contentVc animated:YES];

}

#pragma mark UITableVIew delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    cell.model = dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    [self bookButtonAction:cell];
    
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
