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
     IBOutlet UILabel* cellSubText;
}


@property(nonatomic,retain)UILabel* cellText;
@property(nonatomic,retain)UILabel* cellSubText;

- (void) initVars;

@end
