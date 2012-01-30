//
//  TRequest.h
//  casata
//
//  Created by Oana B on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRequest : NSObject{
    NSData *resultData;
    NSURL * url;
    NSMutableDictionary * paramList;
}

@property (nonatomic, copy) NSData * resultData;
@property (nonatomic, copy) NSURL * url;
@property (nonatomic, copy) NSMutableDictionary *paramList;

-(void)initWithHost:(NSString *)hostString;
-(BOOL)makeRequestWithString:(NSString *)aString;
-(NSData *)requestData;
//-(void) addParamList:(NSSet *)objects;
//-(void) addParamListObject:(NSString *)object;

@end
