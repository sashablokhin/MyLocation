//
//  ABMapPoint.h
//  MyLocation
//
//  Created by Alexander Blokhin on 26.05.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ABMapPoint : NSObject <MKAnnotation>

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

@end
