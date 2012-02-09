//
//  App_Header.m
//  Xenon
//
//  Created by Mahendra on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "App_Header.h"

@implementation App_Header

- (void) drawRect:(CGRect)rect{
    UIImage *image = [UIImage imageNamed:@"app_header"];
    [image drawInRect:rect];
    
    CGRect frame = CGRectMake(110, 10, self.frame.size.width, self.frame.size.height);
    
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
   // UILabel* label = [[UILabel alloc] init];
	[label setBackgroundColor:[UIColor clearColor]];
	label.font = [UIFont boldSystemFontOfSize:20.0];
	label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor blackColor];
	label.text = @"Industrial";//self.topItem.title;
    [label sizeToFit];
	self.topItem.titleView = label;
	[label release];
}


@end
