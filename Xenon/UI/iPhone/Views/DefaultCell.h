//
//  DefaultCell.h
//  Xenon
//
//  Created by Mahendra on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultCell : UITableViewCell
{
     IBOutlet UILabel* cellText;
}


@property(nonatomic,retain)UILabel* cellText;

- (void) initVars;

@end
