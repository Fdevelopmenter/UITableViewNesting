//
//  LYFTableViewHeaderView.m
//  LYFTableViewList
//
//  Created by 李玉枫 on 2018/11/23.
//  Copyright © 2018 李玉枫. All rights reserved.
//

#import "LYFTableViewHeaderView.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface LYFTableViewHeaderView()

/// 按钮1
@property (nonatomic, strong) UIButton *oneButton;
/// 按钮2
@property (nonatomic, strong) UIButton *twoButton;

@end

@implementation LYFTableViewHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupHeaderView];
    }
    
    return self;
}

#pragma mark - 设置section头部视图
-(void)setupHeaderView {
    [self.contentView addSubview:self.oneButton];
    [self.contentView addSubview:self.twoButton];
    
    self.proportion = 0;
}

#pragma mark - 点击事件
-(void)clickAction:(UIButton *)button {
    if (self.clickAction) {
        self.clickAction(button.tag);
    }
}

#pragma mark - Set方法
-(void)setProportion:(CGFloat)proportion {
    _proportion = proportion;
    
    CGFloat max = 0.4;
    self.oneButton.transform = CGAffineTransformMakeScale(1 + (1 - proportion) * max, 1 + (1 - proportion) * max);
    self.twoButton.transform = CGAffineTransformMakeScale(1 + proportion * max, 1 + proportion * max);
    
    self.oneButton.alpha = (1 - proportion * max);
    self.twoButton.alpha = 0.8 + proportion * max;
}

#pragma mark - Get方法
-(UIButton *)oneButton {
    if (!_oneButton) {
        _oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _oneButton.frame = CGRectMake(0, 0, kScreenWidth / 2, 50.f);
        [_oneButton setTitle:@"按钮1" forState:UIControlStateNormal];
        [_oneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_oneButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _oneButton.tag = 1;
    }
    
    return _oneButton;
}

-(UIButton *)twoButton {
    if (!_twoButton) {
        _twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _twoButton.frame = CGRectMake(kScreenWidth / 2, 0, kScreenWidth / 2, 50.f);
        [_twoButton setTitle:@"按钮2" forState:UIControlStateNormal];
        [_twoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_twoButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _twoButton.tag = 2;
    }
    
    return _twoButton;
}

@end
