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
    
    [_csExampleView.csView setPercentageColorArray:@[[[CSPercentageColor alloc] initWithColor:[UIColor greenColor] percentage:0.1f],
                                                     [[CSPercentageColor alloc] initWithColor:[UIColor yellowColor] percentage:0.1f],
                                                     [[CSPercentageColor alloc] initWithColor:[UIColor purpleColor] percentage:0.1f],
                                                     [[CSPercentageColor alloc] initWithColor:[UIColor redColor] percentage:0.2f],
                                                     [[CSPercentageColor alloc] initWithColor:[UIColor purpleColor] percentage:0.05f],
                                                     [[CSPercentageColor alloc] initWithColor:[UIColor yellowColor] percentage:0.05f],
                                                     [[CSPercentageColor alloc] initWithColor:[UIColor greenColor] percentage:0.3f]]];
    [_csExampleView.csView.textLabel setText:@"Chart"];
//    [_csExampleView.csView.imageView setImage:[UIImage imageNamed:@"test"]];
    [_csExampleView.csView setFillColor:[UIColor colorWithWhite:1.f alpha:0.4f]];
    [_csExampleView.csView setStartAngle:15];
    [_csExampleView.csView setLineWidth:10];
}

@end
