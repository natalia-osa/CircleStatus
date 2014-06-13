//
//  CSLegendView.m
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "CSLegendView.h"
#import "CSLegendPair.h"
#import "CSPercentageColor.h"
#import "NSString+Size.h"

@interface CSLegendView()

@property (nonatomic, strong) NSMutableArray *legendPairs;

@end

@implementation CSLegendView

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
    _legendPosition = CSLegendPositionRight;
    _showPercentage = YES;
    _dotSize = CGSizeMake(10.f, 10.f);
}

#pragma mark - Setters

- (void)setShowPercentage:(BOOL)showPercentage {
    _showPercentage = showPercentage;
    
    // we need to redraw everything
    [self redrawSubviews];
}

- (void)setPercentageColorArray:(NSArray *)percentageColorArray {
    _percentageColorArray = percentageColorArray;
    
    // we need to redraw everything
    [self redrawSubviews];
}

#pragma mark - Drawing

- (void)redrawSubviews {
    // get rid of previous views
    if (_legendPairs) {
        for (CSLegendPair *legendPair in _legendPairs) {
            [legendPair.colorDot removeFromSuperview];
            [legendPair.label removeFromSuperview];
        }
        _legendPairs = nil;
    }
    
    // setup new environment
    _legendPairs = [[NSMutableArray alloc] init];
    
    // add new views
    for (CSPercentageColor *percentageColor in _percentageColorArray) {
        NSString *labelString = _showPercentage ? [NSString stringWithFormat:@"~%d%% - %@", (int)(percentageColor.percentage * 100.f), percentageColor.title] : percentageColor.title;
        UILabel *label = [self customizedLabelWithText:labelString];
        [label setNumberOfLines:0.f];
        [self addSubview:label];
        
        UIView *colorDot = [self customizedColorDotWithColor:percentageColor.color];
        [self addSubview:colorDot];
        
        CSLegendPair *legendPair = [[CSLegendPair alloc] init];
        legendPair.colorDot = colorDot;
        legendPair.label = label;
        [_legendPairs addObject:legendPair];
    }
}

#pragma mark - Class methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat previousY = 0.f;
    for (CSLegendPair *legendPair in _legendPairs) {
        CGRect colorFrame; CGRect labelFrame;
        previousY = [self previousY:previousY item:legendPair colorFrame:&colorFrame labelFrame:&labelFrame inRect:self.bounds];
        [legendPair.colorDot setFrame:colorFrame];
        [legendPair.label setFrame:labelFrame];
    }
}

#pragma mark - Helpers

- (UILabel *)customizedLabelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:10.f]];
    [label setText:text];
    
    return label;
}

- (UIView *)customizedColorDotWithColor:(UIColor *)color {
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:color];
    [view.layer setCornerRadius:MIN(_dotSize.width, _dotSize.height) / 2.f];
    
    return view;
}

- (CGFloat)previousY:(CGFloat)previousY item:(CSLegendPair *)legendPair colorFrame:(CGRect *)colorFrame labelFrame:(CGRect *)labelFrame inRect:(CGRect)originRect {
    CGFloat margin = 3.f;
    
    CGSize labelSize = [legendPair.label.text ios67sizeWithFont:legendPair.label.font
                                              constrainedToSize:CGSizeMake(CGRectGetWidth(originRect) - _dotSize.width - margin * 2,
                                                                           MAXFLOAT)];
    CGFloat centerYAddValue = (labelSize.height - _dotSize.height) / 2.f;
    labelSize.width = MIN(CGRectGetWidth(originRect) - _dotSize.width - margin, labelSize.width);
    *colorFrame = CGRectMake(CGRectGetMinX(originRect) + margin,
                             floorf(previousY + ((centerYAddValue > 0.f) ? centerYAddValue : 0.f)),
                             _dotSize.width,
                             _dotSize.height);
    *labelFrame = CGRectMake(CGRectGetMaxX(legendPair.colorDot.frame) + margin,
                             previousY,
                             labelSize.width,
                             labelSize.height);
    
    //##OBJCLEAN_SKIP##
    return CGRectGetMaxY(*labelFrame) + margin;
    //##OBJCLEAN_ENDSKIP##
}

- (CGFloat)heightForChartSize:(CGSize)size {
    // Chart height
    CGFloat chartHeight = -1.f;
    if (_delegate && [_delegate respondsToSelector:@selector(csLegendViewRequiresChartHeight:)]) {
        chartHeight = [_delegate csLegendViewRequiresChartHeight:self];
    }
    if (chartHeight <= 0) {
        chartHeight = MIN(size.width, size.height);
    }
    
    // Total height of labels
    CGFloat labelsHeight = 0.f;
    for (CSLegendPair *legendPair in _legendPairs) {
        CGRect colorFrame; CGRect labelFrame;
        CGRect boundsRect = CGRectMake(0.f, 0.f, (_legendPosition == CSLegendPositionTop || _legendPosition == CSLegendPositionBottom) ? size.width : size.width - chartHeight, size.height);
        labelsHeight = [self previousY:labelsHeight item:legendPair colorFrame:&colorFrame labelFrame:&labelFrame inRect:boundsRect];
    }
    
    // If legend is above/below, we need to add legend to chart
    if (_legendPosition == CSLegendPositionTop || _legendPosition == CSLegendPositionBottom) {
        labelsHeight += chartHeight;
    // Otherwise, lets pick up higher value
    } else {
        labelsHeight = MAX(labelsHeight, chartHeight);
    }
    
    return labelsHeight;
}

@end
