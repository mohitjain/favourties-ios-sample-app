//
//  TBFFavoriteItem.m
//  favourties
//
//  Created by Mohit Jain on 25/07/14.
//  Copyright (c) 2014 CodeBeerStartups. All rights reserved.
//

#import "TBFFavoriteItem.h"

@implementation TBFFavoriteItem

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.reason forKey:@"reason"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder{

    self = [super init];
    if(self){
        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
        _reason = [[aDecoder decodeObjectForKey:@"reason"] copy];
        
    }
    return self;
}

@end
