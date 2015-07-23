//
//  PlayGame.h
//  GameCards
//
//  Created by Juliya on 09.07.15.
//  Copyright (c) 2015 Juliya Odincova. All rights reserved.
//

#import "Card.h"
#import "PackCards.h"
#import "PlayingCard.h"

@interface PlayGame : PackCards

@property(nonatomic, readonly) NSUInteger matchedCountOfCards;
@property(nonatomic, readonly) NSInteger score;

@property (strong,nonatomic) NSArray *matchedCards;
@property (readonly,nonatomic) NSInteger lastScorelabel;

-(instancetype)initWithCardCount:(NSUInteger)count
                  usingPackCards:(PackCards*)pack
                    matchedCards:(NSUInteger) matchedCountOfCards;

-(void)chooseCardAtIndex:(NSUInteger)indexCard;

-(Card *)cardAtIndex:(NSUInteger)index;




@end
