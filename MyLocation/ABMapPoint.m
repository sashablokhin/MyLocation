//
//  ABMapPoint.m
//  MyLocation
//
//  Created by Alexander Blokhin on 26.05.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

#import "ABMapPoint.h"

@implementation ABMapPoint

@synthesize coordinate, title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)t {
    self = [super init];
    
    if (self) {
        coordinate = c;
        [self setTitle:t];
    }
    
    return self;
}

- (id)init {
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) andTitle:@"Hometown"];
}

@end
