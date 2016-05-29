//
//  NOCSView.m
//  CircleStatus
//
//  Created by Natalia Osiecka on 10.6.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import "NOCSView.h"
#import <NOCategories/NOCCGFloatMath.h>
#import "float.h"

#define angleFromPercent(x) (2 * M_PI * x)

@implementation NOCSView

#pragma mark - Memory management

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
    
    _legendView = [[NOCSLegendView alloc] init];
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
    
    // by default draw full gray circle
    _percentageColorArray = @[[[NOCSPercentageColor alloc] initWithTitle:@"Gray" color:[UIColor grayColor] percentage:1.f]];
    
    [self setShowsLegend:YES];
}

#pragma mark - Inherited

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    
    [self injectDemoData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self injectDemoData];
}

#pragma mark - Setters / Getters

- (void)setPercentageColorArray:(NSArray *)percentageColorArray {
    _percentageColorArray = percentageColorArray;
    
    // make sure data is ok
    [self validateData];
    
    // if we have legend view, redraw it also
    if (self.legendView) {
        [self.legendView setPercentageColorArray:percentageColorArray];
    }
    
    // redraw everything (set proper colors etc)
    [self setNeedsDisplay];
}

- (void)setShowsLegend:(BOOL)showsLegend {
    _showsLegend = showsLegend;
    
    [self.legendView setHidden:!showsLegend];
    
    // redraw everything (reposition circle view)
    [self setNeedsDisplay];
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    
    [self setNeedsDisplay];
}

- (void)setStartAngle:(NSUInteger)startAngle {
    _startAngle = startAngle % 360;
    
    [self setNeedsDisplay];
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    
    [self setNeedsDisplay];
}

#pragma mark Supply demo data

- (void)injectDemoData {
    [self setPercentageColorArray:@[[[NOCSPercentageColor alloc] initWithTitle:@"One" color:[UIColor blackColor] percentage:0.1f],
                                    [[NOCSPercentageColor alloc] initWithTitle:@"Two" color:[UIColor yellowColor] percentage:0.1f],
                                    [[NOCSPercentageColor alloc] initWithTitle:@"Three" color:[UIColor greenColor] percentage:0.1f],
                                    [[NOCSPercentageColor alloc] initWithTitle:@"Four" color:[UIColor redColor] percentage:0.2f],
                                    [[NOCSPercentageColor alloc] initWithTitle:@"Five" color:[UIColor purpleColor] percentage:0.05f],
                                    [[NOCSPercentageColor alloc] initWithTitle:@"Six" color:[UIColor brownColor] percentage:0.05f],
                                    [[NOCSPercentageColor alloc] initWithTitle:@"Seven with a very long description to see how the linebreak mode works - blah blah blah ^^"
                                                                         color:[UIColor whiteColor] percentage:0.3f]]];
    [self.textLabel setText:@"Chart"];
}

#pragma mark - Class methods

- (void)drawRect:(CGRect)rect {
    // we want the circle to fit to our view if not stated otherwise
    if (noc_isCGFloatEqualToCGFloat(self.radius, 0)) {
        NSLog(@"You should supply radius value to skip any unexpected behaviour.");
        self.radius = (MIN(CGRectGetWidth(rect), CGRectGetHeight(rect)) - self.lineWidth) / 2;
    }

    // draw the circle
    [self drawCircle];
}

#pragma mark - Drawing

- (void)drawCircle {
    CGRect frame = self.bounds;
    
    // setup context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, frame);
    
    // draw background color
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, frame);
    
    // get variables
    CGPoint center = CGPointMake(noc_floorCGFloat(CGRectGetMidX(frame)), noc_floorCGFloat(CGRectGetMidY(frame)));
    // in case we're showing legend, we need to move circle to different place
    if (self.showsLegend) {
        NSInteger circleRadius = self.radius + self.lineWidth / 2;
        CGRect legendRect = [self repositionCircleConsideringLegendPosition:self.legendView.legendPosition circleRadius:circleRadius circleCenter:&center];
        [self.legendView setFrame:legendRect];
    }
    CGRect circleRect = CGRectMake(center.x - self.radius + self.lineWidth / 2, center.y - self.radius + self.lineWidth / 2, self.radius * 2 - self.lineWidth, self.radius * 2 - self.lineWidth);
    CGFloat startAngle = noc_radians(self.startAngle);
    
    [self drawMidlleCircleInContext:context inRect:circleRect withFillColor:self.fillColor];
    
    // set frame for inside objects
    [self.textLabel setFrame:CGRectIntegral(circleRect)];
    [self.imageView setFrame:CGRectIntegral(CGRectInset(circleRect, self.radius / 2, self.radius / 2))];
    
    CGContextSetLineWidth(context, self.lineWidth);
    // draw each part of outer circle
    for (NOCSPercentageColor *percColor in self.percentageColorArray) {
        CGFloat endAngle = angleFromPercent(percColor.percentage);
        [self drawOuterCircleComponents:percColor atCenter:center withRadius:self.radius fromAngle:startAngle toEndAngle:endAngle inContext:context];
        startAngle += endAngle;
    }
}

- (void)drawOuterCircleComponents:(NOCSPercentageColor *)percColor atCenter:(CGPoint)center withRadius:(CGFloat)radius fromAngle:(CGFloat)startAngle toEndAngle:(CGFloat)endAngle inContext:(CGContextRef)context {
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, percColor.color.CGColor);
    CGContextAddArc(context, center.x, center.y, radius, startAngle, startAngle + endAngle, NO);
    CGContextStrokePath(context);
}

- (void)drawMidlleCircleInContext:(CGContextRef)context inRect:(CGRect)circleRect withFillColor:(UIColor *)fillColor {
    if (!CGColorEqualToColor([UIColor clearColor].CGColor, fillColor.CGColor)) { // skip if clean color
        CGContextBeginPath(context);
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillEllipseInRect(context, circleRect);
        CGContextStrokePath(context);
    }
}

- (CGRect)repositionCircleConsideringLegendPosition:(CSLegendPosition)legendPosition circleRadius:(NSInteger)circleRadius circleCenter:(CGPoint *)circleCenter {
    CGRect legendRect = self.bounds;
    CGPoint center = *circleCenter;
    switch (legendPosition) {
        case CSLegendPositionTop: {
            center.y = CGRectGetMaxY(legendRect) - circleRadius;
            legendRect.size.height -= 2 * circleRadius;
            break;
        } case CSLegendPositionRight: {
            center.x = CGRectGetMinX(legendRect) + circleRadius;
            legendRect.size.width -= 2 * circleRadius;
            legendRect.origin.x += 2 * circleRadius;
            break;
        } case CSLegendPositionBottom: {
            center.y = CGRectGetMinY(legendRect) + circleRadius;
            legendRect.size.height -= 2 * circleRadius;
            legendRect.origin.y += 2 * circleRadius;
            break;
        } case CSLegendPositionLeft: {
            center.x = CGRectGetMaxX(legendRect) - circleRadius;
            legendRect.size.width -= 2 * circleRadius;
            break;
        } default: {
            NSAssert(NO, @"The position has inproper value!");
        }
    }
    *circleCenter = center;
    
    return legendRect;
}

#pragma mark - Helpers

- (void)validateData {
    CGFloat totalPercent = 0.f;
    for (NOCSPercentageColor *percColor in self.percentageColorArray) {
        // Check percentage color class
        NSAssert([percColor isKindOfClass:[NOCSPercentageColor class]], @"All data in percentageColorArray must be CSPercentageColor instance");
        // Check if the color percentage is betweeen <0, 1>
        if (percColor.percentage < 0 || noc_isCGFloatMoreThanCGFloat(percColor.percentage, 1)) {
            NSLog(@"NOCircleStatus | ERROR | The color percentage is not between <0, 1>, the graph will be invalid");
        }
        
        totalPercent += percColor.percentage;
    }
    // sum of color percentages <= 1
    if (totalPercent < 0 || totalPercent > 1.001) { // the value may be more different than epsylon in case of adding many floating values
         NSLog(@"NOCircleStatus | ERROR | The colors percentage is not between <0, 1>, the graph will be invalid");
    }
    // startAngle < 360
    NSAssert(noc_isCGFloatLessOrEqualToCGFloat(self.startAngle, 360), @"Start angle can be only <0, 360>");
}

#pragma mark - CSLegendViewDelegate

- (CGFloat)csLegendViewRequiresChartHeight:(NOCSLegendView *)csLegendView {
    return self.radius * 2 + self.lineWidth;
}

#pragma mark - Logging

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@: %@, %@: %lu, %@: %d>",
            NSStringFromClass([self class]), self,
            NSStringFromSelector(@selector(percentageColorArray)), self.percentageColorArray,
            NSStringFromSelector(@selector(startAngle)), (unsigned long)self.startAngle,
            NSStringFromSelector(@selector(showsLegend)), (int)self.showsLegend];
}

@end
