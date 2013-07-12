//
//  TWXAnalytics.m
//
//  Copyright (c) 2013 Trollwerks Inc. All rights reserved.
//

#define USE_FLURRY 0
#define USE_TAPSTREAM 0
#define USE_TESTFLIGHT 0

#import "TWXAnalytics.h"
#if USE_FLURRY
#import "Flurry.h"
#endif //USE_FLURRY
#if USE_TAPSTREAM
// version 2.3
#import "TSTapstream.h"
#endif //USE_TAPSTREAM
#if USE_TESTFLIGHT
#import "TestFlight.h"
#endif //USE_TESTFLIGHT
#import <AdSupport/AdSupport.h>

@interface TWXAnalytics()

@property (nonatomic, strong) NSDictionary *eventParameters;

@end

@implementation TWXAnalytics

+ (TWXAnalytics *)sharedInstance
{
   static TWXAnalytics *sharedInstance = nil;
   static dispatch_once_t once;
   dispatch_once(&once, ^{ sharedInstance = TWXAnalytics.new; });
   return sharedInstance;
}

+ (void)logEvent:(NSString *)eventName
{
   if (!eventName.length)
      return;
#if USE_FLURRY
   [Flurry logEvent:eventName withParameters:TWXAnalytics.sharedInstance.eventParameters];
#endif //USE_FLURRY
}

+ (void)logEvent:(NSString *)eventName withParameters:(NSMutableDictionary *)parameters
{
   if (!eventName.length)
      return;
    if (!parameters)
        parameters = NSMutableDictionary.new;
   [parameters addEntriesFromDictionary:TWXAnalytics.sharedInstance.eventParameters];
#if USE_FLURRY
   [Flurry logEvent:eventName withParameters:parameters];
#endif //USE_FLURRY
}

+ (void)logEvent:(NSString *)eventName timed:(BOOL) __unused timed
{
   if (!eventName.length)
      return;
#if USE_FLURRY
   [Flurry logEvent:eventName withParameters:TWXAnalytics.sharedInstance.eventParameters timed:timed];
#endif //USE_FLURRY
}

+ (void)endTimedEvent:(NSString *)eventName
{
    if (!eventName.length)
        return;
#if USE_FLURRY
    [Flurry endTimedEvent:eventName withParameters:nil];
#endif //USE_FLURRY
}

+ (void)logException:(NSString *) __unused errorID message:(NSString *) __unused message exception:(NSException *) __unused  __unused exception
{
#if USE_FLURRY
   [Flurry logError:errorID message:message exception:exception];
#endif //USE_FLURRY
}

+ (void)logError:(NSString *) __unused errorID message:(NSString *) __unused message error:(NSError *) __unused error
{
#if USE_FLURRY
   [Flurry logError:errorID message:message error:error];
#endif //USE_FLURRY
}

- (id)init
{
	self = super.init;
	if (self)
   {
      NSString *langID = (NSLocale.preferredLanguages)[0];
      self.eventParameters = @{
         @"Device": UIDevice.currentDevice.model,
         @"OS": UIDevice.currentDevice.systemVersion,
         @"Language": langID};
   }
	return self;
}

- (void)startSession
{
    /*
   NSString *testFlightApplicationToken = nil;
   NSString *flurryApplicationKey = nil;

#if POSESPRO
   testFlightApplicationToken = @"b5279e0d-fdc8-4d3a-9915-a8eb5644ee40";
   flurryApplicationKey = @"H9PNAMTQG6YGDRBCM5ZH";
#elif POSESSAMPLER
   testFlightApplicationToken = @"b74b7aa8-8d34-4249-a4d9-49d781090c6a";
   flurryApplicationKey = @"S22CH58IG7J2H2NF31FG";
#else
#error No application defined!
#endif //POSESPRO
*/
    
#if USE_FLURRY
      //#if DEBUG
      //#warning Flurry console logging is *very* verbosely annoying
      //[Flurry setDebugLogEnabled:YES];
      //[Flurry setShowErrorInLogEnabled:YES];
      //#endif //DEBUG
      [Flurry setSessionReportsOnCloseEnabled:YES];
      [Flurry setSessionReportsOnPauseEnabled:YES];

      [Flurry startSession:flurryApplicationKey];
      twlog("FYI: Flurry version %@ key %@; TestFlight token %@", Flurry.getFlurryAgentVersion, flurryApplicationKey, testFlightApplicationToken);
#endif //USE_FLURRY

#if USE_TESTFLIGHT
    //#if DEBUG
    //[TestFlight setDeviceIdentifier:UIDevice.currentDevice.uniqueIdentifier];
    //#endif //DEBUG
    [TestFlight takeOff:testFlightApplicationToken];
#endif //USE_TESTFLIGHT

#if USE_TAPSTREAM
    TSConfig *config = [TSConfig configWithDefaults];
    config.collectWifiMac = NO; // deprecated in iOS 7
    //config.odin1 = @"<ODIN-1 value goes here>";
    //config.udid = [[UIDevice currentDevice] uniqueIdentifier]; // illegal in store
    config.idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //config.openUdid = @"<OpenUDID value goes here>";
    //config.secureUdid = @"<SecureUDID value goes here>";
    [TSTapstream createWithAccountName:@"trollwerks" developerSecret:@"l9PDGbzOSCmBZWakiI9vKQ" config:config];
#endif //USE_TAPSTREAM
}

@end
