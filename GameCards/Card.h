//
//  Card.h
//  GameCards
//
//  Created by Juliya on 07.07.15.
//  Copyright (c) 2015 Juliya Odincova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic) BOOL isChosen;
@property (nonatomic) BOOL isMatched;
@property (strong, nonatomic) NSString *contents;

-(int)match:(NSArray*)otherCards;

@end
