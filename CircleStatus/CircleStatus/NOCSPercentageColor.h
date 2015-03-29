//
//  NOCSPercentageColor.h
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Model class to fill percentageColorArray. Please note that the order is important.
@interface NOCSPercentageColor : NSObject

/// Title to show in legend
@property (nonatomic) NSString *title;

/// Color to be drawn.
@property (nonatomic) UIColor *color;

/// It will be recalculated to draw given color with angle. 1.f is 2PI. Please note, that the value must be (0.f; 1.f).
@property (nonatomic) CGFloat percentage;

/**
 * Common initializer.
 * @param title Shows on legend as description.
 * @param color Color used on both graph & legend.
 * @param percentage Percentage of graph to be filled with selected data.
 * @return self.
 */
- (instancetype)initWithTitle:(NSString *)title color:(UIColor *)color percentage:(CGFloat)percentage;

@end
