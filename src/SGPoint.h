//
//  SGPoint.h
//  SimpleGeo
//
//  Created by Seth Fitzsimmons on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


@interface SGPoint : NSObject
{
    NSDecimalNumber* latitude;
    NSDecimalNumber* longitude;
}

@property (retain) NSDecimalNumber* latitude;
@property (retain) NSDecimalNumber* longitude;

/**
 * Suitable for "creating" SGPoints from other SGPoints or from NSDictionaries (such as those
 * present in a GeoJSON document).
 */
+ (SGPoint *)pointForGeometry:(id)point;
+ (SGPoint *)pointWithLatitude:(id)latitude longitude:(id) longitude;
- (id)initWithLatitude:(NSDecimalNumber *)latitude longitude:(NSDecimalNumber *)longitude;

@end
