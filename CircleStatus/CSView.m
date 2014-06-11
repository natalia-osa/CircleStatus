//
//  CSView.m
//  CircleStatus
//
//  Created by Natalia Osiecka on 10.6.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "CSView.h"
#import "float.h"

#define floatEqual(x, y) (fabs(x-y) < accuracy_epsilon * FLT_EPSILON * fabs(x+y) || fabs(x-y) < FLT_MIN)
#define angleFromPercent(x) (2 * M_PI * x)
#define radians(x) (x * M_PI / 180)
#define degrees(x) (x * 180 / M_PI)

@implementation CSPercentageColor

- (instancetype)initWithColor:(UIColor *)color percentage:(CGFloat)percentage {
    self = [super init];
    if (self) {
        _color = color;
        _percentage = percentage;
    }
    return self;
}

@end

@interface CSView()
@property (nonatomic, assign) CGFloat radius;
@end

@implementation CSView

#pragma mark - Inits

- (id)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self setOpaque:NO];
    [self setAutoresizesSubviews:YES];
    
    _lineWidth = 10.f;
    _startAngle = 270.f;
    _fillColor = [UIColor whiteColor];
    
    _textLabel = [[UILabel alloc] init];
    [_textLabel setBackgroundColor:[UIColor clearColor]];
    [_textLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_textLabel];
    
    _imageView = [[UIImageView alloc] init];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [_imageView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_imageView];
}

#pragma mark - Setters

// redraw everything in case of overloading
- (void)setPercentageColorArray:(NSArray *)percentageColorArray {
    _percentageColorArray = percentageColorArray;
    
    [self setNeedsDisplay];
}

#pragma mark - Class methods

- (void)drawRect:(CGRect)rect {
    // we want the circle to fit to our view
    _radius = (CGRectGetWidth(rect) - _lineWidth) / 2;
    
    // by default draw full gray circle
    if (!_percentageColorArray || _percentageColorArray.count == 0) {
        _percentageColorArray = @[[[CSPercentageColor alloc] initWithColor:[UIColor grayColor] percentage:1.f]];
    }
    
    // make sure data is ok
    [self validateData];
    
    // draw the circle
    [self drawCircle];
}

#pragma mark - Drawing

- (void)drawCircle {
    // setup context
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    // get variables
    CGPoint center = CGPointMake(floorf(CGRectGetMidX(self.bounds)), floorf(CGRectGetMidY(self.bounds)));
    CGRect circleRect = CGRectMake(center.x - _radius + _lineWidth / 2, center.y - _radius + _lineWidth / 2, _radius * 2 - _lineWidth, _radius * 2 - _lineWidth);
    CGFloat startAngle = radians(_startAngle);
    
    // draw middle circle unless fill color is clearColor
    if (!CGColorEqualToColor([UIColor clearColor].CGColor, _fillColor.CGColor)) {
        CGContextBeginPath(context);
        CGContextSetFillColorWithColor(context, _fillColor.CGColor);
        CGContextFillEllipseInRect(context, circleRect);
        CGContextStrokePath(context);
    }
    
    // set frame for inside objects
    [_textLabel setFrame:CGRectIntegral(circleRect)];
    [_imageView setFrame:CGRectIntegral(CGRectInset(circleRect, _radius/2, _radius/2))];
    
    CGContextSetLineWidth(context, _lineWidth);
    // draw each part of outer circle
    for (CSPercentageColor *percColor in _percentageColorArray) {
        CGFloat endAngle = angleFromPercent(percColor.percentage);
        
        CGContextBeginPath(context);
        CGContextSetStrokeColorWithColor(context, percColor.color.CGColor);
        CGContextAddArc(context, center.x, center.y, _radius, startAngle, startAngle + endAngle, NO);
        CGContextStrokePath(context);
    
        startAngle += endAngle;
    }
}

#pragma mark - Helpers

- (void)validateData {
    CGFloat totalPercent = 0.f;
    for (CSPercentageColor *percColor in _percentageColorArray) {
        BOOL isPercentageColorClass = [percColor isKindOfClass:[CSPercentageColor class]];
        NSAssert(isPercentageColorClass, @"All data in percentageColorArray must be CSPercentageColor instance");
        
        BOOL isBetween0And1 = (percColor.percentage > 0.f || percColor.percentage < 1.f);
        NSAssert(isBetween0And1, @"Percentage must be between (0.f; 1.f)");
        
        totalPercent += percColor.percentage;
    }
    BOOL sumEquals1 = floatEqual(1.f, totalPercent) || totalPercent < 1.f;
    NSAssert(sumEquals1, @"The sum of percentages must be below or equal 1.f");
    BOOL angleIsBelow360 = (_startAngle <= 360);
    NSAssert(angleIsBelow360, @"Start angle can be only <0, 360>");
}

@end
