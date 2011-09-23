//
//  PerformanceTuningViewController.m
//  CoreDataPerf
//
//  Created by James Cryer on 22/09/2011.
//  Copyright 2011 Home. All rights reserved.
//

#import "PerformanceTuningViewController.h"
#import "PerformanceTest.h"
#import "FetchAllMoviesActorsAndStudiosTest.h"
#import "DidFaultTest.h"
#import "SingleFiringFaultTest.h"
#import "PreFetchFaultingTest.h"
#import "CacheTest.h"
#import "UniquingTest.h"
#import "PredicatePerformance.h"
#import "SubqueryTest.h"


@implementation PerformanceTuningViewController

@synthesize startTime, endTime, elapseTime, results, testPicker, managedContext, tests;

- (id)initWithManagedContext:(NSManagedObjectContext *)managedObjectContext {

	self = [super init];
	
	if (self) {
		self.managedContext = managedObjectContext;
	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	startTime.text  = @"";
	endTime.text    = @"";
	elapseTime.text = @"";
	results.text    = @"";
	
	FetchAllMoviesActorsAndStudiosTest *famaasTest = [[FetchAllMoviesActorsAndStudiosTest alloc] init];
	DidFaultTest *dfTest						   = [[DidFaultTest alloc] init];
	SingleFiringFaultTest *sfTest				   = [[SingleFiringFaultTest alloc] init];
	PreFetchFaultingTest *pffTest				   = [[PreFetchFaultingTest alloc] init];
	CacheTest *cTest							   = [[CacheTest alloc] init];
	UniquingTest *uTest							   = [[UniquingTest alloc] init];
	PredicatePerformance *ppTest				   = [[PredicatePerformance alloc] init];
	SubqueryTest *subQueryTest					   = [[SubqueryTest alloc] init];
	
	self.tests = [[NSArray alloc] initWithObjects:famaasTest, dfTest, sfTest, pffTest, cTest, uTest, ppTest, subQueryTest, nil];
	[famaasTest release];
	[dfTest release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {	
	return [self.tests count];
}

#pragma mark -
#pragma mark UIPickerViewDelegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	id <PerformanceTest> test = [self.tests objectAtIndex:row];
	return [test name];
}

#pragma mark -
#pragma mark PerformanceTuningViewController methods

- (IBAction)runTest:(id)sender {
	
	NSManagedObjectContext *context = self.managedContext;
	
	id <PerformanceTest> test = [self.tests objectAtIndex:[testPicker selectedRowInComponent:0]];
	
	NSDate *start = [NSDate date];
	results.text  = [test runWithContext:context];
	NSDate *end   = [NSDate date];
	
	startTime.text = [start description];
	endTime.text   = [end description];
	
	elapseTime.text = [NSString stringWithFormat:@"%.03f seconds", [end timeIntervalSinceDate:start]];
}


- (void)dealloc {
	[managedContext release];
    [super dealloc];
}


@end
