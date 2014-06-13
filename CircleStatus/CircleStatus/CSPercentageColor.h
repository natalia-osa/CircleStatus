//
//  CSPercentageColor.h
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Model class to fill percentageColorArray. Please note that the order is important.
 **/
@interface CSPercentageColor : NSObject

/**
 Title to show in legend
 **/
@property (nonatomic, strong) NSString *title;

/**
 Color to be drawn.
 **/
@property (nonatomic, strong) UIColor *color;

/**
 It will be recalculated to draw given color with angle. 1.f is 2PI. Please note, that the value must be (0.f; 1.f).
 **/
@property (nonatomic, assign) CGFloat percentage;

/**
 Common initializer.
 **/
- (instancetype)initWithTitle:(NSString *)title color:(UIColor *)color percentage:(CGFloat)percentage;

@end
