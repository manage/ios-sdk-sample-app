//
//  AppDelegate.h
//  Manage MoPub SDK Adapters
//
//  Created by Van Pham on 1/19/16.
//  Copyright © 2016 Manage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSString *publisherUserID;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

