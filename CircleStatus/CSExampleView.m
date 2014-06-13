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
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _csView = [[CSView alloc] init];
        [_csView setBackgroundColor:[UIColor darkGrayColor]];
        [self addSubview:_csView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    CGSize csSize = CGSizeMake(200.f, 100.f); // chart size
    csSize.height = [_csView.legendView heightForChartSize:csSize]; // chart size with legendView
    
    [_csView setFrame:CGRectIntegral(CGRectMake(CGRectGetMidX(bounds) - (csSize.width / 2), CGRectGetMidY(bounds) - (csSize.height / 2), csSize.width, csSize.height))];
}

@end
