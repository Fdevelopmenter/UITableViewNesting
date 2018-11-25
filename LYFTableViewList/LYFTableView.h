//
//  LYFTableView.h
//  LYFTableViewList
//
//  Created by 李玉枫 on 2018/11/23.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

typedef void(^LYFTableViewAction)(void);

@interface LYFTableView : UITableView

/// 控制器
@property (nonatomic, strong) ViewController *viewController;
/// 滑动事件
@property (nonatomic, copy) LYFTableViewAction scrollAction;

@end
