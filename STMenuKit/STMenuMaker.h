//
//  STMenuMaker.h
//  STMenuKit
//
//  Created by Jason Gregori on 11/15/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 STMenuMaker
 ===========
 
 The goal of STMenuMaker is to create instances of classes from some data.
 
 STMenuMaker Item Format
 -----------------------
 
    (string) class name
 
    OR
 
    { // Dictionary
        "class" => class name
        property key    => property value
        // as many properties as you want 
    }
 
 *  The instance will be created using the class name and everything besides the
    "class" key will be used as keys/values to set on the instance.
 *  There may be a default suffix and prefix for your class so you dont always
    have to type the whole thing.
 *  There may be a default class, in which case you don't even have to provide
    one.
 
 Classes the menu maker is creating must conform to KVC if data is a dictionary
 with properties in it.
 
 STMenuMaker only has static methods. You do not create instances of it.
 
 */

@interface STMenuMaker : NSObject

+ (id)makeInstanceFromData:(id)data;
// Will check cache for an instance of the class, returning the instance if
// found, and adding the new instance into the cache if not. Uses class name
// as key.
+ (id)makeInstanceFromData:(id)data useCache:(NSMutableDictionary *)cache;
// Will call valueForKey:@"key" on instance and if value is equal to 
// property key, will not update properties. Will also set instance key. This is
// useful so that we don't set the properties of the same instance multiple
// times. If key is nil, will not check or set instance key and will set all
// properties.
+ (id)makeInstanceFromData:(id)data
                  useCache:(NSMutableDictionary *)cache
               propertyKey:(NSString *)key;

+ (id)makeInstanceFromData:(id)data
                  useCache:(NSMutableDictionary *)cache
               propertyKey:(NSString *)key
            useClassPrefix:(NSString *)prefix
                    suffix:(NSString *)suffix;

// Gets the class name out of the data
+ (NSString *)classNameForData:(id)data;
// Creates an instance from class name. Returns NULL if it can't find one.
+ (Class)classFromClassName:(NSString *)className;
// Creates an instance from class name with prefix and suffix.
+ (Class)classFromClassName:(NSString *)className
                 withPrefix:(NSString *)prefix
                     suffix:(NSString *)suffix;
// Sets the properties of instance with the properties of data.
// Returns instance.
+ (id)setInstance:(id)instance properties:(id)data;

@end

@interface NSObject (STMenuMakerAdditions)
// STMenuMaker calls this method on instances before setting properties.
// Use this to clear out any properties that might have been set earlier.
- (void)st_prepareForReuse;
@end

