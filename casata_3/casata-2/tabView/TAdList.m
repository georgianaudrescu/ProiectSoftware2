

#import "TAdList.h"
#import "TAd.h"
@implementation TAdList
@synthesize adList, countAdsInAdList, getAdListRequest;

-(id) init{
    self = [super init];
    if(self) {
        adList = [[NSMutableOrderedSet alloc]init];
    }
    return self;
}

-(void)getAdsFromData:(NSData *)data
{
    
    adList = [[NSMutableOrderedSet alloc]init];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    NSLog(@"data JSON: %@", json); 
    NSArray *allAds = [json objectForKey:@"ads"];
    
    
    for(NSDictionary *row in allAds)    { [TAd TAd:(NSDictionary *) row];
    }
    //(metodele din getAd din TAd ?      
}

-(void) addAdToAdList:(TAd *)aAdList{
    [adList addObject:aAdList];
    countAdsInAdList=adList.count;
}

-(TAd*)getAdFromIndex:(int)indexAdList{
    return [adList objectAtIndex:indexAdList];
}

-(int) getIndexForAd:(TAd *)aAdList{
    return [adList indexOfObject:aAdList];
}

-(void) removeAdFromAdList:(TAd *)rAd{
    [adList removeObject:rAd];
}

-(void) removeAdAtIndex:(int)indexAdList{
    [adList removeObjectsAtIndex:indexAdList];
    
}
-(void)dealloc
{
    [self.adList dealloc];
    [super dealloc];
}@end
