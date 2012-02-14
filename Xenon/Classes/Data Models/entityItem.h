//
//  entityItem.h
//  Xenon
//
//  Created by SadikAli on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface entityItem : NSObject
{
    NSString* name;
    NSString* value;
}

@property(nonatomic,retain) NSString* name;
@property(nonatomic,retain) NSString* value;



@end
