//
//  TBFFavoriteItem.h
//  favourties
//
//  Created by Mohit Jain on 25/07/14.
//  Copyright (c) 2014 CodeBeerStartups. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBFFavoriteItem : NSObject <NSCoding>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *reason;

@end
