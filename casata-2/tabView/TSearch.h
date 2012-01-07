//
//  TSearch.h
//  casata
//
//  Created by Georgiana U on 06/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRequest.h"
#import "TAd.h"

@interface TSearch : NSObject
{
    TAd *ad;
}

@property (nonatomic, retain) TAd *ad;

-(void) ProcessRequest:(NSMutableDictionary *)filtre2 
        atString:(NSMutableString *) postString 
            withfiltru: (NSString *) filtru andparam:(NSString *) param;
-(void) Search:(NSMutableDictionary *) filtre;

@end
