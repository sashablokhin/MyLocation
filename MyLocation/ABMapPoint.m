//
//  ABMapPoint.m
//  MyLocation
//
//  Created by Alexander Blokhin on 26.05.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

#import "ABMapPoint.h"

@implementation ABMapPoint

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title {
    self = [super init];
    
    if (self) {
        self.coordinate = coordinate;
        self.title = title;
    }
    
    return self;
}

- (id)init {
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) andTitle:@"Hometown"];
}

@end
