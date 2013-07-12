//
//  TWXAnalytics.h
//
//  Copyright (c) 2013 Trollwerks Inc. All rights reserved.
//

/// Singleton for analytics backend abstraction (currently Flurry)

@interface TWXAnalytics : NSObject

+ (TWXAnalytics *)sharedInstance;

+ (void)logEvent:(NSString *)eventName;
+ (void)logEvent:(NSString *)eventName withParameters:(NSMutableDictionary *)parameters;
+ (void)logEvent:(NSString *)eventName timed:(BOOL)timed;
+ (void)endTimedEvent:(NSString *)eventName;

+ (void)logException:(NSString *)errorID message:(NSString *)message exception:(NSException *)exception;
+ (void)logError:(NSString *)errorID message:(NSString *)message error:(NSError *)error;

- (void)startSession;

@end
