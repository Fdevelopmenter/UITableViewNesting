//
//  LYFViewController.h
//  LYFTableViewList
//
//  Created by 李玉枫 on 2018/11/23.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LYFViewControllerAction)(void);

@interface LYFViewController : UIViewController

/// 列表
@property (nonatomic, strong) UITableView *tableView;
/// 是否可以滑动
@property (nonatomic, assign) BOOL isCanScroll;
/// 不滑动事件
@property (nonatomic, copy) LYFViewControllerAction noScrollAction;

@end
