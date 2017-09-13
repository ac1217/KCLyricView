//
//  KCLyricView.m
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "KCLyricView.h"
#import "KCLyricViewCell.h"

@interface KCLyricView ()<UITableViewDataSource, UITableViewDelegate> {
    
    KCLyricModel *_lyricModel;
    
}
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSIndexPath *currentIndexPath;


@property (nonatomic,assign, getter=isDragging) BOOL dragging;

@end

@implementation KCLyricView

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[KCLyricViewCell class] forCellReuseIdentifier:KCLyricViewCellReuseID];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (NSInteger)numberOfRows
{
    if ([_dataSource respondsToSelector:@selector(numberOfRowsInLyricView:)]) {
        return [_dataSource numberOfRowsInLyricView:self];
    }
    return 3;
}

- (NSString *)lyricContent
{
    return [_dataSource lyricContentWithLyricView:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollAnimation = YES;
        [self addSubview:self.tableView];
        _textAlignment = NSTextAlignmentCenter;
        _normalTextColor = [UIColor blueColor];
        _highlightedTextColor = [UIColor orangeColor];
        _textFont = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    
    NSInteger index = [self searchIndexWithCurrentTime:currentTime];
    
    if (index < 0) {
        return;
    }
    
    _currentTime = currentTime;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    if (indexPath != _currentIndexPath) {
        
        KCLyricViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentIndexPath];
        
        [cell reset];
        
        if (!self.isDragging) {
            
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:_scrollAnimation];
        }
        
        
    }
    
    KCLyricViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [cell setCurrentTime:currentTime - cell.rowModel.startTime];
    
    _currentIndexPath = indexPath;
    
}

- (NSInteger)searchIndexWithCurrentTime:(NSTimeInterval)currentTime
{
    if (_currentIndexPath) {
        
        NSInteger index = _currentIndexPath.row;
        KCLyricRowModel *rowModel = _lyricModel.rowModels[index];
        if (rowModel.startTime <= currentTime && rowModel.endTime >= currentTime) {
            
            return index;
            
        }
        
        if (index + 1 < _lyricModel.rowModels.count) {
            
            KCLyricRowModel *rowModel = _lyricModel.rowModels[index + 1];
            
            if (rowModel.startTime <= currentTime && rowModel.endTime >= currentTime) {
                
                return index + 1;
                
            }
            
        }
        
    }
    
    
    NSInteger beginIndex = 0;
    NSInteger endIndex = _lyricModel.rowModels.count - 1;
    
    if (beginIndex > endIndex)
    {
        return -1;
    }
    
    NSInteger middleIndex = -1;
    while (beginIndex <= endIndex) {
        
        middleIndex = (endIndex + beginIndex) * 0.5;
        
        KCLyricRowModel *rowModel = _lyricModel.rowModels[middleIndex];
        
        if (rowModel.startTime <= currentTime && rowModel.endTime >= currentTime) {
            
            return middleIndex;
            
        }else if (currentTime < rowModel.startTime) {
            
            endIndex = middleIndex - 1;
            
        }else if (currentTime > rowModel.endTime) {
            
            beginIndex = middleIndex + 1;
            
        }
        
    }
    
    return -1;
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lyricModel.rowModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KCLyricViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCLyricViewCellReuseID];
    
    cell.normalLabel.textColor = _normalTextColor;
    cell.highlightedLabel.textColor = _highlightedTextColor;
    cell.normalLabel.font = _textFont;
    cell.highlightedLabel.font = _textFont;
    cell.textAlignment = _textAlignment;
    
    cell.rowModel = _lyricModel.rowModels[indexPath.row];
    
    if (_currentIndexPath == indexPath) {
        
        [cell setCurrentTime:_currentTime - cell.rowModel.startTime];
        
    }else {
        
        [cell reset];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.height / self.numberOfRows;
}


- (void)reloadData
{
    _currentIndexPath = nil;
    
    NSString *lyricContent = [self lyricContent];
    
    _lyricModel = [[KCLyricModel alloc] initWithLyricContent:lyricContent];
    
    [self.tableView reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _dragging = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _dragging = NO;
}

@end
