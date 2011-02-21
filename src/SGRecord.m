//
//  SGRecord.m
//  SimpleGeo.framework
//
//  Copyright (c) 2011, SimpleGeo Inc.
//  All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the <organization> nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "SGRecord.h"


@implementation SGRecord

@synthesize created;
@synthesize layer;


+ (SGRecord *)recordWithDictionary:(NSDictionary *)data
{
	return [[[SGRecord alloc]initWithId:nil dictionary:data]autorelease];
}

+ (SGRecord *)recordWithCreatedTimestamp:(NSTimeInterval)created
{
	return [SGRecord recordWithCreatedTimestamp:created layer:nil];
}
+ (SGRecord *)recordWithLayer:(NSString *)layer
{
	return [SGRecord recordWithCreatedTimestamp:0 layer:layer];
}
+ (SGRecord *)recordWithCreatedTimestamp:(NSTimeInterval)created layer:(NSString *)layer
{
	return [[[SGRecord alloc]initWithCreatedTimestamp:created layer:layer]autorelease];
}

+ (SGRecord *)recordWithFeature:(SGFeature *)feature createdTimestamp:(NSTimeInterval)created
{
	return [SGRecord recordWithFeature:feature createdTimestamp:created layer:nil];
}
+ (SGRecord *)recordWithFeature:(SGFeature *)feature layer:(NSString *)layer
{
	return [SGRecord recordWithFeature:feature createdTimestamp:0 layer:layer];
}

+ (SGRecord *)recordWithFeature:(SGFeature *)feature createdTimestamp:(NSTimeInterval)created layer:(NSString *)layer
{
	return [[[SGRecord alloc]initWithFeature:feature createdTimestamp:created Layer:layer]autorelease];
}

- (id)init
{
    return [self initWithLayer:nil];
}
- (id)initWithCreatedTimestamp:(NSTimeInterval)timestampCreated
{
	return [self initWithCreatedTimestamp:timestampCreated layer:nil];
}
- (id)initWithLayer:(NSString *)theLayer
{
	return [self initWithCreatedTimestamp:0 layer:theLayer];
}
- (id)initWithCreatedTimestamp:(NSTimeInterval)timestampCreated layer:(NSString *)theLayer
{
	self = [super init];
	if (self) {
		created=timestampCreated;
        layer= [theLayer retain];
    }
    return self;
}
- (id)initWithFeature:(SGFeature *)feature createdTimestamp:(NSTimeInterval)timestampCreated
{
	return [self initWithFeature:feature createdTimestamp:timestampCreated Layer:nil];
}
- (id)initWithFeature:(SGFeature *)feature layer:(NSString *)theLayer
{
	return [self initWithFeature:feature createdTimestamp:0 Layer:theLayer];
}
- (id)initWithFeature:(SGFeature *)feature createdTimestamp:(NSTimeInterval)timestampCreated Layer:(NSString *)theLayer
{
	self = [super initWithId:feature.featureId geometry:feature.geometry properties:feature.properties];
    if (self) {
		created=timestampCreated;
        layer= [theLayer retain];
		
    }
    return self;
}



- (id)initWithId:(NSString *)id 
      dictionary:(NSDictionary *)data
{
    self = [super init];
	
    if (self) {
		//  featureId = [id retain];
		
        if (data) {
            if (! [[data objectForKey:@"type"] isEqual:@"Feature"]) {
                NSLog(@"Unsupported geometry type: %@", [data objectForKey:@"type"]);
                return nil;
            }
			
            for (NSString *key in data) {
                NSString *selectorString = [NSString stringWithFormat:@"set%@:", [key capitalizedString]];
                SEL selector = NSSelectorFromString(selectorString);
				
                // properties with well-known names are defined as @properties;
                // anything else is ignored
                // accessor methods shouldn't be used in an init... method (so say the docs), but
                // there's no other way to achieve this otherwise
                if ([self respondsToSelector:selector]) {
                    [self performSelector:selector
                               withObject:[[[data objectForKey:key] retain] autorelease]];
                }
            }
        }
    }
	
    return self;
}

- (void)dealloc
{
    [layer release];
    [super dealloc];
}
- (NSDictionary *)asDictionary
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
	
    if ([super featureId]) {
        [dict setObject:[super featureId] forKey:@"id"];
    }
	
    if ([super geometry]) {
        [dict setObject:[super geometry] forKey:@"geometry"];
    }
	
    if ([super properties]) {
        [dict setObject:[super properties] forKey:@"properties"];
    }
	if (created) {
		NSNumber *objCreated = [NSNumber numberWithDouble:created];
		[dict setObject:objCreated forKey:@"created"];
	}
	if (layer) {
		[dict setObject:layer forKey:@"layer"];
	}
    return [NSDictionary dictionaryWithDictionary:dict];
}


- (id)JSON
{
    return [self asDictionary];
}



@end
