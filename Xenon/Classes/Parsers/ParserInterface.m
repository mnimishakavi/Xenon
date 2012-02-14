//
//  ParserInterface.m
//  Xenon
//
//  Created by SadikAli on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParserInterface.h"

@implementation ParserInterface

@synthesize delegate;

-(id)init
{
    if(self = [super init])
    {
        
    }
    
    return self;
}


-(void)dealloc
{
    [super dealloc];
    
    RELEASE_TO_NIL(delegate);
}

-(void)parseDataofIndustry:(Industry)industry
{
    NSError* error;
    NSString *jsonString;
    if(industry == IND)
    {
         jsonString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"INDMatrix" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
        
        NSDictionary *json = [jsonString JSONValue];
        
        RELEASE_TO_NIL(jsonString);
        
        // Get all object
        NSArray *items = [json valueForKeyPath:@"d.Items"];
        
        NSLog(@"count of items is %d",[items count]);
        
        NSMutableArray* entityListArray = [[NSMutableArray alloc] init];
        NSMutableDictionary* entityListItemsDictionary = [[NSMutableDictionary alloc] init];
        
        for(int i=0;i<[items count];i++)
        {
            //NSLog(@"title is  %@",[[items objectAtIndex:i] objectForKey:@"Title"]);
           // NSLog(@"title is  %@",[[items objectAtIndex:i] objectForKey:@"Items"]);
            [entityListArray addObject:[[items objectAtIndex:i] objectForKey:@"Title"]];
            
            
            NSMutableArray* arrayToHoldItems = [[NSMutableArray alloc] init];
            
            NSArray *array1 = [[items objectAtIndex:i] objectForKey:@"Items"];
            NSEnumerator *enumerator = [array1 objectEnumerator];
            NSDictionary* item;
            while (item = (NSDictionary*)[enumerator nextObject]) 
            {
                NSLog(@"clientId = %@",  [item objectForKey:@"Title"]);
                NSLog(@"clientName = %@",[item objectForKey:@"Value"]);
                
                entityItem* temporaryItem = [[entityItem alloc] init];
                temporaryItem.name = [item objectForKey:@"Title"];
                temporaryItem.value = [item objectForKey:@"Value"];
                [arrayToHoldItems addObject:temporaryItem];
                RELEASE_TO_NIL(temporaryItem);
                
            }
            
            [entityListItemsDictionary setObject:arrayToHoldItems forKey:[[items objectAtIndex:i] objectForKey:@"Title"]];
            NSLog(@"arrayToHoldItems count is %d",[arrayToHoldItems count]);
            RELEASE_TO_NIL(arrayToHoldItems);
            
            
        }
        
        [[App_Storage getInstance] storeEntityListIntoTable:IND_ENTITY_LIST ContentValues:entityListArray];
        [[App_Storage getInstance] storeEntityItemsIntoTable:IND_ENTITY_ITEMS ContentValues:entityListItemsDictionary];
        
        RELEASE_TO_NIL(entityListArray);
        RELEASE_TO_NIL(entityListItemsDictionary);
      
    }
    else if(industry == AXC)
    {
        jsonString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AXCMatrix" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
        
        NSDictionary *json = [jsonString JSONValue];
        
        RELEASE_TO_NIL(jsonString);
        
        // Get all object
        NSArray *items = [json valueForKeyPath:@"d.Items"];
        
        NSLog(@"count of items is %d",[items count]);
        
        NSMutableArray* entityListArray = [[NSMutableArray alloc] init];
        
        for(int i=0;i<[items count];i++)
        {
            NSLog(@"title is  %@",[[items objectAtIndex:i] objectForKey:@"Title"]);
            [entityListArray addObject:[[items objectAtIndex:i] objectForKey:@"Title"]];
        }
        
        [[App_Storage getInstance] storeEntityListIntoTable:AXC_ENTITY_LIST ContentValues:entityListArray];
        [entityListArray release];
        
        NSArray *array1 = [[items objectAtIndex:0] objectForKey:@"Items"];
        NSEnumerator *enumerator = [array1 objectEnumerator];
        NSDictionary* item;
        while (item = (NSDictionary*)[enumerator nextObject]) {
            NSLog(@"clientId = %@",  [item objectForKey:@"Title"]);
            NSLog(@"clientName = %@",[item objectForKey:@"Value"]);
            //NSLog(@"job = %@",       [item objectForKey:@"job"]);
        }
        
//        if(delegate && [delegate respondsToSelector:@selector(parsingDidFinish: Type:)])
//        {
//            [delegate parsingDidFinish:entityListArray Type:AXC_Parser];
//            [entityListArray release];
//        }

    }
    else if(industry == PK)
    {
        jsonString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IKGMatrix" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
        
        NSDictionary *json = [jsonString JSONValue];
        
        RELEASE_TO_NIL(jsonString);
        
        // Get all object
        NSArray *items = [json valueForKeyPath:@"d.Items"];
        
        NSLog(@"count of items is %d",[items count]);
        
        NSMutableArray* entityListArray = [[NSMutableArray alloc] init];
        
        for(int i=0;i<[items count];i++)
        {
            NSLog(@"title is  %@",[[items objectAtIndex:i] objectForKey:@"Title"]);
            [entityListArray addObject:[[items objectAtIndex:i] objectForKey:@"Title"]];
        }
        
        [[App_Storage getInstance] storeEntityListIntoTable:PK_ENTITY_LIST ContentValues:entityListArray];
        [entityListArray release];
        
        NSArray *array1 = [[items objectAtIndex:0] objectForKey:@"Items"];
        NSEnumerator *enumerator = [array1 objectEnumerator];
        NSDictionary* item;
        while (item = (NSDictionary*)[enumerator nextObject]) {
            NSLog(@"clientId = %@",  [item objectForKey:@"Title"]);
            NSLog(@"clientName = %@",[item objectForKey:@"Value"]);
            //NSLog(@"job = %@",       [item objectForKey:@"job"]);
        }
        
//        if(delegate && [delegate respondsToSelector:@selector(parsingDidFinish: Type:)])
//        {
//            [delegate parsingDidFinish:entityListArray Type:PK_Parser];
//            [entityListArray release];
//        }

    }
    else if(industry == IKG)
    {
        jsonString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PKMatrix" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
        
        NSDictionary *json = [jsonString JSONValue];
        
        RELEASE_TO_NIL(jsonString);
        
        // Get all object
        NSArray *items = [json valueForKeyPath:@"d.Items"];
        
        NSLog(@"count of items is %d",[items count]);
        
        NSMutableArray* entityListArray = [[NSMutableArray alloc] init];
        
        for(int i=0;i<[items count];i++)
        {
            NSLog(@"title is  %@",[[items objectAtIndex:i] objectForKey:@"Title"]);
            [entityListArray addObject:[[items objectAtIndex:i] objectForKey:@"Title"]];
        }
        
        [[App_Storage getInstance] storeEntityListIntoTable:IKG_ENTITY_LIST ContentValues:entityListArray];
        [entityListArray release];
        
        NSArray *array1 = [[items objectAtIndex:0] objectForKey:@"Items"];
        NSEnumerator *enumerator = [array1 objectEnumerator];
        NSDictionary* item;
        while (item = (NSDictionary*)[enumerator nextObject]) {
            NSLog(@"clientId = %@",  [item objectForKey:@"Title"]);
            NSLog(@"clientName = %@",[item objectForKey:@"Value"]);
            //NSLog(@"job = %@",       [item objectForKey:@"job"]);
        }
        
//        if(delegate && [delegate respondsToSelector:@selector(parsingDidFinish: Type:)])
//        {
//            [delegate parsingDidFinish:entityListArray Type:IKG_Parser];
//            [entityListArray release];
//        }

    }
    
    
    

}

@end
