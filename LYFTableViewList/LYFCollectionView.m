//
//  LYFCollectionView.m
//  LYFTableViewList
//
//  Created by 李玉枫 on 2018/11/23.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import "LYFCollectionView.h"
#import "LYFViewController.h"
#import "ViewController.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface LYFCollectionView() <UICollectionViewDataSource, UICollectionViewDelegate>

@end

static NSString *collectionViewCell = @"UICollectionViewCell";

@implementation LYFCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionViewCell];
    }
    
    return self;
}

#pragma mark - UICollectionViewDataSource / UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    /// 假设说只有两个控制器左右滑动
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    
    LYFViewController *controller = self.viewController.childViewControllers[indexPath.row];
    controller.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f - 50.f);
    [cell.contentView addSubview:controller.view];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollAction) {
        self.scrollAction(scrollView.contentOffset.x / kScreenWidth);
    }
}

@end
