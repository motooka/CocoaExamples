//
//  AddressAnnotation.m
//  LocateOffline-test1
//
//  Created by 本岡 忠久 on 24/03/13.
//  Copyright (c) 2013 本岡 忠久. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation

@synthesize coordinate;

- (NSString *)subtitle{
	return nil;
}

- (NSString *)title{
	return nil;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c {
	coordinate=c;
	return self;
}

@end
