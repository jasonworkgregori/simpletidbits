//
//  STMenuMapViewController.m
//  STMenuKit
//
//  Created by Jason Gregori on 12/14/09.
//  Copyright 2009 Slingshot Labs. All rights reserved.
//

#import "STMenuMapViewController.h"

@interface STMenuMapViewController ()

@end

@implementation STMenuMapViewController
@synthesize	mapType = _mapType, st_mapView = _mapView;


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
