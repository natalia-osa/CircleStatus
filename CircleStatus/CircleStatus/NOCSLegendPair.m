//
//  NOCSLegendPair.m
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import "NOCSLegendPair.h"

@implementation NOCSLegendPair

#pragma mark - Logging

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@: %@, %@: %@>",
            NSStringFromClass([self class]), self,
            NSStringFromSelector(@selector(colorDot)), self.colorDot,
            NSStringFromSelector(@selector(label)), self.label];
}

@end
