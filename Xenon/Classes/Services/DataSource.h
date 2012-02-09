//
//  DataSource.h
//  Xenon
//
//  Created by Mahendra on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App_Storage.h"

@protocol dataSourceDelegate;


@interface DataSource : NSObject
{
    App_Storage* dataBase;
    
    id <dataSourceDelegate> delegate;
}

@property(nonatomic,retain)id<dataSourceDelegate>delegate;

-(void)getEntityListOfIndustry:(Industry)industry;

@end


@protocol dataSourceDelegate <NSObject>

-(void)dataSourceEntityListFetchDidFinish:(NSMutableArray*)entityArray;
-(void)dataSourceEntityListFetchDidFail:(NSError*)error;

@end
