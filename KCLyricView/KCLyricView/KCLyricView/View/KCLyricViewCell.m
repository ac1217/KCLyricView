//
//  KCLyricViewCell.m
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "KCLyricViewCell.h"


 NSString *const KCLyricViewCellReuseID = @"KCLyricViewCell";

@interface KCLyricViewCell ()

@property (nonatomic,strong) CAShapeLayer *normalMaskLayer;
@property (nonatomic,strong) CAShapeLayer *highlightedMaskLayer;

@end

@implementation KCLyricViewCell

- (CAShapeLayer *)normalMaskLayer
{
    if (!_normalMaskLayer) {
        _normalMaskLayer = [CAShapeLayer layer];
    }
    return _normalMaskLayer;
}

- (CAShapeLayer *)highlightedMaskLayer
{
    if (!_highlightedMaskLayer) {
        _highlightedMaskLayer = [CAShapeLayer layer];
    }
    return _highlightedMaskLayer;
}

- (UILabel *)normalLabel
{
    if (!_normalLabel) {
        _normalLabel = [[UILabel alloc] init];
        _normalLabel.layer.mask = self.normalMaskLayer;
    }
    return _normalLabel;
}

- (UILabel *)highlightedLabel
{
    if (!_highlightedLabel) {
        _highlightedLabel = [[UILabel alloc] init];
        
        _highlightedLabel.layer.mask = self.highlightedMaskLayer;
    }
    return _highlightedLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.normalLabel];
        [self.contentView addSubview:self.highlightedLabel];
        
    }
    return self;
}


- (void)setRowModel:(KCLyricRowModel *)rowModel
{
    _rowModel = rowModel;
    
    self.normalLabel.text = rowModel.row;
    self.highlightedLabel.text = rowModel.row;
    
    [self.normalLabel sizeToFit];
    [self.highlightedLabel sizeToFit];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (_textAlignment) {
        case NSTextAlignmentCenter:
            
            self.normalLabel.center = CGPointMake(self.contentView.bounds.size.width * 0.5, self.contentView.bounds.size.height * 0.5);
            self.highlightedLabel.center = self.normalLabel.center;
            break;
            
        case NSTextAlignmentLeft:{
            
            CGRect normalLabelFrame = self.normalLabel.frame;
            normalLabelFrame.origin.y = (self.contentView.bounds.size.height - normalLabelFrame.size.height) * 0.5;
            self.normalLabel.frame = normalLabelFrame;
            self.highlightedLabel.frame = self.normalLabel.frame;
            
        }
            break;
            
        case NSTextAlignmentRight:{
            
            CGRect normalLabelFrame = self.normalLabel.frame;
            normalLabelFrame.origin.y = (self.contentView.bounds.size.height - normalLabelFrame.size.height) * 0.5;
            normalLabelFrame.origin.x = self.contentView.bounds.size.width - normalLabelFrame.size.width;
            
            self.normalLabel.frame = normalLabelFrame;
            self.highlightedLabel.frame = self.normalLabel.frame;
            
        }
            break;
            
        default:
            break;
    }
    
    if (self.normalLabel.frame.size.width > self.contentView.frame.size.width) {
        
        CGRect normalLabelFrame = self.normalLabel.frame;
        normalLabelFrame.origin.x = 0;
        self.normalLabel.frame = normalLabelFrame;
        self.highlightedLabel.frame = self.normalLabel.frame;
        
    }
    
    self.normalMaskLayer.frame = self.normalLabel.bounds;
    
    self.highlightedMaskLayer.frame = self.highlightedLabel.bounds;
    
}


- (void)reset
{
    CGRect normalMaskLayerFrame = self.normalLabel.bounds;
    self.normalMaskLayer.path = [UIBezierPath bezierPathWithRect:normalMaskLayerFrame].CGPath;
    
    CGRect highlightedMaskLayerFrame = self.highlightedLabel.bounds;
    highlightedMaskLayerFrame.size.width = 0;
    
    self.highlightedMaskLayer.path = [UIBezierPath bezierPathWithRect:highlightedMaskLayerFrame].CGPath;
    
    
    self.normalLabel.transform = CGAffineTransformIdentity;
    self.highlightedLabel.transform = CGAffineTransformIdentity;
   
    
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    
    NSInteger index = [self searchIndexWithCurrentTime:currentTime];
    
    if (index < 0) {
        
        return;
    }
    
    KCLyricWordModel *wordModel = _rowModel.wordModels[index];
    
    CGFloat progress = (currentTime - wordModel.startTime) / wordModel.duration;
    
    if (progress < 0) {
        progress = 0;
    }else if (progress > 1) {
        progress = 1;
    }
    
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < index; i++) {
        
        KCLyricWordModel *wordModel = _rowModel.wordModels[i];
        [string appendString:wordModel.word];
    }
    
    CGFloat width = [string sizeWithAttributes:@{NSFontAttributeName : self.normalLabel.font}].width + [wordModel.word sizeWithAttributes:@{NSFontAttributeName : self.normalLabel.font}].width * progress;
    
    CGRect normalMaskLayerFrame = self.normalLabel.bounds;
    normalMaskLayerFrame.origin.x = width;
    normalMaskLayerFrame.size.width = self.normalLabel.bounds.size.width - normalMaskLayerFrame.origin.x;
    
    self.normalMaskLayer.path = [UIBezierPath bezierPathWithRect:normalMaskLayerFrame].CGPath;
    
    CGRect highlightedMaskLayerFrame = self.highlightedLabel.bounds;
    highlightedMaskLayerFrame.size.width = width;
    
    self.highlightedMaskLayer.path = [UIBezierPath bezierPathWithRect:highlightedMaskLayerFrame].CGPath;
    
    if (self.normalLabel.frame.size.width > self.contentView.bounds.size.width && width > self.contentView.bounds.size.width * 0.5 && width + self.contentView.bounds.size.width * 0.5 < self.normalLabel.frame.size.width) {
        
        CGFloat delta = width - self.contentView.bounds.size.width * 0.5;
        
        self.normalLabel.transform = CGAffineTransformMakeTranslation(-delta, 0);
        self.highlightedLabel.transform = CGAffineTransformMakeTranslation(-delta, 0);
        
    }
    
}

- (NSInteger)searchIndexWithCurrentTime:(NSTimeInterval)currentTime
{
    
    NSInteger beginIndex = 0;
    NSInteger endIndex = _rowModel.wordModels.count - 1;
    
    if (beginIndex > endIndex)
    {
        return -1;
    }
    
    NSInteger middleIndex = -1;
    while (beginIndex <= endIndex) {
        
        middleIndex = (endIndex + beginIndex) * 0.5;
        
        KCLyricWordModel *wordModel = _rowModel.wordModels[middleIndex];
        
        if ((NSInteger)(wordModel.startTime * 1000) <= (NSInteger)(currentTime * 1000) && (NSInteger)(wordModel.endTime * 1000) >= (NSInteger)(currentTime * 1000)) {
            return middleIndex;
            
        }else if ((NSInteger)(currentTime * 1000) < (NSInteger)(wordModel.startTime * 1000)) {
            
            endIndex = middleIndex - 1;
            
        }else if ((NSInteger)(currentTime * 1000) > (NSInteger)(wordModel.endTime * 1000)) {
            
            beginIndex = middleIndex + 1;
            
        }
        
    }
    
    return middleIndex;
}

@end
