//
//  AXCHomeVC.m
//  Xenon
//
//  Created by SadikAli on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AXCHomeVC.h"

@implementation AXCHomeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"App_TableViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Resizing the Table View depending on the data
    [self setTableFrame:CGRectMake(10, 56, 300, 300)];
    
    //self.title = @"Industrials";
    //DataSource* dataSource = [[DataSource alloc] init];
    
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
    return 6;
} 

- (void)configureCell:(DefaultCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_item_bg.png"]] autorelease];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.cellText.text = @"AXCtest";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AXCDetailsVC* detailsVC = [[AXCDetailsVC alloc] init];
    [self.navigationController pushViewController:detailsVC animated:YES];
    [detailsVC release];
}



@end
