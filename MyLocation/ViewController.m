//
//  ViewController.m
//  MyLocation
//
//  Created by Alexander Blokhin on 25.05.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    
    // Необходима как можно большая точность независимо
    // от того, сколько это займет времени или потребует энергии
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    // Сообщить диспетчеру о немедленном начале поиска локации
    [_locationManager startUpdatingLocation];
    [_locationManager requestWhenInUseAuthorization];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"%@", newLocation);
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    NSLog(@"Не удается определить текущее положение: %@", error);
    
}

@end
