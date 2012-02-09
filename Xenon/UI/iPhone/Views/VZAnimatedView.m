//
//  VZAnimatedView.m
//  Xenon
//
//  Created by Mahendra on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VZAnimatedView.h"

@implementation VZAnimatedView
@synthesize drawingRect;
@synthesize isScreenDimmed;
@synthesize isAnimating;

#define DEFAULT_LABEL_WIDTH		280.0
#define DEFAULT_LABEL_HEIGHT	50.0

// background drawing params
#define RECT_PADDING			  -10.0
#define ROUND_RECT_CORNER_RADIUS  8.0
#define BACKGROUND_OPACITY		  0.80
#define STROKE_OPACITY			  0.25

#define DIM_FILL_COLOR_R    0
#define DIM_FILL_COLOR_G    0
#define DIM_FILL_COLOR_B    0

#pragma mark -
#pragma mark Utility Methods

// Creates a CGPathRect with a round rect of the given radius.
CGPathRef pathWithRoundRect(CGRect rect, CGFloat cornerRadius) {
	//
	// Create the boundary path
	//
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL,
					  rect.origin.x,
					  rect.origin.y + rect.size.height - cornerRadius);
	
	// Top left corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x,
						rect.origin.y,
						rect.origin.x + rect.size.width,
						rect.origin.y,
						cornerRadius);
	
	// Top right corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x + rect.size.width,
						rect.origin.y,
						rect.origin.x + rect.size.width,
						rect.origin.y + rect.size.height,
						cornerRadius);
	
	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x + rect.size.width,
						rect.origin.y + rect.size.height,
						rect.origin.x,
						rect.origin.y + rect.size.height,
						cornerRadius);
	
	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x,
						rect.origin.y + rect.size.height,
						rect.origin.x,
						rect.origin.y,
						cornerRadius);
	
	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
	
	return path;
}


// Animates the view out from the superview. As the view is removed from the
// superview, it will be released.
- (void) dismissView
{
    self.isAnimating = NO;
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
	[self removeFromSuperview];
}


#pragma mark -
#pragma mark UIView Methods

// Constructor for this view. Creates and adds a loading view for covering the
// provided aSuperview.
//
// Parameters:
//    aSuperview - the superview that will be covered by the loading view
//
// returns the constructed view, already added as a subview of the aSuperview
//	(and hence retained by the superview)
+ (id) animatedViewWithSuperView:(UIView *)aSuperview labelText:(NSString *)theText dimScreen:(BOOL)dimFlag {
	
	VZAnimatedView *newAnimatedView = [[VZAnimatedView alloc] initWithFrame:[aSuperview bounds]];
	newAnimatedView.opaque = NO;
	newAnimatedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    newAnimatedView.isScreenDimmed = dimFlag;
	[aSuperview addSubview:newAnimatedView];
    
    newAnimatedView.isAnimating = YES;
    
	// find a rect that will fit our desired text
	CGSize maxSize = CGSizeMake(DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
	CGSize stringSize = [theText sizeWithFont:[UIFont boldSystemFontOfSize:[UIFont labelFontSize]]
							constrainedToSize:maxSize 
								lineBreakMode:UILineBreakModeClip]; 
	
	CGRect labelFrame = CGRectMake(0, 0, stringSize.width, stringSize.height);	
	UILabel *label = [[[UILabel alloc] initWithFrame:labelFrame] autorelease];	
	label.text = NSLocalizedString(theText, nil);
	label.textColor = [UIColor whiteColor];
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentCenter;
	label.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
	label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | 
	UIViewAutoresizingFlexibleRightMargin |
	UIViewAutoresizingFlexibleTopMargin | 
	UIViewAutoresizingFlexibleBottomMargin;
	[newAnimatedView addSubview:label];
	
	UIActivityIndicatorView *spinner = [[[UIActivityIndicatorView alloc] 
										 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite] autorelease];
	
	[newAnimatedView addSubview:spinner];
	spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | 
	UIViewAutoresizingFlexibleRightMargin |
	UIViewAutoresizingFlexibleTopMargin | 
	UIViewAutoresizingFlexibleBottomMargin;
	[spinner startAnimating];
	
	labelFrame.origin.x = floor(0.5 * (newAnimatedView.bounds.size.width - stringSize.width));
	labelFrame.origin.y = floor(0.5 * (newAnimatedView.bounds.size.height - stringSize.height));
	label.frame = labelFrame;
    
	CGRect activityRect = spinner.frame;
	activityRect.origin.x = floor(label.frame.origin.x - activityRect.size.width - 3);
	activityRect.origin.y = floor(((labelFrame.size.height - activityRect.size.height) * 0.5) + label.frame.origin.y);
	spinner.frame = activityRect;
	
	// now we store our drawing rect
	newAnimatedView.drawingRect = CGRectMake(spinner.frame.origin.x, 
											 label.frame.origin.y, 
											 ((label.frame.origin.x + label.frame.size.width) - spinner.frame.origin.x),
											 label.frame.size.height);
    
    // center in super view
    CGRect newRect = newAnimatedView.drawingRect;
    newRect.origin.x = (aSuperview.bounds.size.width - newRect.size.width) / 2;
    newRect.origin.y = (aSuperview.bounds.size.height - newRect.size.height) / 2;
    newAnimatedView.drawingRect = newRect;
    
    // adjust spinner and text label in the newly centered frame
    activityRect.origin.x = newRect.origin.x;
    labelFrame.origin.x = activityRect.origin.x + activityRect.size.width + 5;
    spinner.frame = activityRect;
    label.frame = labelFrame;
    
	return [newAnimatedView autorelease];
}


- (void) dealloc {
    [super dealloc];
}


// Draw the view.
- (void) drawRect:(CGRect)rect
{
	rect = [self frame];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (isScreenDimmed) {
        CGContextSetRGBFillColor(context, 
                                 DIM_FILL_COLOR_R, 
                                 DIM_FILL_COLOR_G, 
                                 DIM_FILL_COLOR_B, 
                                 BACKGROUND_OPACITY);	
        
        CGContextSetRGBStrokeColor(context, 
                                   DIM_FILL_COLOR_R, 
                                   DIM_FILL_COLOR_G, 
                                   DIM_FILL_COLOR_B, 
                                   BACKGROUND_OPACITY);	
        
        CGContextAddRect(context, rect);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    // Animating rect area    
    rect = self.drawingRect;
	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
	CGPathRef roundRectPath = pathWithRoundRect(rect, ROUND_RECT_CORNER_RADIUS);
	
    if (!isScreenDimmed) {
        CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);
        CGContextAddPath(context, roundRectPath);
        CGContextFillPath(context);
        
        CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);
        CGContextAddPath(context, roundRectPath);
        CGContextStrokePath(context);
    }
	
	
	CGPathRelease(roundRectPath);
}


@end
