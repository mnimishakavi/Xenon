//
//  App_TableViewController.m
//  Xenon
//
//  Created by Mahendra on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "App_TableViewController.h"

@implementation App_TableViewController
@synthesize defaultTableView;
@synthesize tableViewContainer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    RELEASE_TO_NIL(defaultTableView);
    RELEASE_TO_NIL(tableViewContainer);
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc
{
    RELEASE_TO_NIL(defaultTableView);
    RELEASE_TO_NIL(tableViewContainer);
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self drawTable];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark Action Methods

//method to draw the table in round rect fashion
-(void)drawTable
{
    [self.tableViewContainer.layer setMasksToBounds:YES];           //mask the extra area
    [self.tableViewContainer.layer setCornerRadius:10.0];
    [self.tableViewContainer.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.tableViewContainer.layer setBorderWidth:1.0];
}

-(void)setTableFrame:(CGRect)Rect
{
    [self.tableViewContainer setFrame:Rect];
    //[self.defaultTableView setFrame:Rect];
    
}

#pragma mark HUD methods
#pragma mark -
#pragma mark HUD Methods 
- (void)showHUD:(NSString *)message {
    if(!hudAnimatedView){
        hudAnimatedView = [VZAnimatedView animatedViewWithSuperView:self.defaultTableView
                                                          labelText:message
                                                          dimScreen:NO];
    }
}

- (void)dismissHUD{
    if (hudAnimatedView) {
        [hudAnimatedView dismissView];
        hudAnimatedView = nil;
    } 
}


#pragma mark Table Methods

//Assuming only one section as the table is not a sectioned table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	DefaultCell *cell = (DefaultCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		// Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DefaultCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        
		
		cell.accessoryView = nil;
        //cell.textLabel.text = @"mahi";

        
                
	}
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
	return cell;
}





@end
