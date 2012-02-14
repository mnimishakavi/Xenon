//
//  AXCHomeVC.h
//  Xenon
//
//  Created by SadikAli on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXCDetailsVC.h"
#import "DataSource.h"

@interface AXCHomeVC : App_TableViewController<dataSourceDelegate>
{
    
}

- (void)configureCell:(DefaultCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
