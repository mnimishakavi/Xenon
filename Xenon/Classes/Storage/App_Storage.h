//
//  App_Storage.h
//  Xenon
//
//  Created by Mahendra on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

extern NSString* const IND_ENTITY_LIST;
extern NSString* const AXC_ENTITY_LIST;
extern NSString* const IKG_ENTITY_LIST;
extern NSString* const PK_ENTITY_LIST;

@interface App_Storage : NSObject
{
    
}

//singleton Instance
+ (App_Storage *)getInstance;
-(BOOL)initVars;
-(void)checkAndCreateDatabase:(NSString*)dataBaseType;
-(void) doBulkInsertIntoTable:(NSString*)table ContentValues:(NSMutableArray*)contentValues;
-(NSMutableArray*)getEntityListFromTable:(NSString*)table;

@end
