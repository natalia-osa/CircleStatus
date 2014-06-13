//
//  CSPercentageColor.m
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "CSPercentageColor.h"

@implementation CSPercentageColor

- (instancetype)initWithTitle:(NSString *)title color:(UIColor *)color percentage:(CGFloat)percentage {
    self = [super init];
    if (self) {
        _title = title;
        _color = color;
        _percentage = percentage;
    }
    
    return self;
}

@end
