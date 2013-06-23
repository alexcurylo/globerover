//
//  GRVFlipsideViewController.h
//  GlobeRover
//
//  Created by alex on 2013-06-23.
//  Copyright (c) 2013 Trollwerks Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRVFlipsideViewController;

@protocol GRVFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(GRVFlipsideViewController *)controller;
@end

@interface GRVFlipsideViewController : UIViewController

@property (weak, nonatomic) id <GRVFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
