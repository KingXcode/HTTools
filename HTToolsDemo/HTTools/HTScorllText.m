//
//  HTScorllText.m
//  HTToolsDemo
//
//  Created by mypc on 2020/7/16.
//  Copyright © 2020 niesiyang. All rights reserved.
//

#import "HTScorllText.h"


@interface HTScorllText ()

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat textWidth;
@property (nonatomic,assign) CGFloat distance;//0.1秒移动的实际pt
@property (nonatomic,strong) CADisplayLink * displayLink;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;

@end

@implementation HTScorllText

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.width = frame.size.width;
        self.height = frame.size.height;
        [self initUSerInterface];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.width = self.frame.size.width;
    self.height = self.frame.size.height;
    [self initUSerInterface];
    [self start];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.width = self.frame.size.width;
    self.height = self.frame.size.height;
    [self labelAttrbuits];
    [self start];
}

#pragma mark -- private
- (void)initUSerInterface {
    self.clipsToBounds = YES;
    _distance = _rate>0 ? _rate * 10 : 5;
    _interval = _interval>0 ? _interval : 20;
    _style = HTTextScorllStyleDefault;
    [self creatLabel];
}

- (void)creatLabel
{
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(_width, 0, _width, _height)];
    self.label1.font = self.label2.font = [UIFont systemFontOfSize:12];
    
    if (_textColor) {
        self.label1.textColor = self.label2.textColor = _textColor;
    }
    if (_text && _text.length > 0) {
        self.label1.text = self.label2.text = _text;
    }
    [self addSubview:self.label1];
    [self addSubview:self.label2];
}

- (void)labelAttrbuits
{
    [self.label1 sizeToFit];
    [self.label2 sizeToFit];
    
    _textWidth = CGRectGetWidth(self.label1.frame);
    if (_textWidth<_width) { _textWidth = _width; }
    
    self.label1.center = CGPointMake(_textWidth / 2, _height / 2.0);
    self.label2.center = CGPointMake(_textWidth / 2 + _width, _height / 2.0);
}

- (void)labelChange
{
    if (_style == HTTextScorllStyleDefault && _textWidth <= _width) {
        [self stop];
        return;
    }
    
    CGRect frame1 = self.label1.frame;
    CGFloat maxX1 = CGRectGetMaxX(self.label1.frame);
    
    CGRect frame2 = self.label2.frame;
    CGFloat maxX2 = CGRectGetMaxX(self.label2.frame);
    
    if (_width - maxX1 >= _interval || (frame2.origin.x > -_textWidth && maxX2 < _width + _textWidth)) {
        frame2.origin.x -= _distance;
    }
    
    if (_width - maxX2 >= _interval || (frame1.origin.x > -_textWidth && maxX1 < _width + _textWidth)) {
        frame1.origin.x -= _distance;
    }
    
    if (maxX1 < -3) {
        frame1.origin.x = _width;
    }
    
    if (maxX2 < -3) {
        frame2.origin.x = _width;
    }
    
    self.label1.frame = frame1;
    self.label2.frame = frame2;
    
}

#pragma mark -- timer
- (void)start
{
    if (_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(labelChange)];
        if (@available(iOS 10.0, *)) {
            _displayLink.preferredFramesPerSecond = 0.1;
        } else {
            _displayLink.frameInterval = 0.1;
        }
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    _displayLink.paused = NO;
}

- (void)pause
{
    _displayLink.paused = YES;
}

- (void)stop
{
    if (_displayLink) {
        [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

#pragma mark -- setter
- (void)setText:(NSString *)text {
    _text = text;
    self.label1.text = self.label2.text = text;
    self.clipsToBounds = YES;
    [self labelAttrbuits];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.label1.font = self.label2.font = font;
    [self labelAttrbuits];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.label1.textColor = self.label2.textColor = textColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    self.label1.textAlignment = self.label2.textAlignment = textAlignment;
    [self labelAttrbuits];
}

- (void)setStyle:(HTTextScorllStyle)style {
    _style = style;
    [self start];
}

- (void)setRate:(CGFloat)rate {
    _rate = rate > 1 ? 1 : rate;
    _rate = _rate < 0 ? 0 : _rate;
    _distance = _rate * 10;
}

- (void)setInterval:(CGFloat)interval {
    _interval = interval;
}



@end
