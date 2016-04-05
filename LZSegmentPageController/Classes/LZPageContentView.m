//
//  LZPageContentView.m
//  HXClient
//
//  Created by nacker on 16/3/23.
//  Copyright © 2016年 帶頭二哥 QQ:648959. All rights reserved.
//

#import "LZPageContentView.h"
//#import "Masonry.h"

@interface LZPageContentView()

@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation LZPageContentView

- (instancetype)initWithFrame:(CGRect)frame itemsArray:(NSArray *)itemsArray
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];

        float width = CGRectGetWidth(frame) / itemsArray.count;

        NSMutableArray *views = [NSMutableArray array];
        for (int i = 0; i < itemsArray.count; i++) {
            UIButton *btn = [[UIButton alloc] init];
            [btn setFrame:CGRectMake(width * i, 0, width, CGRectGetHeight(frame))];
            btn.tag = i;
            self.userInteractionEnabled = YES;
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitle:itemsArray[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            [views addObject:btn];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)btnClick:(UIButton *)btn
{
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;

    if ([self.delegate respondsToSelector:@selector(pageContentView:didClickBtnIndex:)]) {
        [self.delegate pageContentView:self didClickBtnIndex:btn.tag];
    }
}

- (void)setDelegate:(id<LZPageContentViewDelegate>)delegate
{
    _delegate = delegate;
    
    UIButton *btn = self.subviews.firstObject;
    [self btnClick:btn];
}

- (void)setIndex:(int)index
{
    self.selectBtn.selected = NO;
    UIButton *btn = self.subviews[index];
    btn.selected = YES;
    self.selectBtn = btn;
}

@end
