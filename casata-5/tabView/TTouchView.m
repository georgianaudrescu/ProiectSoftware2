//
//  TTouchView.m
//  casata
//
//  Created by me on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TTouchView.h"

@interface TTouchView ()
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;
@end

@implementation TTouchView
@synthesize delegate, callAtHitTest;


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
	
	UIView* returnMe =  [super hitTest:point withEvent:event];
	if (![returnMe isKindOfClass:[UIButton class]]) {
		[delegate performSelector:callAtHitTest];
	}
    
    return returnMe;
}
@end