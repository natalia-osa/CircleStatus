//
//  CSView.h
//  CircleStatus
//
//  Created by Natalia Osiecka on 10.6.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import <UIKit/UIKit.h>

#define accuracy_epsilon 1

/**
 Model class to fill percentageColorArray. Please note that the order is important.
 **/
@interface CSPercentageColor : NSObject

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
- (instancetype)initWithColor:(UIColor *)color percentage:(CGFloat)percentage;

@end


/**
 Use to draw circle with selected properties in the middle of the view.
 **/
@interface CSView : UIView

/**
 By default 1 gray color. Please note that total percentages from this array must give 1.f or less in total. If it is less, in the end of the circle we'll have 'clear' space.
 **/
@property (nonatomic, strong) NSArray *percentageColorArray;

/**
 Use to determine width of outer line. By default 10.f.
 **/
@property (nonatomic, assign) CGFloat lineWidth;

/**
 Use to change place, where 1st item is being drawn. Acceptable values (0; 360). Default 270.f (top middle). Eg 180 is left, 0 right, 45 is right bottom 'corner' etc.
 **/
@property (nonatomic, assign) NSUInteger startAngle;

/**
 Use to fill the circle with given color. Set to clearColor to skip this step. Default whiteColor.
 **/
@property (nonatomic, strong) UIColor *fillColor;

/**
 Label describing text in the middle. There is no default value, so it'll be invisible until you set it.
 **/
@property (nonatomic, strong, readonly) UILabel *textLabel;

/**
 Image in place of label. You can support only one of these. You can support both views and set hidden property according to your needs, but keep in mind, that both visible will look ugly.
 **/
@property (nonatomic, strong, readonly) UIImageView *imageView;

/**
 Advanced: 
 Overload this method to skip validation - please make sure everything works ok after your changes, as overloading this may result with errors.
 **/
- (void)validateData;

/**
 Advanced:
 Overload to add custom subviews etc. Please don't forget to call super.
 **/
- (void)commonInit;

@end
