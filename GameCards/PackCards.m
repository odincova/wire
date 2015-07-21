//
//  PackCards.m
//  GameCards
//
//  Created by Juliya on 07.07.15.
//  Copyright (c) 2015 Juliya Odincova. All rights reserved.
//

#import "PackCards.h"

@interface PackCards()

@property(strong, nonatomic) NSMutableArray *cards;

@end

@implementation PackCards

-(NSArray *)cards{
    
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
    
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop{
    
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }else{
        [self.cards addObject:card];
    }
}

-(void)addCard:(Card *)card{
    [self addCard:card atTop:NO];
}

-(Card *)drawRandomCard{
    
    Card *randomCard = nil;
    if ([self.cards count]) {
        unsigned index = arc4random()% [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
