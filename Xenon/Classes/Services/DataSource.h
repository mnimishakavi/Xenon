//
//  DataSource.h
//  Xenon
//
//  Created by Mahendra on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App_Storage.h"
#import "SBJson.h"
#import "ParserInterface.h"

@protocol dataSourceDelegate;


@interface DataSource : NSObject
{
    App_Storage* dataBase;
    ParserInterface* parser;
    
    id <dataSourceDelegate> delegate;
}

@property(nonatomic,retain)id<dataSourceDelegate>delegate;

-(void)getEntityListOfIndustry:(Industry)industry;
-(NSMutableArray*)getEntityListItemsWithEntity:(NSString*)entity Type:(Industry)Industry;

@end


@protocol dataSourceDelegate <NSObject>

-(void)dataSourceEntityListFetchDidFinish:(NSMutableArray*)entityArray;
-(void)dataSourceEntityListFetchDidFail:(NSError*)error;

@end
