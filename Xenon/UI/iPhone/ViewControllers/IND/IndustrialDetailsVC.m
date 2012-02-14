//
//  IndustrialDetailsVC.m
//  Xenon
//
//  Created by Mahendra on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IndustrialDetailsVC.h"

@implementation IndustrialDetailsVC
@synthesize entityItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"App_TableViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//custom init to select appropriate list
-(id)initWithEntityItem:(NSString*)selectedEntity
{
    self = [super init];
    
    if(self)
    {
        //self.entityItem = [[NSString alloc] initWithString:selectedEntity];
        self.entityItem = selectedEntity;
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
   // RELEASE_TO_NIL(self.entityItem);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title =self.entityItem;
    DataSource* dataSource = [[DataSource alloc] init];
    dataSourceArray = [[dataSource getEntityListItemsWithEntity:self.entityItem Type:IND] retain];
    RELEASE_TO_NIL(dataSource);
    int i = 50* [dataSourceArray count];
    
    if(i<300)
         [self setTableFrame:CGRectMake(10, 26, 300, i)];
    else
         [self setTableFrame:CGRectMake(10, 26, 300, 300)];
        
    
    
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

#pragma mark Table method overrides


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSourceArray count];
} 

- (void)configureCell:(DefaultCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_item_bg.png"]] autorelease];
    
    cell.cellText.text = [[dataSourceArray objectAtIndex:indexPath.row] name];
    cell.cellSubText.text = [(entityItem*)[dataSourceArray objectAtIndex:indexPath.row] value];
}


@end
