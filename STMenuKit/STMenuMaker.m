//
//  STMenuMaker.m
//  STMenuKit
//
//  Created by Jason Gregori on 11/15/09.
//  Copyright 2009 Jason Gregori. All rights reserved.
//

#import "STMenuMaker.h"


@implementation STMenuMaker

+ (id)makeInstanceFromData:(id)data
{
    return [self makeInstanceFromData:data
                             useCache:nil];
}
// Will check cache for an instance of the class, returning the instance if
// found, and adding the new instance into the cache if not. Uses class name
// as key.
+ (id)makeInstanceFromData:(id)data useCache:(NSMutableDictionary *)cache
{
    return [self makeInstanceFromData:data
                             useCache:cache
                          propertyKey:nil];
}
// Will call valueForKey:@"key" on instance and if value is equal to 
// property key, will not update properties. Will also set instance key. This is
// useful so that we don't set the properties of the same instance multiple
// times. If key is nil, will not check or set instance key and will set all
// properties.
+ (id)makeInstanceFromData:(id)data
                  useCache:(NSMutableDictionary *)cache
               propertyKey:(NSString *)key
{
    return [self makeInstanceFromData:data
                             useCache:cache
                          propertyKey:key
                       useClassPrefix:nil
                               suffix:nil
                         defaultClass:NULL];
}

+ (id)makeInstanceFromData:(id)data
                  useCache:(NSMutableDictionary *)cache
               propertyKey:(NSString *)key
            useClassPrefix:(NSString *)prefix
                    suffix:(NSString *)suffix
              defaultClass:(Class)defaultClass
{
    NSString    *className  = [self classNameForData:data];
    
    // see if it's in the cache
    id          instance    = [cache valueForKey:className];

    if (!instance)
    {
        // try class with prefix and suffix
        Class   class   = [self classFromClassName:className
                                        withPrefix:prefix
                                            suffix:suffix];
        if (class == NULL)
        {
            // try plain class name
            class   = [self classFromClassName:className];
        }
        if (class == NULL)
        {
            class   = defaultClass;
        }
        if (class == NULL)
        {
            // no class, exception
            [NSException raise:@"STMenuMaker classFromClassName"
                        format:@"Could not find class for class name:\n%@",
             className];            
        }
        instance    = [[[class alloc] init] autorelease];
        [cache setValue:instance forKey:className];
    }
    
    if (!key || ![key isEqual:[instance valueForKey:@"key"]])
    {
        [self setInstance:instance properties:data];
        
        if (key)
        {
            [instance setValue:key forKey:@"key"];
        }
    }
    
    return instance;
}

// Gets the class name out of the data
+ (NSString *)classNameForData:(id)data
{
    if ([data isKindOfClass:[NSString class]])
    {
        return data;
    }
    else if ([data isKindOfClass:[NSDictionary class]]
             && [data valueForKey:@"class"]
             && [[data valueForKey:@"class"] isKindOfClass:[NSString class]])
    {
        return [data valueForKey:@"class"];
    }
    
    return nil;
}

// Creates an instance from class name. Returns NULL if it can't find one.
+ (Class)classFromClassName:(NSString *)className
{
    return NSClassFromString(className);
}

// Creates an instance from class name with prefix and suffix.
+ (Class)classFromClassName:(NSString *)className
                 withPrefix:(NSString *)prefix
                     suffix:(NSString *)suffix
{
    if (!className)
    {
        return NULL;
    }
    
    NSString    *fullClassName  = nil;
    
    // get a full class name by adding suffix/prefix
    if (prefix && suffix)
    {
        fullClassName   = [NSString stringWithFormat:@"%@%@%@",
                           prefix,
                           className,
                           suffix];
    }
    else if (prefix)
    {
        fullClassName   = [NSString stringWithFormat:@"%@%@",
                           prefix,
                           className];
    }
    else if (suffix)
    {
        fullClassName   = [NSString stringWithFormat:@"%@%@",
                           className,
                           suffix];
    }
    
    if (fullClassName)
    {
        return NSClassFromString(fullClassName);
    }
    
    return NULL;
}

// Sets the properties of instance with the properties of data.
// Returns instance.
+ (id)setInstance:(id)instance properties:(id)data
{
    [instance st_prepareForReuse];
    
    if ([data isKindOfClass:[NSDictionary class]])
    {
        data    = [[data mutableCopy] autorelease];
        [data setValue:nil forKey:@"class"];
        [instance setValuesForKeysWithDictionary:data];
    }
    
    return instance;
}

@end
