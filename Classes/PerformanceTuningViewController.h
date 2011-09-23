//
//  PerformanceTuningViewController.h
//  CoreDataPerf
//
//  Created by James Cryer on 22/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface PerformanceTuningViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UILabel *startTime;
	UILabel *endTime;
	UILabel *elapseTime;
	UITextView *results;
	UIPickerView *testPicker;
	NSManagedObjectContext *managedContext;
	NSArray *tests;
}

@property (nonatomic, retain) IBOutlet UILabel *startTime;
@property (nonatomic, retain) IBOutlet UILabel *endTime;
@property (nonatomic, retain) IBOutlet UILabel *elapseTime;
@property (nonatomic, retain) IBOutlet UITextView *results;
@property (nonatomic, retain) IBOutlet UIPickerView *testPicker;
@property (nonatomic, retain) NSManagedObjectContext *managedContext;
@property (nonatomic, retain) NSArray *tests;

- (id)initWithManagedContext:(NSManagedObjectContext *)managedObjectContext;

- (IBAction)runTest:(id)sender;

@end
