//
//  main.m
//
//  Copyright (c) 2013 Trollwerks Inc. All rights reserved.
//

#import "GRVAppDelegate.h"
#import "TWXAnalytics.h"

static void uncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"EPIC FAIL: uncaughtExceptionHandler triggered with %@!", exception);
    
    [TWXAnalytics logException:@"uncaughtExceptionHandler" message:@"Crash!" exception:exception];
}

/*
@interface GRVApplication : UIApplication
@end

@implementation GRVApplication : UIApplication

- (void)setStatusBarHidden:(BOOL)hidden withAnimation:(UIStatusBarAnimation)animation
{
    // Admob 6.3 likes to spuriously show the status bar.
    // Let's just force it to never be shown in our app.
    
    if (!hidden)
        hidden = YES;
    [super setStatusBarHidden:hidden withAnimation:animation];
}

@end
*/

int main(int argc, char *argv[])
{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    //setenv("CLASSIC", "0", 1);
    
    //twmempoll(2);

    @autoreleasepool
    {
        return UIApplicationMain(argc, argv,
            nil, // NSStringFromClass(GRVApplication.class),
            NSStringFromClass(GRVAppDelegate.class));
    }
}
