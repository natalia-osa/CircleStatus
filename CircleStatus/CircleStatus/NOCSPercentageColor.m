//
//  NOCSPercentageColor.m
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import "NOCSPercentageColor.h"

@implementation NOCSPercentageColor

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
