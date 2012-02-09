//
//  App_ViewController.h
//  Xenon
//
//  Created by Mahendra on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VZAnimatedView.h"

@interface App_ViewController : UIViewController
{
    VZAnimatedView *hudAnimatedView;
}

- (void)showHUD:(NSString *)message;
- (void)dismissHUD;

@end
