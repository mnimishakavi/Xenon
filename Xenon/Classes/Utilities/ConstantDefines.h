//
//  ConstantDefines.h
//  Xenon
//
//  Created by Mahendra on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App_GeneralUtilities.h"

#define RELEASE_TO_NIL(x) { if (x!=nil) { [x release]; x = nil; } }

#define TEST_USER @"test"
#define TEST_PWD  @"test"

#define DB_NAME @"industrial.db"






//Uncomment this only if you are a developer
//#define DEVELOPMENT 1

typedef enum industryType{
    IND = 1,
    AXC = 2,
    IKG = 3,
    PK = 4
}Industry;

@interface ConstantDefines : NSObject

@end
