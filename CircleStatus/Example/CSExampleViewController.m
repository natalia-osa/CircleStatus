//
//  CSExampleViewController.h
//  CircleStatus
//
//  Created by Natalia Osiecka on 10.6.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "CSExampleViewController.h"
#import "CSExampleView.h"
#import "CSView.h"

@interface CSExampleViewController ()

@property (nonatomic, weak) CSExampleView *csExampleView;

@end

@implementation CSExampleViewController

- (void)loadView {
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    
    CSExampleView *view = [[CSExampleView alloc] initWithFrame:rect];
    
    //local
    _csExampleView = view;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_csExampleView.csView setPercentageColorArray:@[[[CSPercentageColor alloc] initWithTitle:@"One" color:[UIColor blackColor] percentage:0.1f],
                                                     [[CSPercentageColor alloc] initWithTitle:@"Two" color:[UIColor yellowColor] percentage:0.1f],
                                                     [[CSPercentageColor alloc] initWithTitle:@"Three" color:[UIColor greenColor] percentage:0.1f],
                                                     [[CSPercentageColor alloc] initWithTitle:@"Four" color:[UIColor redColor] percentage:0.2f],
                                                     [[CSPercentageColor alloc] initWithTitle:@"Five" color:[UIColor purpleColor] percentage:0.05f],
                                                     [[CSPercentageColor alloc] initWithTitle:@"Six" color:[UIColor brownColor] percentage:0.05f],
                                                     [[CSPercentageColor alloc] initWithTitle:@"Seven with a very long description to see how the linebreak mode works - blah blah blah ^^" color:[UIColor whiteColor] percentage:0.3f]]];
//    [_csExampleView.csView setPercentageColorArray:@[[[CSPercentageColor alloc] initWithTitle:@"Total darkness" color:[UIColor blackColor] percentage:0.4f],
//                                                     [[CSPercentageColor alloc] initWithTitle:@"White winning" color:[UIColor whiteColor] percentage:0.6f]]];
    [_csExampleView.csView.textLabel setText:@"Chart"];
//    [_csExampleView.csView.imageView setImage:[UIImage imageNamed:@"test"]];
//    [_csExampleView.csView setFillColor:[UIColor colorWithWhite:1.f alpha:0.4f]];
    [_csExampleView.csView setFillColor:[UIColor clearColor]];
//    [_csExampleView.csView setShowsLegend:NO];
    [_csExampleView.csView setStartAngle:15];
    [_csExampleView.csView setLineWidth:10];
    [_csExampleView.csView setRadius:50.f];
    [_csExampleView.csView.legendView setLegendPosition:CSLegendPositionRight];
//    [_csExampleView.csView.legendView setBackgroundColor:[UIColor redColor]];
//    [_csExampleView.csView.legendView.layer setCornerRadius:2.f];
//    [_csExampleView.csView.legendView.layer setBorderColor:[UIColor blackColor].CGColor];
//    [_csExampleView.csView.legendView.layer setBorderWidth:1.f];
    [self.view setNeedsLayout];
}

@end
