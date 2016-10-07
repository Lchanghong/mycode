//
//  RNRecommendViewController.m
//  百思不得姐
//
//  Created by rain on 16/10/2.
//  Copyright © 2016年 rain. All rights reserved.
//

#import "RNRecommendViewController.h"
#import "RNCategoryTagCell.h"
#import "RNCelebrityTableViewCell.h"
#import "RNCategoryTag.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import "RNUsers.h"

@interface RNRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UINib * nib;
}
/***左边标签数据***/
@property (strong, nonatomic) NSArray *Categories;
/***右边用户数据***/
@property (strong, nonatomic) NSArray *UsersArray;
/***左边tableView***/
@property (weak, nonatomic) UITableView *CategoryView;
/***右边tableView***/
@property (weak, nonatomic) UITableView *CelebrityView;
@end

@implementation RNRecommendViewController

static NSString *const UserID = @"user";
static NSString *const TagID = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //设置导航标题
    self.title = @"推荐关注";
    //设置背景颜色
    self.view.backgroundColor = RNVIEWBGCOLOR;
    
    //设置子控件
    [self setupSubviews];
    
    //注册cell
    [_CelebrityView registerNib:[UINib nibWithNibName:NSStringFromClass([RNCelebrityTableViewCell class]) bundle:nil] forCellReuseIdentifier:UserID];
    _CelebrityView.rowHeight = 60;
    
    //发送请求
    [self tagSendDate];
}

#pragma mark--左边标签发送数据请求
- (void)tagSendDate
{
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    
    [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        RNLog(@" %@ ", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        RNLog(@"请求成功%@",responseObject[@"list"]);
        //字典数组转模型数组
        _Categories = [RNCategoryTag mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [_CategoryView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RNLog(@"请求失败%@",error);
        
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
    }];


}

#pragma mark--创建子tableView
-(void) setupSubviews
{

    //设置指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];

    //创建左边tableView
    UITableView *CategoryTableView = [[UITableView alloc] init ];
    CategoryTableView.frame = CGRectMake(0, 0, 70, self.view.frame.size.height);
    [CategoryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    CategoryTableView.backgroundColor = RNVIEWBGCOLOR;
    CategoryTableView.dataSource =self;
    CategoryTableView.delegate =self;
    [self.view addSubview:CategoryTableView];
    _CategoryView = CategoryTableView;
    
    //创建右侧tableView
    UITableView *CelebrityTV = [[UITableView alloc] init ];
    CelebrityTV.backgroundColor = [UIColor whiteColor];
    CelebrityTV.dataSource =self;
    CelebrityTV.delegate =self;
    CGFloat X = self.CategoryView.frame.size.width;
    CGFloat Y = self.CategoryView.frame.origin.y+64;
    CGFloat width = self.view.bounds.size.width - X;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 64 - 49;
    CelebrityTV.frame = CGRectMake(X,Y , width, height);
    CelebrityTV.tableFooterView = [[UIView alloc] init ] ;
    
    [self.view addSubview:CelebrityTV];
    _CelebrityView = CelebrityTV;
    
    UINib *nib1 = [UINib nibWithNibName:@"RNCelebrityTableViewCell" bundle:nil];
    [self.CelebrityView registerNib:nib1 forCellReuseIdentifier:UserID];

    
}

#pragma mark--TUITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _CategoryView) {
        return _Categories.count;
    }else{
        return _UsersArray.count;
    
    }
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _CategoryView) {//返回左边
        
        
        RNCategoryTagCell *Tagcell = [tableView dequeueReusableCellWithIdentifier:TagID];
        if (Tagcell == nil) {
            Tagcell = [[RNCategoryTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TagID];
        }
        //设置cell数据以及背景色
        Tagcell.category = self.Categories[indexPath.row];
        Tagcell.backgroundColor = RNVIEWBGCOLOR;
        Tagcell.selectionStyle = UITableViewCellSelectionStyleNone;
        [Tagcell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
        
        return Tagcell;
    }else{//返回右边
    
        RNCelebrityTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:UserID ];
        userCell.user = _UsersArray[indexPath.row];
        
        return userCell;
    
    }
    
}


#pragma mark--UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取选中的模型
    RNCategoryTag * selectedCell = self.Categories[indexPath.row];
    RNLog(@"%@",selectedCell.name);
    
    //发送请求
     NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(selectedCell.id);
    [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        RNLog(@" %@ ", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        RNLog(@" %@ ", responseObject[@"list"]);
        
        //字典数组转模型
       _UsersArray = [RNUsers mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        RNLog(@" %@ ",_UsersArray);
        
        //刷新右边表格
        [_CelebrityView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RNLog(@" %@ ", error);
    }];
}

@end
