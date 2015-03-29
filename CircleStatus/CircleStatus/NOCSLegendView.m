//
//  NOCSLegendView.m
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import "NOCSLegendView.h"
#import "NOCSLegendPair.h"
#import "NOCSPercentageColor.h"
#import <NOCategories/NSString+NOCSize.h>
#import <NOCategories/NOCMacros.h>

@interface NOCSLegendView()

@property (nonatomic) NSMutableArray *legendPairs;

@end

@implementation NOCSLegendView

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
    _legendPosition = CSLegendPositionRight;
    _showPercentage = YES;
    _dotSize = CGSizeMake(10.f, 10.f);
}

#pragma mark - Setters / Getters

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
    if (self.legendPairs) {
        for (NOCSLegendPair *legendPair in self.legendPairs) {
            [legendPair.colorDot removeFromSuperview];
            [legendPair.label removeFromSuperview];
        }
        self.legendPairs = nil;
    }
    
    // setup new environment
    self.legendPairs = [[NSMutableArray alloc] init];
    
    // add new views
    for (NOCSPercentageColor *percentageColor in self.percentageColorArray) {
        [self redrawPercentageColor:percentageColor];
    }
}

- (void)redrawPercentageColor:(NOCSPercentageColor *)percentageColor {
    NSString *labelString = self.showPercentage ? [NSString stringWithFormat:@"~%d%% - %@", (int)(percentageColor.percentage * 100.f), percentageColor.title] : percentageColor.title;
    UILabel *label = [self customizedLabelWithText:labelString];
    [label setNumberOfLines:0.f];
    [self addSubview:label];
    
    UIView *colorDot = [self customizedColorDotWithColor:percentageColor.color];
    [self addSubview:colorDot];
    
    NOCSLegendPair *legendPair = [[NOCSLegendPair alloc] init];
    legendPair.colorDot = colorDot;
    legendPair.label = label;
    [self.legendPairs addObject:legendPair];
}

#pragma mark - Class methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat previousY = 0.f;
    for (NOCSLegendPair *legendPair in self.legendPairs) {
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
    [view.layer setCornerRadius:MIN(self.dotSize.width, self.dotSize.height) / 2.f];
    
    return view;
}

- (CGFloat)previousY:(CGFloat)previousY item:(NOCSLegendPair *)legendPair colorFrame:(CGRect *)colorFrame labelFrame:(CGRect *)labelFrame inRect:(CGRect)originRect {
    CGFloat margin = 3.f;
    
    CGSize maxLabelSize = CGSizeMake(CGRectGetWidth(originRect) - self.dotSize.width - margin * 2, MAXFLOAT);
    CGSize labelSize = [legendPair.label.text noc_backwardCompatibleSizeWithFont:legendPair.label.font constrainedToSize:maxLabelSize];
    CGFloat centerYAddValue = (labelSize.height - self.dotSize.height) / 2.f;
    labelSize.width = MIN(CGRectGetWidth(originRect) - self.dotSize.width - margin, labelSize.width);
    *colorFrame = CGRectMake(CGRectGetMinX(originRect) + margin,
                             noc_floorCGFloat(previousY + ((centerYAddValue > 0.f) ? centerYAddValue : 0.f)),
                             self.dotSize.width,
                             self.dotSize.height);
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(csLegendViewRequiresChartHeight:)]) {
        chartHeight = [self.delegate csLegendViewRequiresChartHeight:self];
    }
    if (chartHeight <= 0) {
        chartHeight = MIN(size.width, size.height);
    }
    
    // Total height of labels
    CGFloat labelsHeight = 0.f;
    for (NOCSLegendPair *legendPair in self.legendPairs) {
        CGRect colorFrame; CGRect labelFrame;
        CGRect boundsRect = CGRectMake(0.f, 0.f, (self.legendPosition == CSLegendPositionTop || self.legendPosition == CSLegendPositionBottom) ? size.width : size.width - chartHeight, size.height);
        labelsHeight = [self previousY:labelsHeight item:legendPair colorFrame:&colorFrame labelFrame:&labelFrame inRect:boundsRect];
    }
    
    // If legend is above/below, we need to add legend to chart
    if (self.legendPosition == CSLegendPositionTop || self.legendPosition == CSLegendPositionBottom) {
        labelsHeight += chartHeight;
    } else { // Otherwise, lets pick up higher value
        labelsHeight = MAX(labelsHeight, chartHeight);
    }
    
    return labelsHeight;
}

#pragma mark - Logging

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@: %d, %@: %lu, %@: %@>",
            NSStringFromClass([self class]), self,
            NSStringFromSelector(@selector(showPercentage)), (int)self.showPercentage,
            NSStringFromSelector(@selector(legendPosition)), (unsigned long)self.legendPosition,
            NSStringFromSelector(@selector(percentageColorArray)), self.percentageColorArray];
}

@end
