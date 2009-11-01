//
//  STIBViewGenerator.h
//  STIBViewKit
//
//  Created by Jason Gregori on 10/26/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 
 STIBViewGenerator
 -----------------
 
 STIBViewGenerator is for creating STIBViews out of nibs.
 
 You may not allocate a new instance. You may only get the shared instance. It
 is guaranteed to have no view (nil).
 
 */

@interface STIBViewGenerator : NSObject
{
  @private
    UIView      *_view;
}
@property (nonatomic, retain)   IBOutlet    UIView  *view;

+ (STIBViewGenerator *)sharedSTIBViewGenerator;

@end
