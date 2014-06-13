//
//  NSString+Size.m
//  CircleStatus
//
//  Created by Natalia Osiecka on 12.6.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

/**
 Select proper method to calculate text size prior and after ios 7.
 **/
- (CGSize)ios67sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
