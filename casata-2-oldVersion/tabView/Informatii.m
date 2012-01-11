//
//  Informatii.m
//  casata
//
//  Created by me on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Informatii.h"

static NSString *selectedFavorite=nil;

@implementation Informatii

+(void) selectedFavoriteChange:(NSString *) aString
{
    
    if(selectedFavorite!=nil)
    {[selectedFavorite release];
        selectedFavorite = nil;
    }
    
    if([aString isEqualToString:@""]==NO)
    
    { selectedFavorite = [[NSString alloc] initWithString:aString];
        [[NSNotificationCenter defaultCenter] postNotificationName:[self selectFavNotificationName] object:nil];
    }
        NSLog(@"Favorite selected:%@", aString); 
     
    
}
+(NSString *)selectedFavorite
{ if(selectedFavorite!=nil)
    return selectedFavorite;
    else return @"";
}
+(NSString*) selectFavNotificationName
{ return @"Fav notification";
}

@end
