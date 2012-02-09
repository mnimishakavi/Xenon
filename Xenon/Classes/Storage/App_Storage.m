//
//  App_Storage.m
//  Xenon
//
//  Created by Mahendra on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//error handling needed

#import "App_Storage.h"

#define kMaxItemsForLoop 1000

NSString* const IND_ENTITYLIST     = @"create table if not exists IND_EntityList (_id integer primary key, entity text null);";
NSString* const AXC_ENTITYLIST     = @"create table if not exists AXC_EntityList (_id integer primary key, entity text null);";
NSString* const IKG_ENTITYLIST     = @"create table if not exists IKG_EntityList (_id integer primary key, entity text null);";
NSString* const PK_ENTITYLIST     = @"create table if not exists PK_EntityList (_id integer primary key, entity text null);";


NSString* const IND_ENTITY_LIST  = @"IND_EntityList";
NSString* const AXC_ENTITY_LIST  = @"AXC_EntityList";
NSString* const IKG_ENTITY_LIST  = @"IKG_EntityList";
NSString* const PK_ENTITY_LIST  = @"PK_EntityList";


static sqlite3 *database = nil;

@implementation App_Storage

//singleton Instance
+ (App_Storage *)getInstance
{
    static App_Storage* instance;
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[App_Storage alloc] init];
        }
    }
    
    
    if([instance initVars])
    return instance;
    
    return nil;
}


-(BOOL)initVars
{
    
    //essentially checking and loading the database
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [[paths objectAtIndex:0] stringByAppendingPathComponent:DB_NAME];
    
    
    NSLog(@"db path is %@",documentsDir);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError* error;
    
    // Check if the sqlite db exists in the application path
	if(![fileManager fileExistsAtPath:documentsDir])
    {
        NSString *defaultAppPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
        
       if(! [fileManager copyItemAtPath:defaultAppPath toPath:documentsDir error:&error])
       {
           return NO;
       }
    }
    
    
    if (sqlite3_open([documentsDir UTF8String], &database) == SQLITE_OK) 
    {
		[self checkAndCreateDatabase:IND_ENTITYLIST];
        [self checkAndCreateDatabase:AXC_ENTITYLIST];
        [self checkAndCreateDatabase:IKG_ENTITYLIST];
        [self checkAndCreateDatabase:PK_ENTITYLIST ];
        
        return YES;
    }
	else
		return NO;
    

    return NO;
}

-(void)checkAndCreateDatabase:(NSString*)dataBaseType
{
   
  //create the tables if they donot exist    
    
    int returnCode = 0;
    sqlite3_stmt* statement = NULL;
    returnCode = sqlite3_prepare(database, [dataBaseType UTF8String], -1, &statement, 0);
    
    //throw proper errors
    if(SQLITE_DONE != sqlite3_step(statement))
    {
        //error
    }
    else
    {
        NSLog(@"success");
    }
    
    sqlite3_finalize(statement);
    
}


-(void) doBulkInsertIntoTable:(NSString*)table
	   ContentValues:(NSMutableArray*)contentValues{
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString* sqlQuery = [[NSString alloc] initWithFormat:@"%@%@%@",@"insert into ",table,@"(entity) values(?)"];
    
    NSLog(@"query is %@",sqlQuery);
    
    
    
    sqlite3_stmt* statement = NULL;
    
    for(int i=0;i< [contentValues count];i++)
    {
        const char* entityName = [[contentValues objectAtIndex:i] UTF8String];
        
        
        if(sqlite3_prepare(database, [sqlQuery UTF8String], -1, &statement, 0) != SQLITE_OK)
        {
            NSLog(@"%s",sqlite3_errmsg(database));
        }
        
        if(sqlite3_bind_text(statement, 1, entityName, -1, SQLITE_TRANSIENT) != SQLITE_OK)
        {
            //error
             NSLog(@"%s",sqlite3_errmsg(database));
        }
        else
        {
            if(SQLITE_DONE != sqlite3_step(statement))
            {
                //error
            }
            else
            {
                NSLog(@"success");
            }
        }
        
    }
    
    [sqlQuery release];
    sqlite3_finalize(statement);
	
    [pool release];
	
}

-(NSMutableArray*)getEntityListFromTable:(NSString*)table
{
    NSString* sqlQuery = [[NSString alloc] initWithFormat:@"%@%@",@"select * from ",table];
    
    NSMutableArray* dataArray = [[NSMutableArray alloc] init];
    
    sqlite3_stmt* statement = NULL;
    
    if(sqlite3_prepare(database, [sqlQuery UTF8String], -1, &statement, 0) != SQLITE_OK)
    {
        NSLog(@"%s",sqlite3_errmsg(database));
        [sqlQuery release];
    }
    else
    {
        [sqlQuery release];
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            [dataArray addObject:[NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(statement, 1)]];
        }
    }
    
    
    
    return [dataArray autorelease];
}


@end
