//
//  DetailViewController.m
//  MapTest20131005
//
//  Created by 本岡 忠久 on 5/10/13.
//  Copyright (c) 2013 本岡 忠久. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item


- (void)configureView
{
	if(self.secondaryLocation != nil) {
		// annotation（ピン）のarray
		AddressAnnotation* annotation1 = [[AddressAnnotation alloc] initWithCoordinate:self.location.coordinate];
		AddressAnnotation* annotation2 = [[AddressAnnotation alloc] initWithCoordinate:self.secondaryLocation.coordinate];
		NSArray* annotations = [NSArray arrayWithObjects:annotation1, annotation2, nil];
		
		// 表示するように指定
		[self.mapView showAnnotations:annotations animated:NO];
	}
	else {
		// annotation（ピン）を設置
		AddressAnnotation* annotation = [[AddressAnnotation alloc] initWithCoordinate:self.location.coordinate];
		[self.mapView addAnnotation:annotation];
		
		// 座標とズームを指定
		MKCoordinateRegion theRegion = self.mapView.region;
		theRegion.center.latitude = self.location.coordinate.latitude;
		theRegion.center.longitude = self.location.coordinate.longitude;
		theRegion.span.longitudeDelta /= 512.0;
		theRegion.span.latitudeDelta /= 512.0;
		[self.mapView setRegion:theRegion animated:NO];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
