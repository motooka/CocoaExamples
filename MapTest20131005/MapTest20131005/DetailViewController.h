//
//  DetailViewController.h
//  MapTest20131005
//
//  Created by 本岡 忠久 on 5/10/13.
//  Copyright (c) 2013 本岡 忠久. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "AddressAnnotation.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) CLLocation* location;
@property (strong, nonatomic) CLLocation* secondaryLocation;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
