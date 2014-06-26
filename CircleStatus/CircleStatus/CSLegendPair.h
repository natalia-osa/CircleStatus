//
//  CSLegendPair.h
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Model class to keep reference to views inserted into CSLegendView.
@interface CSLegendPair : NSObject

/// View containing coloured dot. You can swap this view using customizedColorDotWithColor: in CSLegendView.
@property (nonatomic, strong) UIView *colorDot;

/// View containing label describing coloured dot. You can swap this view using customizedLabelWithText: in CSLegendView.
@property (nonatomic, strong) UILabel *label;

@end
