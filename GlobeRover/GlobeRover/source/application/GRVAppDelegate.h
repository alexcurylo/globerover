//
//  GRVAppDelegate.h
//
//  Copyright (c) 2013 Trollwerks Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRVAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

#pragma mark - Conveniences

GRVAppDelegate *AppDelegate(void);
