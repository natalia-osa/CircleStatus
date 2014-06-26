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
#define accuracy_epsilon 1

@implementation CSView

#pragma mark - Inits

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
    [self setContentMode:UIViewContentModeRedraw];
    
    _lineWidth = 10.f;
    _startAngle = 270.f;
    _fillColor = [UIColor whiteColor];
    
    _legendView = [[CSLegendView alloc] init];
    [_legendView setDelegate:self];
    [self addSubview:_legendView];
    
    _textLabel = [[UILabel alloc] init];
    [_textLabel setBackgroundColor:[UIColor clearColor]];
    [_textLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_textLabel];
    
    _imageView = [[UIImageView alloc] init];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [_imageView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_imageView];
    
    [self setShowsLegend:YES];
}

#pragma mark - Setters

- (void)setPercentageColorArray:(NSArray *)percentageColorArray {
    _percentageColorArray = percentageColorArray;
    // if we have legend view, redraw it also
    if (_legendView) {
        [_legendView setPercentageColorArray:percentageColorArray];
    }
    
    // redraw everything (set proper colors etc)
    [self setNeedsDisplay];
}

- (void)setShowsLegend:(BOOL)showsLegend {
    _showsLegend = showsLegend;
    
    [_legendView setHidden:!showsLegend];
    
    // redraw everything (reposition circle view)
    [self setNeedsDisplay];
}

#pragma mark - Class methods

- (void)drawRect:(CGRect)rect {
    // we want the circle to fit to our view if not stated otherwise
    if (_radius == 0) {
        NSLog(@"You should supply radius value to skip any unexpected behaviour.");
        _radius = (MIN(CGRectGetWidth(rect), CGRectGetHeight(rect)) - _lineWidth) / 2;
    }
    
    // by default draw full gray circle
    if (!_percentageColorArray || _percentageColorArray.count == 0) {
        _percentageColorArray = @[[[CSPercentageColor alloc] initWithTitle:@"Gray" color:[UIColor grayColor] percentage:1.f]];
    }
    
    // make sure data is ok
    [self validateData];

    // draw the circle
    [self drawCircle];
}

#pragma mark - Drawing

- (void)drawCircle {
    // setup context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    // draw background color
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, self.bounds);
    
    // get variables
    CGPoint center = CGPointMake(floorf(CGRectGetMidX(self.bounds)), floorf(CGRectGetMidY(self.bounds)));
    // in case we're showing legend, we need to move circle to different place
    if (_showsLegend) {
        NSInteger circleRadius = _radius + _lineWidth / 2;
        CGRect legendRect = self.bounds;
        switch (_legendView.legendPosition) {
            case CSLegendPositionTop: {
                center.y = CGRectGetMaxY(self.bounds) - circleRadius;
                legendRect.size.height -= 2 * circleRadius;
                break;
            }
            case CSLegendPositionRight: {
                center.x = CGRectGetMinX(self.bounds) + circleRadius;
                legendRect.size.width -= 2 * circleRadius;
                legendRect.origin.x += 2 * circleRadius;
                break;
            }
            case CSLegendPositionBottom: {
                center.y = CGRectGetMinY(self.bounds) + circleRadius;
                legendRect.size.height -= 2 * circleRadius;
                legendRect.origin.y += 2 * circleRadius;
                break;
            }
            case CSLegendPositionLeft: {
                center.x = CGRectGetMaxX(self.bounds) - circleRadius;
                legendRect.size.width -= 2 * circleRadius;
                break;
            }
            default: {
                NSAssert(false, @"The position has inproper value!");
                break;
            }
        }
        [_legendView setFrame:legendRect];
    }
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
    [_imageView setFrame:CGRectIntegral(CGRectInset(circleRect, _radius / 2, _radius / 2))];
    
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
        // isPercentageColorClass
        NSAssert([percColor isKindOfClass:[CSPercentageColor class]], @"All data in percentageColorArray must be CSPercentageColor instance");
        // isBetween0And1
        NSAssert((percColor.percentage > 0.f || percColor.percentage < 1.f), @"Percentage must be between (0.f; 1.f)");
        
        totalPercent += percColor.percentage;
    }
    // sumEquals1
    NSAssert((floatEqual(1.f, totalPercent) || totalPercent < 1.f), @"The sum of percentages must be below or equal 1.f");
    // angleIsBelow360
    NSAssert((_startAngle <= 360), @"Start angle can be only <0, 360>");
}

#pragma mark - CSLegendViewDelegate

- (CGFloat)csLegendViewRequiresChartHeight:(CSLegendView *)csLegendView {
    return _radius * 2 + _lineWidth;
}

@end
