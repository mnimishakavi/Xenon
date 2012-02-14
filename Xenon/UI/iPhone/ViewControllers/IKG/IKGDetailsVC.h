//
//  IKGDetailsVC.h
//  Xenon
//
//  Created by SadikAli on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "App_TableViewController.h"
#import "DataSource.h"

@interface IKGDetailsVC : App_TableViewController
{
    NSString* entityItem;

}

@property(nonatomic,retain)NSString* entityItem;
-(id)initWithEntityItem:(NSString*)selectedEntity;

@end
