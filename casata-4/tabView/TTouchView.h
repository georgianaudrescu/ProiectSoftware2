//
//  TTouchView.h
//  casata
//
//  Created by me on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UIView;

@interface TTouchView : UIView {
	id delegate;
	SEL callAtHitTest;
}
@property (assign) id delegate;
@property (assign) SEL callAtHitTest;

@end