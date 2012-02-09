//
//  PKHomeVC.h
//  Xenon
//
//  Created by SadikAli on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"
#import "PKDetailsVC.h"

@interface PKHomeVC : App_TableViewController
{
    
}

- (void)configureCell:(DefaultCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
