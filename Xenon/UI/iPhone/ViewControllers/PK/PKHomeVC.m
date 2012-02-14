//
//  PKHomeVC.m
//  Xenon
//
//  Created by SadikAli on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PKHomeVC.h"

@implementation PKHomeVC

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
    [self setTableFrame:CGRectMake(10, 16, 300, 300)];
    
    [self showHUD:@"Fetching Data"];    
    
    DataSource* dataSource = [[DataSource alloc] init];
    dataSource.delegate = self;
    [dataSource getEntityListOfIndustry:PK];
    [dataSource release];
    
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

#pragma mark Data Source Callbacks

-(void)dataSourceEntityListFetchDidFinish:(NSMutableArray *)entityArray
{
    [self dismissHUD];
    
    
    dataSourceArray = [entityArray retain];
    
    [self.defaultTableView reloadData];
}

-(void)dataSourceEntityListFetchDidFail:(NSError *)error
{
    [self dismissHUD];
    [App_GeneralUtilities showAlertOKWithTitle:@"Error" withMessage:[error localizedDescription]];
}


#pragma mark Table method overrides


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"array count is %d",[dataSourceArray count]);
    return [dataSourceArray count];

} 

- (void)configureCell:(DefaultCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_item_bg.png"]] autorelease];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.cellText.text = [dataSourceArray objectAtIndex:indexPath.row];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PKDetailsVC* detailsVC = [[PKDetailsVC alloc] initWithEntityItem:[dataSourceArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailsVC animated:YES];
    [detailsVC release];
}


@end
