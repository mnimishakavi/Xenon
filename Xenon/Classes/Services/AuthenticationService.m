//
//  AuthenticationService.m
//  Xenon
//
//  Created by Mahendra on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AuthenticationService.h"

@interface AuthenticationService ()
{

    NSString* UNAME;
    NSString* PWD;
}
@end

@implementation AuthenticationService
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
   
    RELEASE_TO_NIL(delegate);
    RELEASE_TO_NIL(UNAME);
    RELEASE_TO_NIL(PWD);
    [super dealloc];
}


-(void)authenticateUserWithUserName:(NSString*)userName Password:(NSString*)password
{
    
    NSLog(@"Username is %@",userName);
    NSLog(@"passWordField is %@",password);
    
    UNAME = [[NSString alloc] initWithString:userName];
    PWD = [[NSString alloc] initWithString:password];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(sendAuthResponse) userInfo:nil repeats:NO];
    
    
           
}

//dummy method to send authentication response will be replaced with Netwrok Module/DB Module
-(void)sendAuthResponse
{
    if([UNAME isEqualToString:TEST_USER] && [PWD isEqualToString:TEST_PWD])
    {
        
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(signInDidPass)])
        {
            [self.delegate signInDidPass];
        }
        
    }
    else
    {
        if(self.delegate && [self.delegate respondsToSelector:@selector(signInDidFail:)])
        {
            NSError* error = [[NSError alloc] initWithDomain:@"Authentication" code:1 userInfo:[NSDictionary dictionaryWithObject:@"User Credentials Not Found" forKey:NSLocalizedDescriptionKey]];
            
            
            [self.delegate signInDidFail:[error autorelease]];
            
            
        }
    }

}

@end
