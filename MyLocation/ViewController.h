//
//  ViewController.h
//  MyLocation
//
//  Created by Alexander Blokhin on 25.05.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

