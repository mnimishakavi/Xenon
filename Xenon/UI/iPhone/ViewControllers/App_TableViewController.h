//
//  App_TableViewController.h
//  Xenon
//
//  Created by Mahendra on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "quartzcore/QuartzCore.h"
#import "DefaultCell.h"
#import "VZAnimatedView.h"


@interface App_TableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIView* tableViewContainer;
    IBOutlet UITableView* defaultTableView;
    
      VZAnimatedView *hudAnimatedView;
    
    NSMutableArray* dataSourceArray;
}

@property(nonatomic,retain)UITableView* defaultTableView;
@property(nonatomic,retain)UIView* tableViewContainer;


-(void)drawTable;
-(void)setTableFrame:(CGRect)Rect;
- (void)configureCell:(DefaultCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (void)showHUD:(NSString *)message;
- (void)dismissHUD;

@end
