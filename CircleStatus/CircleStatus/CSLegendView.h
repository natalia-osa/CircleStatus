//
//  CSLegendView.h
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 The position determines where CSView will locate CSLegendView.
 **/
typedef NS_ENUM(NSUInteger, CSLegendPosition) {
    CSLegendPositionTop = 0,
    CSLegendPositionRight,
    CSLegendPositionBottom,
    CSLegendPositionLeft
};

@class CSLegendView, CSLegendViewDelegate;

/**
 Protocol used by CSView.
 **/
@protocol CSLegendViewDelegate <NSObject>
- (CGFloat)csLegendViewRequiresChartHeight:(CSLegendView *)csLegendView;
@end

/**
 View which shows dots, percentage and name of each of values. Keep in mind, that you have to [csViewProperty setBackgroundColor:[UIColor clearColo]] to get clear background - otherwise it's white.
 **/
@interface CSLegendView : UIView
@property (nonatomic, weak) id<CSLegendViewDelegate> delegate;

/**
 The order is color - percentage - title. By default shows the percentage (YES).
 **/
@property (nonatomic, assign) BOOL showPercentage;

/**
 Change position of legend. Keep in mind the size of the view. Default CSLegendPositionRight.
 **/
@property (nonatomic, assign) CSLegendPosition legendPosition;

/**
 Overloading this may cause legend to be incompatible with CSView. CSView is handling this variable.
 **/
@property (nonatomic, strong) NSArray *percentageColorArray;

/**
 Size of coloured dot (view) before text description.
 **/
@property (nonatomic, assign) CGSize dotSize;

/**
 Advanced:
 Overload to add custom subviews etc. Please don't forget to call super.
 **/
- (void)commonInit;

/**
 Return your own customized label.
 **/
- (UILabel *)customizedLabelWithText:(NSString *)text;

/**
 Return your own view if dot isn't what you expect before text description.
 **/
- (UIView *)customizedColorDotWithColor:(UIColor *)color;

/**
 Calculates the total height of legend and chart.
 **/
- (CGFloat)heightForChartSize:(CGSize)size;

@end
