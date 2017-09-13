//
//  KCLyricView.h
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCLyricModel.h"
@class KCLyricView;
@protocol KCLyricViewDataSource <NSObject>

- (NSString *)lyricContentWithLyricView:(KCLyricView *)lyricView;

@optional
- (NSInteger)numberOfRowsInLyricView:(KCLyricView *)lyricView;

@end

@interface KCLyricView : UIView
@property (nonatomic,strong, readonly) KCLyricModel *lyricModel;

@property (nonatomic,assign) NSTimeInterval currentTime;

@property (nonatomic,weak) id<KCLyricViewDataSource> dataSource;

@property (nonatomic,strong) UIColor *normalTextColor;
@property (nonatomic,strong) UIColor *highlightedTextColor;
@property (nonatomic,strong) UIFont *textFont;

@property (nonatomic,assign) NSTextAlignment textAlignment;

@property (nonatomic,assign) BOOL scrollAnimation;

- (void)reloadData;

@end
