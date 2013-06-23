//
//  GRVFlipsideViewController.m
//  GlobeRover
//
//  Created by alex on 2013-06-23.
//  Copyright (c) 2013 Trollwerks Inc. All rights reserved.
//

#import "GRVFlipsideViewController.h"

@interface GRVFlipsideViewController ()

@end

@implementation GRVFlipsideViewController

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
