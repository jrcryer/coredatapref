//
//  CoreDataPerfAppDelegate.h
//  CoreDataPerf
//
//  Created by James Cryer on 22/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PerformanceTuningViewController.h"

@interface CoreDataPerfAppDelegate : NSObject <UIApplicationDelegate> {
    PerformanceTuningViewController *viewController;
    UIWindow *window;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) PerformanceTuningViewController *viewController;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

- (void)loadData;
- (NSManagedObject *)insertObjectForName:(NSString *)entityName withName:(NSString *)name;

@end

