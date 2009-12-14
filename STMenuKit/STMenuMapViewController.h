//
//  STMenuMapViewController.h
//  STMenuKit
//
//  Created by Jason Gregori on 12/14/09.
//  Copyright 2009 Slingshot Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STMenuBaseViewController.h"
#import <MapKit/MapKit.h>


@interface STMenuMapViewController : STMenuBaseViewController
<MKMapViewDelegate>
{
    MKMapView		*_mapView;
    NSString		*_mapType;
	BOOL			_showsUserLocation;
	BOOL			_tracksUser;
}
// Possible values: standard, satellite, and hybrid. Default: standard
@property (nonatomic, copy)		NSString		*mapType;
// BOOL defaults to YES
@property (nonatomic, retain)	NSNumber		*showsUserLocation;
// Tracks user (keeps user at center of map, even when moving), defaults to NO
@property (nonatomic, retain)	NSNumber		*tracksUser;

#pragma mark Subclass or Private

@property (nonatomic, retain)	MKMapView	*st_mapView;

@end


@protocol STMenuMap



@end
