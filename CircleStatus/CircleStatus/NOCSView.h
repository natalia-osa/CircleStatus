//
//  NOCSView.h
//  CircleStatus
//
//  Created by Natalia Osiecka on 10.6.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NOCSLegendView.h"
#import "NOCSPercentageColor.h"

/// Use to draw circle with selected properties in the middle of the view.
@interface NOCSView : UIView<NOCSLegendViewDelegate>

/// By default 1 gray color. Please note that total percentages from this array must give 1.f or less in total. If it is less, in the end of the circle we'll have 'clear' space.
@property (nonatomic) NSArray *percentageColorArray;

/// Use to determine width of outer line. By default 10.f.
@property (nonatomic) CGFloat lineWidth;

/// Use to change place, where 1st item is being drawn. Acceptable values (0; 360). Default 270.f (top middle). Eg 180 is left, 0 right, 45 is right bottom 'corner' etc.
@property (nonatomic) NSUInteger startAngle;

/// Use to fill the circle with given color. Set to clearColor to skip this step. Default whiteColor.
@property (nonatomic) UIColor *fillColor;

/// Label describing text in the middle. There is no default value, so it'll be invisible until you set it.
@property (nonatomic, readonly) UILabel *textLabel;

/// Image in place of label. You can support only one of these. You can support both views and set hidden property according to your needs, but keep in mind, that both visible will look ugly.
@property (nonatomic, readonly) UIImageView *imageView;

/// Legend view. You can set background color etc here.
@property (nonatomic, readonly) NOCSLegendView *legendView;

/// Whether to show legend. Position configurable via legendPosition property. Default YES.
@property (nonatomic) BOOL showsLegend;

/// REQUIRED. Determines the radius of a chart. If not supported, will auto-adjust to csView.frame, but Left/Right positions of legend can return wrong height calculation.
@property (nonatomic) CGFloat radius;

/**
 * Advanced: Overload the method to skip validation.
 * Please make sure everything works ok after your changes, as overloading this may result with errors.
 */
- (void)validateData;

/**
 * Advanced:
 * Overload to add custom subviews etc. Please don't forget to call super.
 */
- (void)commonInit;

@end
