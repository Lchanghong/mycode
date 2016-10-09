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
//#import "RNCategoryTag.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import "RNUsers.h"
#import <MJRefresh/MJRefresh.h>
#import "HWLeftModel.h"
#import "HWRightModel.h"

#define HWRNCategoryTag _Categories[_CategoryView.indexPathForSelectedRow.row]

@interface RNRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

/***左边标签数据***/
//@property (strong, nonatomic) NSArray *Categories;
/***右边用户数据***/
//@property (strong, nonatomic) NSArray *UsersArray;


/**
 左边的索引
 */
@property (assign, nonatomic) NSInteger leftIndex;
@property (assign, nonatomic) NSInteger rightTabelViewPage;

@property (strong, nonatomic) NSArray *leftDataSoure;
//@property (strong, nonatomic) NSMutableArray *rightModelArray;
//@property (strong, nonatomic) HWRightModel *rightModel;

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
  
    self.rightTabelViewPage = 1;
    //设置导航标题
    self.title = @"推荐关注";
    //设置背景颜色
    self.view.backgroundColor = RNVIEWBGCOLOR;
    
    //设置子控件
    [self setupSubviews];
    
    //左边tag发送请求
    [self tagSendDate];
    
    //添加刷新控件
    [self setupRefresh];
}

//- (HWRightModel *)rightModel{
//    if (!_rightModel) {
//        _rightModel = [[HWRightModel alloc] init];
//    }
//    return _rightModel;
//}

/***添加刷新控件***/
- (void) setupRefresh
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    [footer setTitle:@"全部加载完毕!" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"点击或上拉加载更多数据!" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多数据..." forState:MJRefreshStateRefreshing];
    _CelebrityView.mj_footer = footer;

    _CelebrityView.mj_footer.hidden = YES;
}

#pragma mark--发送数据请求
/***左边发请求***/
- (void)tagSendDate
{
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    __weak typeof(self) weakSelf = self;
    [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        RNLog(@" %@ ", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组转模型数组
        weakSelf.leftDataSoure = [HWLeftModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [weakSelf.CategoryView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RNLog(@"请求失败%@",error);
        [weakSelf.CelebrityView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载失败!"];
    }];

}

/***右边发请求***/

- (void) usersSendDate
{
    HWLeftModel *leftModel = self.leftDataSoure[_CategoryView.indexPathForSelectedRow.row];
    
    //发送请求
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(leftModel.ID);
    
    __weak typeof(self) weakSelf = self;
 
    [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        RNLog(@" %@ ", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HWRightModel *rightModel = [HWRightModel mj_objectWithKeyValues:responseObject];
        rightModel.users = [RNUsers mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        leftModel.rightModel = rightModel;
        NSLog(@"-->> leftModel.rightModel:%@", leftModel.rightModel);
        
        //刷新右边表格
        [weakSelf.CelebrityView reloadData];
        [weakSelf.CelebrityView.mj_footer endRefreshing];
    
        if(rightModel.users.count == 0){//没有数据
            weakSelf.CelebrityView.mj_footer.hidden = YES;
            return;
            
        }else if (rightModel.users.count == rightModel.total) {//只有一页数据
            [weakSelf.CelebrityView.mj_footer endRefreshingWithNoMoreData];
        }
        
        weakSelf.CelebrityView.mj_footer.hidden = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RNLog(@" %@ ", error);
        [weakSelf.CelebrityView.mj_footer endRefreshing];
    }];
}

- (void) loadMoreUsers
{
    self.rightTabelViewPage++;
    HWLeftModel *leftModel = self.leftDataSoure[_CategoryView.indexPathForSelectedRow.row];
    
    //发送请求
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(leftModel.ID);
    params[@"page"] = @(self.rightTabelViewPage);
    
    __weak typeof(self) weakSelf = self;
    [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        RNLog(@" %@ ", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HWRightModel *rightModel = leftModel.rightModel;
        NSArray *array = [RNUsers mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [rightModel.users addObjectsFromArray:array];
        rightModel.next_page = [responseObject[@"next_page"] integerValue];
        leftModel.rightModel = rightModel;
        NSLog(@"-->> leftModel.rightModel:%@", leftModel.rightModel);
        
        //刷新右边表格
        [weakSelf.CelebrityView reloadData];
        
        //结束刷新状态
        [weakSelf.CelebrityView.mj_footer endRefreshing];
        
        //判断是否还有数据
        if (rightModel.next_page > rightModel.total_page) {
            [weakSelf.CelebrityView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RNLog(@" %@ ", error);
        [weakSelf.CelebrityView.mj_footer endRefreshing];
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
    CelebrityTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    CelebrityTV.dataSource =self;
    CelebrityTV.delegate =self;
    CGFloat X = self.CategoryView.frame.size.width;
    CGFloat Y = self.CategoryView.frame.origin.y+64;
    CGFloat width = self.view.bounds.size.width - X;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 64 - 49;
    CelebrityTV.frame = CGRectMake(X,Y , width, height);
    
    //集成刷新控件
//    [self setupRefresh];
    
    [self.view addSubview:CelebrityTV];
    _CelebrityView = CelebrityTV;
    
    //注册cell
    [_CelebrityView registerNib:[UINib nibWithNibName:NSStringFromClass([RNCelebrityTableViewCell class]) bundle:nil] forCellReuseIdentifier:UserID];
    _CelebrityView.rowHeight = 60;

    
}

#pragma mark--TUITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _CategoryView) {//左边
        return _leftDataSoure.count;
    }else{
        
        HWLeftModel *leftModel = self.leftDataSoure[self.leftIndex];
        HWRightModel *rightModel = leftModel.rightModel;
        
        self.CelebrityView.mj_footer.hidden = (rightModel.users.count == 0);
        return rightModel.users.count;
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
        Tagcell.model = self.leftDataSoure[indexPath.row];
        Tagcell.backgroundColor = RNVIEWBGCOLOR;
        Tagcell.selectionStyle = UITableViewCellSelectionStyleNone;
        [Tagcell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
        
        return Tagcell;
    }else{//返回右边
    
        RNCelebrityTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:UserID ];
        HWLeftModel *leftModel = self.leftDataSoure[self.leftIndex];
        HWRightModel *rightModel = leftModel.rightModel;
        userCell.user = rightModel.users[indexPath.row];
        return userCell;
    }
    
}


#pragma mark--UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.leftIndex = indexPath.row;
    self.CelebrityView.mj_footer.hidden = YES;
    self.rightTabelViewPage = 1;
    
    HWLeftModel *leftModel = self.leftDataSoure[self.leftIndex];
    HWRightModel *rightModel = leftModel.rightModel;
    
    if (rightModel) {//右边的数据源有数据
        
        [self.CelebrityView reloadData];
        
        if(rightModel.users.count == 0){//没有数据
            self.CelebrityView.mj_footer.hidden = YES;
            
        }else if (rightModel.users.count == rightModel.total || rightModel.next_page > rightModel.total_page) {//只有一页数据/没有更多数据
            [self.CelebrityView.mj_footer endRefreshingWithNoMoreData];
        }
    
        
    } else {
        //刷新表格清除之前选中的Tag数据
        [self.CelebrityView reloadData];
        
        //请求数据
        [self usersSendDate];
    }
   
}

@end
