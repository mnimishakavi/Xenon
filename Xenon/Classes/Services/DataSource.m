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
        parser = [[ParserInterface alloc] init];
        
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
    
    
    if(industry == IND)
    {
       //will be replaced by actual threading logic in future
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:IND], @"industry",
                                  /* ... */
                                  nil];
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(sendTestData:) userInfo:userInfo repeats:NO];
    }
    else if(industry == AXC)
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:AXC], @"industry",
                                  /* ... */
                                  nil];
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(sendTestData:) userInfo:userInfo repeats:NO];
    }
    else if(industry == PK)
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:PK], @"industry",
                                  /* ... */
                                  nil];
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(sendTestData:) userInfo:userInfo repeats:NO];
    }
    else if(industry == IKG)
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt:IKG], @"industry",
                                  /* ... */
                                  nil];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(sendTestData:) userInfo:userInfo repeats:NO];
    }
        
    
    
}

-(NSMutableArray*)getEntityListItemsWithEntity:(NSString*)entity Type:(Industry)Industry
{
    return [dataBase getEntityListItemsFromTable:IND_ENTITY_ITEMS ForEntity:entity];
}

-(NSMutableArray*)getEntityListItemsOfIndustry:(Industry)industry ForEntity:(NSString*)entityValue
{
    //for now pulling from DB can be nw also
    
    return [dataBase getEntityListItemsFromTable:IND_ENTITY_ITEMS ForEntity:@"finance"];
}
                                     
                                         
                                     

-(void)sendTestData:(NSTimer *)timer
{
    NSDictionary *userInfo = [timer userInfo];
    int industryType = [[userInfo objectForKey:@"industry"] intValue];
    
    if(delegate && [delegate respondsToSelector:@selector(dataSourceEntityListFetchDidFinish:)])
    {
        if(industryType== IND)
        {
            if([[dataBase getEntityListFromTable:IND_ENTITY_LIST] count])
            {
                 [delegate dataSourceEntityListFetchDidFinish:[dataBase getEntityListFromTable:IND_ENTITY_LIST]];
            }
            else
            {
                [parser parseDataofIndustry:IND];
                [delegate dataSourceEntityListFetchDidFinish:[dataBase getEntityListFromTable:IND_ENTITY_LIST]];
            }
           
           
        }
        else if(industryType == AXC)
        {
            if([[dataBase getEntityListFromTable:AXC_ENTITY_LIST] count])
            {
                [delegate dataSourceEntityListFetchDidFinish:[dataBase getEntityListFromTable:AXC_ENTITY_LIST]];
            }
            else
            {
                [parser parseDataofIndustry:AXC];
                [delegate dataSourceEntityListFetchDidFinish:[dataBase getEntityListFromTable:AXC_ENTITY_LIST]];
            }
            
            
        }
        else if(industryType == PK)
        {
            
            if([[dataBase getEntityListFromTable:PK_ENTITY_LIST] count])
            {
                [delegate dataSourceEntityListFetchDidFinish:[dataBase getEntityListFromTable:PK_ENTITY_LIST]];
            }
            else
            {
                [parser parseDataofIndustry:PK];
                [delegate dataSourceEntityListFetchDidFinish:[dataBase getEntityListFromTable:PK_ENTITY_LIST]];
            }

            
        }
        else if(industryType == IKG)
        {
            
            if([[dataBase getEntityListFromTable:IKG_ENTITY_LIST] count])
            {
                [delegate dataSourceEntityListFetchDidFinish:[dataBase getEntityListFromTable:IKG_ENTITY_LIST]];
            }
            else
            {
                [parser parseDataofIndustry:IKG];
                [delegate dataSourceEntityListFetchDidFinish:[dataBase getEntityListFromTable:IKG_ENTITY_LIST]];
            }
        }
       
       
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
