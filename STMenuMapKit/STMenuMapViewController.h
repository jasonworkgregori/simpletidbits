//
//  STMenuMapViewController.h
//  STMenuKit
//
//  Created by Jason Gregori on 12/14/09.
//  Copyright 2009 Slingshot Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <STMenuKit/STMenuKit.h>
#import <MapKit/MapKit.h>


// TODO: remember region
// TODO: we are loading the view on every property
// TODO: try KVO on userLocation's properties to track user


//#pragma mark Notifications
//extern NSString *const STMenuMapDidStartLoadingUserLocationNotification;
//extern NSString *const STMenuMapDidStartTrackingUserNotification;
//extern NSString *const STMenuMapDidStopTrackingUserNotification;


@interface STMenuMapViewController : STMenuBaseViewController
<MKMapViewDelegate>
{
    MKMapView		*_mapView;
    NSString		*_mapType;
	BOOL			_showsUserLocation;
	BOOL			_tracksUser;
    
    BOOL			_shouldLocateUserWhenLoaded;
}
// Possible values: standard, satellite, and hybrid. Default: standard
@property (nonatomic, copy)		NSString		*mapType;
// BOOL defaults to YES
@property (nonatomic, retain)	NSNumber		*showsUserLocation;
// TODO: Tracks user (keeps user at center of map, even when moving)
// Defaults to NO
@property (nonatomic, retain)	NSNumber		*tracksUser;

// Centers Map on User, only if showsUserLocation is YES
- (void)locateUser;

#pragma mark Subclass or Private

@property (nonatomic, retain)	MKMapView		*st_mapView;

@end


@protocol STMenuMap

// when region changes


@end
