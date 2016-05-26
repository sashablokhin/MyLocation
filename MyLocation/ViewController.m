//
//  ViewController.m
//  MyLocation
//
//  Created by Alexander Blokhin on 25.05.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView.showsUserLocation = true;
    _mapView.delegate = self;
    
    _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    
    // Необходима как можно большая точность независимо
    // от того, сколько это займет времени или потребует энергии
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    // Сообщить диспетчеру о немедленном начале поиска локации
    //[_locationManager startUpdatingLocation];
    [_locationManager requestWhenInUseAuthorization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    CLLocationCoordinate2D location = userLocation.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 250, 250);
    [mapView setRegion:region animated:true];
    
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
