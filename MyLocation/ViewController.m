//
//  ViewController.m
//  MyLocation
//
//  Created by Alexander Blokhin on 25.05.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

#import "ViewController.h"
#import "ABMapPoint.h"


@interface ViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mapTypeSegmentedControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationTextField.delegate = self;
    
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
    
    [_mapTypeSegmentedControl addTarget:self
                         action:@selector(mapTypeChanged:)
               forControlEvents:UIControlEventValueChanged];
}


- (void)mapTypeChanged:(UISegmentedControl *)control {
    [_mapView setMapType:control.selectedSegmentIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)findLocation {
    [_locationManager startUpdatingLocation];
    [_activityIndicator startAnimating];
    [_locationTextField setHidden:true];
}

- (void)foundLocation:(CLLocation *)location {
    CLLocationCoordinate2D coord = location.coordinate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    NSString *dateStr = [@" " stringByAppendingString:[dateFormatter stringFromDate:[NSDate date]]];
    NSString *title = [[_locationTextField text] stringByAppendingString:dateStr];
    
    ABMapPoint *mapPoint = [[ABMapPoint alloc] initWithCoordinate:coord andTitle: title];
    [_mapView addAnnotation:mapPoint];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [_mapView setRegion:region animated:true];
    
    [_locationTextField setText:@""];
    [_activityIndicator stopAnimating];
    [_locationTextField setHidden:false];
    [_locationManager stopUpdatingLocation];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self findLocation];
    [textField resignFirstResponder]; // отказ назначения первого респондера для textField => скрытие клавиатуры
    
    return true;
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
    
    // Сколько секунд прошло после создания новой локации?
    NSTimeInterval time = [[newLocation timestamp] timeIntervalSinceNow];
    
    if (time < -180) {
        return;
    }
    
    [self foundLocation:newLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    NSLog(@"Не удается определить текущее положение: %@", error);
    
}

@end
