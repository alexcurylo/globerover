//
//  GRVMainViewController.m
//  GlobeRover
//
//  Created by alex on 2013-06-23.
//  Copyright (c) 2013 Trollwerks Inc. All rights reserved.
//

#import "GRVMainViewController.h"
#import "TWXNSString.h"
#import <MapKit/MapKit.h>

@interface GRVMainViewController () < MKMapViewDelegate, UIWebViewDelegate >

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation GRVMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initializeBackground];
    
    [self initializeWebView];
}

- (void)initializeBackground
{
    UIImageView *backgroundView = self.backgroundView;
    // frame is correct for device but in portrait orientation here
    // twlog("FYI: initalizeBackground: %@", NSStringFromCGRect(backgroundView.frame));
    
    NSString *backgroundFile = nil;
    BOOL rotate = YES;
    BOOL spin = NO;
	if (TWXRUNNING_IPAD)
    {
        if (TWXRUNNING_RETINA)
            backgroundFile = @"Default-Landscape@2x";
        else
            backgroundFile = @"Default-Landscape";
        rotate = NO;
    }
    else if (TWXRUNNING_GIRAFFE)
        backgroundFile = @"Default-568h@2x";
    else if (TWXRUNNING_RETINA)
        backgroundFile = @"Default@2x";
    else
        backgroundFile = @"Default";
    NSString *backgroundPath = [NSBundle.mainBundle pathForResource:backgroundFile ofType:@"png"];
    UIImage *backgroundImage = [UIImage imageWithContentsOfFile:backgroundPath];
    backgroundView.image = backgroundImage;
    if (rotate)
    {
        if (spin)
        {
            // if there's some way to detect left or right startup,
            // we should spin transform from matching it to the proper one here.
        }
        backgroundView.transform = CGAffineTransformMakeRotation((float)-M_PI_2);
    }
}

/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    twlog("FYI: viewWillAppear: %@", NSStringFromCGRect(self.backgroundView.frame));
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    twlog("FYI: willRotateToInterfaceOrientation: %@", NSStringFromCGRect(self.backgroundView.frame));
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    twlog("FYI: didRotateFromInterfaceOrientation: %@", NSStringFromCGRect(self.backgroundView.frame));
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // frame is rotated to landscape here ... but only on iOS 6??

    twlog("FYI: viewDidAppear: %@", NSStringFromCGRect(self.backgroundView.frame));
}
 */

- (void)initializeWebView
{
	NSString *htmlPath = [NSBundle.mainBundle.resourcePath stringByAppendingPathComponent:@"streetview.html"];
    NSMutableString *html = [NSMutableString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    
    //      position:new google.maps.LatLng(-33.947116,151.255903),

    CGSize size = UIScreen.mainScreen.bounds.size;
    NSString *width = [NSString stringWithFormat:@"%ld", lrintf(size.height)];
    [html replace:@"[PANOWIDTH]" with:width];
    NSString *height = [NSString stringWithFormat:@"%ld", lrintf(size.width)];
    [html replace:@"[PANOHEIGHT]" with:height];

    [self.webView loadHTMLString:html baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    self.backgroundView = nil;
    self.webView = nil;
    self.mapView = nil;

    [super viewDidUnload];
}

/* https://developers.google.com/maps/documentation/javascript/streetview
 
 The StreetViewPanorama constructor also allows you to set the Street View location and point of view using the StreetViewOptions parameter. You may call setPosition() and setPov() on the object after construction to change its location and POV.
 
 The Street View location defines the placement of the camera focus for an image, but it does not define the orientation of the camera for that image. For that purpose, the StreetViewPov object defines two properties:
 
 heading (default 0) defines the rotation angle around the camera locus in degrees relative from true north. Headings are measured clockwise (90 degrees is true east).
 pitch (default 0) defines the angle variance "up" or "down" from the camera's initial default pitch, which is often (but not always) flat horizontal. (For example, an image taken on a hill will likely exhibit a default pitch that is not horizontal.) Pitch angles are measured with positive values looking up (to +90 degrees straight up and orthogonal to the default pitch) and negative values looking down (to -90 degrees straight down and orthogonal to the default pitch).
 The StreetViewPov object is most often used to determine the point of view of the Streetview camera. You can also determine the point-of-view of the photographer — typically the direction the car or trike was facing — with the StreetViewPanorama.getPhotographerPov() method.
 */

#pragma mark - UIWebViewDelegate

/*
 
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

*/

#pragma mark - MKMapViewDelegate

/*
 - (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated;
 - (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated;
 
 - (void)mapViewWillStartLoadingMap:(MKMapView *)mapView;
 - (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView;
 - (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error;
 
 // mapView:viewForAnnotation: provides the view for each annotation.
 // This method may be called for all or some of the added annotations.
 // For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
 - (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;
 
 // mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
 // The delegate can implement this method to animate the adding of the annotations views.
 // Use the current positions of the annotation views as the destinations of the animation.
 - (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views;
 
 // mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
 - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
 
 - (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(NA, 4_0);
 - (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(NA, 4_0);
 
 - (void)mapViewWillStartLocatingUser:(MKMapView *)mapView NS_AVAILABLE(NA, 4_0);
 - (void)mapViewDidStopLocatingUser:(MKMapView *)mapView NS_AVAILABLE(NA, 4_0);
 - (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation NS_AVAILABLE(NA, 4_0);
 - (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error NS_AVAILABLE(NA, 4_0);
 
 - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
 fromOldState:(MKAnnotationViewDragState)oldState NS_AVAILABLE(NA, 4_0);
 
 - (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay NS_AVAILABLE(NA, 4_0);
 
 // Called after the provided overlay views have been added and positioned in the map.
 - (void)mapView:(MKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews NS_AVAILABLE(NA, 4_0);
 
 - (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated NS_AVAILABLE(NA, 5_0);
 */

@end
