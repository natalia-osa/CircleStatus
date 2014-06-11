//
//  CSExampleView.m
//  CircleStatus
//
//  Created by Natalia Osiecka on 11.6.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "CSExampleView.h"

@implementation CSExampleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blueColor]];
        
        _csView = [[CSView alloc] init];
        [self addSubview:_csView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    CGSize csSize = CGSizeMake(100.f, 100.f);
    [_csView setFrame:CGRectIntegral(CGRectMake(CGRectGetMidX(bounds) - (csSize.width / 2), CGRectGetMidY(bounds) - (csSize.height / 2), csSize.width, csSize.height))];
}

@end
