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
 * Select proper size calculation method to receive text size prior and after ios 7.
 * @param font The font to use for computing the string size.
 * @param size The maximum acceptable size for the string. This value is used to calculate where line breaks and wrapping would occur.
 * @return The width and height of the resulting string’s bounding box. These values may be rounded up to the nearest whole number.
 */
- (CGSize)ios67sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
