//
//  NOCSLegendPair.h
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Model class to keep reference to views inserted into CSLegendView.
@interface NOCSLegendPair : NSObject

/// View containing coloured dot. You can swap this view using customizedColorDotWithColor: in CSLegendView.
@property (nonatomic) UIView *colorDot;

/// View containing label describing coloured dot. You can swap this view using customizedLabelWithText: in CSLegendView.
@property (nonatomic) UILabel *label;

@end

NS_ASSUME_NONNULL_END
