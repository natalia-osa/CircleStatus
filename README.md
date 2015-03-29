[![Version](https://cocoapod-badges.herokuapp.com/v/CircleStatus/badge.png)](http://cocoadocs.org/docsets/CircleStatus) 
[![Platform](https://cocoapod-badges.herokuapp.com/p/CircleStatus/badge.png)](http://cocoadocs.org/docsets/CircleStatus) 
![License](https://img.shields.io/badge/license-Apache_2-green.svg?style=flat)

<p align="center" ><img src="https://raw.github.com/natalia-osa/CircleStatus/master/ReadmeImages/outlook1.png" alt="CircleStatus" title="CircleStatus" height="480"></p>


Small project to show circular chart with customisable number and range of colors on outer ring with background transparency/colors configuration. Demo project included. Works ok during orientation changes & redrawing. Supports also legend view.

## Examples:
Customisable colors, legend can be turned off or on (to see legend on look at big screenshots below)
<p align="center" ><img src="https://raw.github.com/natalia-osa/CircleStatus/master/ReadmeImages/demo1.png" alt="CircleStatus img1" title="Customizable colors" height="100"></p>
Customisable percentage of each color in ring. You can also change the point where you want to start drawing colors:
<p align="center" ><img src="https://raw.github.com/natalia-osa/CircleStatus/master/ReadmeImages/demo2.png" alt="CircleStatus img2" title="Customizable percentage of each color in ring. You can also change the point where you want to start drawing colors" height="100"></p>
You can attach image or text (or nothing) in the middle:
<p align="center" ><img src="https://raw.github.com/natalia-osa/CircleStatus/master/ReadmeImages/demo3.png" alt="CircleStatus img3" title="You can attach image or text (or nothing) in the middle" height="100"></p>
Border width can be changed:
<p align="center" ><img src="https://raw.github.com/natalia-osa/CircleStatus/master/ReadmeImages/demo4.png" alt="CircleStatus img4" title="Border width can be changed" height="100"></p>
Background can be clear or with any color. If total percentage is lower than 100%, rest of circle is transparent (like on the right):
<p align="center" ><img src="https://raw.github.com/natalia-osa/CircleStatus/master/ReadmeImages/demo5.png" alt="CircleStatus img5" title="Background can be clear or with any color. If total percentage is lower than 100%, rest of circle is empty" height="100"></p>

## Outlook:
You can do much more than this ^^
<p align="center" >
<img src="https://raw.github.com/natalia-osa/CircleStatus/master/ReadmeImages/outlook2.png" alt="CircleStatus" title="CircleStatus" height="480">
<img src="https://raw.github.com/natalia-osa/CircleStatus/master/ReadmeImages/outlook3.png" alt="CircleStatus" title="CircleStatus" height="480">
<img src="https://raw.github.com/natalia-osa/CircleStatus/master/ReadmeImages/outlook4.png" alt="CircleStatus" title="CircleStatus" height="480">
<img src="https://raw.github.com/natalia-osa/CircleStatus/master/ReadmeImages/outlook5.png" alt="CircleStatus" title="CircleStatus" height="480">
</p>

## Installation:
#### Installation with CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries.
```ruby
pod "CircleStatus"
```
#### Submodule
In your projects git folder type:
```bash
git submodule init
git submodule add --copy link to the repo--
git submodule update
```
Copy all files from CircleStatus/CircleStatus folder.
#### Just download & attach
This is strongly misadvised as you won't be able to see code updates. Clone or download the source, copy all files from CircleStatus/CircleStatus folder.

## Implementation:
Clone and see the demo for more examples about implementation. You can add the view via Storyboard or using code:
```objective-c
// in your view.h download the library
#import <CircleStatus/NOCSView.h>
// then add a property
@property (nonatomic, strong) NOCSView *csView;

// alloc & init the view or setup this via storyboard
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _csView = [[NOCSView alloc] initWithFrame:frame]; // + update the frame
        [self addSubview:_csView];
    }
    return self;
}

// in your controller you can change outlook of the control
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // fill with data
    [_csExampleView.csView setPercentageColorArray:@[[[NOCSPercentageColor alloc] initWithColor:[UIColor greenColor] percentage:0.7f],
                                                     [[NOCSPercentageColor alloc] initWithColor:[UIColor yellowColor] percentage:0.3f]]];
    // setup middle view: either text or image or nothing
    [_csExampleView.csView.textLabel setText:@"Chart"];
//    [_csExampleView.csView.imageView setImage:[UIImage imageNamed:@"test"]];
    // setup chart view
    [_csExampleView.csView setRadius:50.f];
    [_csExampleView.csView setFillColor:[UIColor colorWithWhite:1.f alpha:0.4f]];
    [_csExampleView.csView setStartAngle:15];
    [_csExampleView.csView setLineWidth:10];
    // setup legend
    [_csExampleView.csView setShowsLegend:NO];
    [_csExampleView.csView.legendView setLegendPosition:CSLegendPositionRight];
}
```

## ChangeLog
- 1.2.0 General code refactor. Added prefixes, using NOCategories.
- 1.1.3 Made javadoc more readable.
- 1.1.2 Fixed bug with redrawing. Updated javadoc.
- 1.1.1 Silenced pod lint warnings.
- 1.1 Applied styling, small code refactor.
- 1.0 Added basic classes. Added demo.

## Author

Natalia Osiecka, osiecka.n@gmail.com
- [Natalia Osiecka](https://github.com/natalia-osa/) ([@vivelee](https://twitter.com/vivelee))

## License

Available under the Apache 2.0 license. See the LICENSE file for more info.

## Requirements

Requires Xcode 5, targeting either iOS 5.1.1 or higher
