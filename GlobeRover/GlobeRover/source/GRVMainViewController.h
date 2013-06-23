//
//  GRVMainViewController.h
//  GlobeRover
//
//  Created by alex on 2013-06-23.
//  Copyright (c) 2013 Trollwerks Inc. All rights reserved.
//

#import "GRVFlipsideViewController.h"

@interface GRVMainViewController : UIViewController <GRVFlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
