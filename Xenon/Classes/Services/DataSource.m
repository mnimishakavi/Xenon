//
//  DataSource.m
//  Xenon
//
//  Created by Mahendra on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource
@synthesize delegate;


-(id)init
{
    if(self = [super init])
    {
        dataBase = [App_Storage getInstance];
    }
    
    return self;
}

-(void)dealloc
{
    [super dealloc];
    RELEASE_TO_NIL(delegate);
}
    
-(void)getEntityListOfIndustry:(Industry)industry
{
    
    //dummy test
  //  NSLog(@"count is %d",[[dataBase getEntityListFromTable:IND_ENTITY_LIST] count]);
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(sendTestError) userInfo:nil repeats:NO];
}

-(void)sendTestData
{
    if(delegate && [delegate respondsToSelector:@selector(dataSourceEntityListFetchDidFinish:)])
    {
        [delegate dataSourceEntityListFetchDidFinish:[dataBase getEntityListFromTable:IND_ENTITY_LIST]];
    }
}

-(void)sendTestError
{
    
    if(delegate && [delegate respondsToSelector:@selector(dataSourceEntityListFetchDidFail:)])
    {
         NSError* error = [[NSError alloc] initWithDomain:@"Data" code:1 userInfo:[NSDictionary dictionaryWithObject:@"Unable to Fetch Data" forKey:NSLocalizedDescriptionKey]];
        [delegate dataSourceEntityListFetchDidFail:error];
        [error release];
    }
   
}

@end
