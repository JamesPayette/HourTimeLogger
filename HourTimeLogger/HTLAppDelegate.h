//
//  HTLAppDelegate.h
//  HourTimeLogger
//
//  Created by Jack Payette on 8/26/14.
//  Copyright (c) 2014 James Payette. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
