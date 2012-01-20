//
//  TAnnotationView.m
//  casata
//
//  Created by me on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TAnnotationView.h"

@implementation TAnnotationView
//@synthesize imagView;

/*
 -(void)setSelected:(BOOL)selected animated:(BOOL)animated
 {
 [super setSelected:selected animated:animated];
 if(selected)
 {
 self.imagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logosmall.png"]];
 
 [self addSubview:imagView];
 
 }
 
 else
 
 {
 [self.imagView removeFromSuperview];
 }
 }
 
 -(void)didAddSubview:(UIView *)subview
 {
 if(subview isKindOfClas:UICalloutView
 }
 */
- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	if (self != nil) {
		self.image  = [UIImage imageNamed:@"icon.png"];
		
		CGPoint notNear = CGPointMake(10000.0,10000.0);
		self.calloutOffset = notNear;
        
	}
	return self;
}

-(void)dealloc
{
    // [imagView release];
    [super dealloc];
}


@end
