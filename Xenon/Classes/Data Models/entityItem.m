//
//  entityItem.m
//  Xenon
//
//  Created by SadikAli on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "entityItem.h"

@implementation entityItem

@synthesize name;
@synthesize value;

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
    RELEASE_TO_NIL(name);
    RELEASE_TO_NIL(value);
}

@end
