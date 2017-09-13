//
//  KCLyricViewCell.h
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KCLyricRowModel.h"

extern NSString *const KCLyricViewCellReuseID;

@interface KCLyricViewCell : UITableViewCell

@property (nonatomic,strong) KCLyricRowModel *rowModel;

@property (nonatomic,strong) UILabel *normalLabel;
@property (nonatomic,strong) UILabel *highlightedLabel;
@property (nonatomic,assign) NSTextAlignment textAlignment;

- (void)setCurrentTime:(NSTimeInterval)currentTime;

- (void)reset;

@end
