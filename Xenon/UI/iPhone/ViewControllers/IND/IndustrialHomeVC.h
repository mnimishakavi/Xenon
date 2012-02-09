//
//  IndustrialHomeVC.h
//  Xenon
//
//  Created by Mahendra on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndustrialDetailsVC.h"
#import "DataSource.h"

@interface IndustrialHomeVC : App_TableViewController<dataSourceDelegate>
{
    
}

- (void)configureCell:(DefaultCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
