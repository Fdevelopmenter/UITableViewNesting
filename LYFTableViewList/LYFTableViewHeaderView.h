//
//  LYFTableViewHeaderView.h
//  LYFTableViewList
//
//  Created by 李玉枫 on 2018/11/23.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LYFTableViewHeaderViewAction)(NSInteger index);

@interface LYFTableViewHeaderView : UITableViewHeaderFooterView

/// 比列
@property (nonatomic, assign) CGFloat proportion;
/// 点击事件
@property (nonatomic, copy) LYFTableViewHeaderViewAction clickAction;

@end
