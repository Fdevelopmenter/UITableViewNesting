//
//  LYFTableView.m
//  LYFTableViewList
//
//  Created by 李玉枫 on 2018/11/23.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import "LYFTableView.h"
#import "ViewController.h"
#import "LYFCollectionView.h"
#import "LYFTableViewHeaderView.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface LYFTableView() <UITableViewDelegate, UITableViewDataSource>

/// 横向的滚动视图
@property (nonatomic, strong) LYFCollectionView *collectionView;

@end

static NSString *tableViewCell = @"UITableViewCell";
static NSString *tableViewHeaderView = @"LYFTableViewHeaderView";

@implementation LYFTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setupTableView];
    }
    
    return self;
}

#pragma mark - 允许接受多个手势 (这个方法很重要，不要遗漏)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - 设置列表
-(void)setupTableView {
    self.delegate = self;
    self.dataSource = self;
    /// 64.f 是导航控制器的高度    50.f是列表的section头的高度
    self.rowHeight = kScreenHeight - 64.f - 50.f;
    
    /// 设置tableView的表头
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    headerView.backgroundColor = [UIColor yellowColor];
    /// 0.5是因为刺眼😂
    headerView.alpha = 0.5;
    self.tableHeaderView = headerView;
    
    [self registerClass:[LYFTableViewHeaderView class] forHeaderFooterViewReuseIdentifier:tableViewHeaderView];
    
    __weak typeof(self) weakSelf = self;
    self.collectionView.scrollAction = ^(CGFloat proportion) {
        LYFTableViewHeaderView *header = (LYFTableViewHeaderView *)[weakSelf headerViewForSection:0];
        
        if (header) {
            header.proportion = proportion;
        }
    };
}

#pragma mark - Set方法
-(void)setViewController:(ViewController *)viewController {
    _viewController = viewController;
    
    self.collectionView.viewController = viewController;
}

#pragma mark - UITableViewDelegate / UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
        
        /// 在tableViewCell中添加控制器
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.collectionView];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LYFTableViewHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:tableViewHeaderView];
    
    __weak typeof(self) weakSelf = self;
    header.clickAction = ^(NSInteger index) {
        switch (index) {
            case 1: {
                [weakSelf.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
                break;
            }
            default: {
                [weakSelf.collectionView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
                break;
            }
        }
    };
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.f;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollAction) {
        self.scrollAction();
    }
}

#pragma mark - Get方法
-(LYFCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - 64.f - 50.f);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        /// 64.f 是导航控制器的高度    50.f是列表的section头的高度
        _collectionView = [[LYFCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50.f) collectionViewLayout:flowLayout];
    }
    
    return _collectionView;
}

@end
