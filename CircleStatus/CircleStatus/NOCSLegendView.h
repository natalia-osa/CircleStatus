//
//  NOCSLegendView.h
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import <UIKit/UIKit.h>

/// The position determines where CSView will locate CSLegendView.
typedef NS_ENUM(NSUInteger, CSLegendPosition) {
    CSLegendPositionTop = 0,
    CSLegendPositionRight,
    CSLegendPositionBottom,
    CSLegendPositionLeft
};

@class NOCSLegendView, CSLegendViewDelegate;

/// Protocol used by CSView.
@protocol NOCSLegendViewDelegate <NSObject>

/**
 * Method implemented by CSView, usually you don't want to mess with this. Requires information about chart height.
 * @param csLegendView Usually self, informs about sender.
 * @return Height reserved for the chart.
 */
- (CGFloat)csLegendViewRequiresChartHeight:(NOCSLegendView *)csLegendView;

@end

/// View which shows dots, percentage and name of each of values. Keep in mind, that you have to [csViewProperty setBackgroundColor:[UIColor clearColor]] to get clear background - otherwise it's white.
@interface NOCSLegendView : UIView

/// Delegate implemented by CSView
@property (nonatomic, weak) id<NOCSLegendViewDelegate> delegate;

/// The order is color - percentage - title. By default shows the percentage (YES).
@property (nonatomic) BOOL showPercentage;

/// Change position of legend. Keep in mind the size of the view. Default CSLegendPositionRight.
@property (nonatomic) CSLegendPosition legendPosition;

/// Overloading this may cause legend to be incompatible with CSView. CSView is handling this variable.
@property (nonatomic) NSArray *percentageColorArray;

/// Size of coloured dot (view) before text description.
@property (nonatomic) CGSize dotSize;

/**
 * Advanced:
 * Overload to add custom subviews etc. Please don't forget to call super.
 */
- (void)commonInit;

/**
 *  Convenience method to return customized label. Can be overloaded - return your custom label.
 *  @param text Text to show on the label.
 *  @return The customized label.
 */
- (UILabel *)customizedLabelWithText:(NSString *)text;

/**
 *  Convenience method to return colored dot view. Can be overloaded - return your custom view, which should appear before legend text.
 *  @param color Color to fill the view with.
 *  @return The customized legend dot view.
 */
- (UIView *)customizedColorDotWithColor:(UIColor *)color;

/**
 *  Calculates the total height of legend and chart. Can be overloaded - return required height for the legend.
 *  @param size Chart size.
 *  @return The legend height for given chart size.
 */
- (CGFloat)heightForChartSize:(CGSize)size;

@end
