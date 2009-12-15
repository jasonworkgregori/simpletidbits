//
//  STMenuMapViewController.m
//  STMenuKit
//
//  Created by Jason Gregori on 12/14/09.
//  Copyright 2009 Slingshot Labs. All rights reserved.
//

#import "STMenuMapViewController.h"

//#pragma mark Notifications
//NSString *const STMenuMapDidStartLoadingUserLocationNotification
//  = @"STMenuMapDidStartLoadingUserLocationNotification";
//NSString *const STMenuMapDidStartTrackingUserNotification
//  = @"STMenuMapDidStartTrackingUserNotification";
//NSString *const STMenuMapDidStopTrackingUserNotification
//  = @"STMenuMapDidStopTrackingUserNotification";

@interface STMenuMapViewController ()

@property (nonatomic, assign)	BOOL		st_shouldLocateUserWhenLoaded;

@end

@implementation STMenuMapViewController
@synthesize	mapType = _mapType, st_mapView = _mapView,
			st_shouldLocateUserWhenLoaded = _shouldLocateUserWhenLoaded;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.showsUserLocation	= [NSNumber numberWithBool:YES];
    }
    return self;
}


- (void)dealloc
{
    [_mapView release];
    [_mapType release];
    
    [super dealloc];
}

- (void)setMapType:(NSString *)mapType
{
    if (_mapType != mapType)
    {
        [_mapType release];
        _mapType	= [mapType copy];
    }
    
    if ([self.mapType isEqualToString:@"hybrid"])
    {
        self.st_mapView.mapType	= MKMapTypeHybrid;
    }
    else if ([self.mapType isEqualToString:@"satellite"])
    {
        self.st_mapView.mapType	= MKMapTypeSatellite;
    }
    else
    {
        self.st_mapView.mapType	= MKMapTypeStandard;
    }
}

- (void)setShowsUserLocation:(NSNumber *)shows
{
	_showsUserLocation	= [shows boolValue];
	self.st_mapView.showsUserLocation	= _showsUserLocation;
}

- (NSNumber *)showsUserLocation
{
	return [NSNumber numberWithBool:_showsUserLocation];
}

- (void)setTracksUser:(NSNumber *)tracks
{
    if (_tracksUser != [tracks boolValue])
    {
        _tracksUser	= !_tracksUser;
        // TODO: tracksUser: all of the hard parts
    }
}

- (NSNumber *)tracksUser
{
    return [NSNumber numberWithBool:_tracksUser];
}

// Centers Map on User, only if showsUserLocation is YES
- (void)locateUser
{
    if (![self.showsUserLocation boolValue])
    {
        // dont allow if they aren't showing the user location
        return;
    }
    
    if ([self isViewLoaded])
    {
        MKUserLocation	*userLocation	= self.st_mapView.userLocation;
        
        // check if we have the location
        if (!userLocation.location)
        {
            // there is no location, check if it is being loaded
            if (userLocation.updating)
            {
                // poll!!!!
                [self performSelector:@selector(locateUser)
                           withObject:nil
                           afterDelay:0.25];
                return;
            }
        }
            
        if (self.st_mapView.region.span.latitudeDelta > 1)
        {
            // zoom in because they are so far out
            MKCoordinateRegion	region;
            region.center	= userLocation.location.coordinate;
            // we don't want to zoom in more than the accuracy
            region.span.latitudeDelta
              = userLocation.location.horizontalAccuracy /1000 /111;
            if (region.span.latitudeDelta < 0.015)
            {
                // we don't want to zoom in more than a mile
                region.span.latitudeDelta	= 0.015;
            }
            // make sure region fits map
			region		= [self.st_mapView regionThatFits:region];
            [self.st_mapView setRegion:region
                              animated:YES];
        }
        else
        {
            // they are already zoomed in, so dont change zoom
            // just center on their location
            [self.st_mapView
             setCenterCoordinate:userLocation.location.coordinate
             animated:YES];
        }

        self.st_shouldLocateUserWhenLoaded	= NO;
    }
    else
    {
        self.st_shouldLocateUserWhenLoaded	= YES;
    }
}

#pragma mark UIViewController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    MKMapView		*mapView		= [[MKMapView alloc]
                                       initWithFrame:self.view.bounds];
	mapView.delegate				= self;
    mapView.autoresizingMask		= (UIViewAutoresizingFlexibleWidth
                                       | UIViewAutoresizingFlexibleHeight);
    self.st_mapView	= mapView;
    [mapView release];
    
    [self.view addSubview:self.st_mapView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// need to set these things on the map view
    self.mapType	= self.mapType;
	self.showsUserLocation	= self.showsUserLocation;
	self.tracksUser	= self.tracksUser;
    
    if (self.st_shouldLocateUserWhenLoaded)
    {
        [self locateUser];
    }
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.st_mapView		= nil;
}





@end
