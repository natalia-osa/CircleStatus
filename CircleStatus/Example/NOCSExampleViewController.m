//
//  NOCSExampleViewController.h
//  CircleStatus
//
//  Created by Natalia Osiecka on 10.6.2014.
//  Copyright (c) 2014 iOskApps. All rights reserved.
//

#import "NOCSExampleViewController.h"
#import "NOCSExampleView.h"
#import "NOCSView.h"
#import <NOCategories/UIViewController+NOCViewInitializer.h>

@interface NOCSExampleViewController ()

@property (nonatomic, weak) NOCSExampleView *csExampleView;

@end

@implementation NOCSExampleViewController

- (void)loadView {
    _csExampleView = [self noc_loadViewOfClass:[NOCSExampleView class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.csExampleView.csView setPercentageColorArray:@[[[NOCSPercentageColor alloc] initWithTitle:@"One" color:[UIColor blackColor] percentage:0.1f],
                                                         [[NOCSPercentageColor alloc] initWithTitle:@"Two" color:[UIColor yellowColor] percentage:0.1f],
                                                         [[NOCSPercentageColor alloc] initWithTitle:@"Three" color:[UIColor greenColor] percentage:0.1f],
                                                         [[NOCSPercentageColor alloc] initWithTitle:@"Four" color:[UIColor redColor] percentage:0.2f],
                                                         [[NOCSPercentageColor alloc] initWithTitle:@"Five" color:[UIColor purpleColor] percentage:0.05f],
                                                         [[NOCSPercentageColor alloc] initWithTitle:@"Six" color:[UIColor brownColor] percentage:0.05f],
                                                         [[NOCSPercentageColor alloc] initWithTitle:@"Seven with a very long description to see how the linebreak mode works - blah blah blah ^^" color:[UIColor whiteColor] percentage:0.3f]]];
    [self.csExampleView.csView.textLabel setText:@"Chart"];
    [self.csExampleView.csView setFillColor:[UIColor clearColor]];
    [self.csExampleView.csView setStartAngle:15];
    [self.csExampleView.csView setLineWidth:10];
    [self.csExampleView.csView setRadius:50.f];
    [self.csExampleView.csView.legendView setLegendPosition:CSLegendPositionRight];
    
    // You can also eg.
//    [self.csExampleView.csView setShowsLegend:NO];
//    [self.csExampleView.csView.imageView setImage:[UIImage imageNamed:@"test"]];
//    [self.csExampleView.csView setFillColor:[UIColor colorWithWhite:1.f alpha:0.4f]];
//    [self.csExampleView.csView.legendView setBackgroundColor:[UIColor redColor]];
//    [self.csExampleView.csView.legendView.layer setCornerRadius:2.f];
//    [self.csExampleView.csView.legendView.layer setBorderColor:[UIColor blackColor].CGColor];
//    [self.csExampleView.csView.legendView.layer setBorderWidth:1.f];
    
    [self.view setNeedsLayout];
}

@end
