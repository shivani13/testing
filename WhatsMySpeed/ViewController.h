//
//  ViewController.h
//  WhatsMySpeed
//
//  Created by Ron Lisle on 2/28/12.
//  Copyright (c) 2012 lynda.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "Location.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) Location *location;

@end
