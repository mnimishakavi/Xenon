//
//  VZAnimatedView.h
//  Xenon
//
//  Created by Mahendra on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VZAnimatedView : UIView {
	CGRect drawingRect;
    BOOL isScreenDimmed;
    BOOL isAnimating;
}

@property CGRect drawingRect;
@property BOOL isScreenDimmed;
@property BOOL isAnimating;

+(id) animatedViewWithSuperView:(UIView *)aSuperview labelText:(NSString *)theText dimScreen:(BOOL)dimFlag;
-(void) dismissView;

@end
