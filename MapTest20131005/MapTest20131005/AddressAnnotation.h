//
//  AddressAnnotation.h
//  LocateOffline-test1
//
//  Created by 本岡 忠久 on 24/03/13.
//  Copyright (c) 2013 本岡 忠久. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c ;


@end
