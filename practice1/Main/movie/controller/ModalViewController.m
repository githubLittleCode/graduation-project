//
//  ModalViewController.m
//  practice1
//
//  Created by Apple on 16/3/11.
//  Copyright © 2016年 zjj. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()<UITextFieldDelegate>

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _selectImage = 0;
}

- (void)creatView{
       //男生头像视图
    _manImageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(37, 26, 80, 80)];
    _manImageVIew.image = [UIImage imageNamed:@"man.jpg"];
    [self.view addSubview:_manImageVIew];
    //女生头像视图
    _womanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(196, 26, 80, 80)];
    _womanImageView.image = [UIImage imageNamed:@"woman.jpg"];
    [self.view addSubview:_womanImageView];
    
    //输入账号的输入框
    _accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(37, 130, 238, 40)];
    _accountTextField.placeholder = @"请输入账号";
    _accountTextField.delegate = self;
    _accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    _accountTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_accountTextField];
    
    //输入密码的输入框
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(37, 195, 238, 40)];
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.delegate = self;
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.secureTextEntry = YES;
    _accountTextField.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_passwordTextField];
   
    //注册按钮
    _logInButton = [[UIButton alloc]initWithFrame:CGRectMake(37, 255, 238, 35)];
    _logInButton.backgroundColor = [UIColor colorWithRed:0.435 green:0.671 blue:1.000 alpha:1.000];
    [_logInButton setTitle:@"注册" forState:UIControlStateNormal];
    [_logInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_logInButton addTarget:self action:@selector(logInButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_logInButton];
    
    
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
  
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (_accountTextField.text.length != 0 && _passwordTextField.text.length != 0 && _selectImage != 0) {

        [defaults setValue:_accountTextField.text forKey:@"account"];
        [defaults setValue:_passwordTextField.text forKey:@"password"];
        [defaults setValue:[NSNumber numberWithInteger:_selectImage] forKey:@"selectImage"];
        [defaults synchronize];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else{
       
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请重新输入" message:@"注册信息填写不完全" preferredStyle:UIAlertControllerStyleAlert];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_passwordTextField resignFirstResponder];
    return YES;
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
