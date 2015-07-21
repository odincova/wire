//
//  PlayGame.m
//  GameCards
//
//  Created by Juliya on 09.07.15.
//  Copyright (c) 2015 Juliya Odincova. All rights reserved.
//

#import "PlayGame.h"

@interface PlayGame()

@property(nonatomic, readwrite) NSInteger score;
@property(strong, nonatomic) NSMutableArray *cards;
//@property(strong,nonatomic) NSMutableArray *faceChooseCards;
@property (readwrite,nonatomic) NSInteger lastScoreLabel;


@end

@implementation PlayGame

-(void)setMatchedCount:(NSUInteger)matchedCount{
   
    _matchedCountOfCards = _matchedCountOfCards >=2 ? _matchedCountOfCards: 2;
    
}

-(NSMutableArray *)cards{
    
    if (!_cards)_cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                  usingPackCards:(PackCards*)pack
                  matchedCards:(NSUInteger) matchedCountOfCards
{
    
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [pack drawRandomCard];
            if (card){
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    self.matchedCountOfCards = matchedCountOfCards;
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index{
    
    return index < self.cards.count ? self.cards[index] : nil;
    
}

static const int SCORE_PINALTY = 2;
static const int SCORE_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


-(void)chooseCardAtIndex:(NSUInteger)indexCard{
   Card *card = [self cardAtIndex:indexCard];
    
    if (!card.isMatched)
    {
        if (card.isChosen) {
            card.isChosen = NO;
            
        } else
        {
           
                        //add cards in array - faceChooseCards
           NSMutableArray *faceChooseCards = [[NSMutableArray alloc] init];
            self.score = 0;
            
            for(PlayingCard *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched) {
                    
                    [faceChooseCards insertObject:otherCard atIndex:0];
                    
                    if ([faceChooseCards count] ==  _matchedCountOfCards - 1)
                    {
                        int matchScore = [card match:faceChooseCards];
                        if (matchScore) {
                            self.score += (matchScore * SCORE_BONUS);
                            for (Card *faceChooseCard in faceChooseCards) {
                                faceChooseCard.isMatched = YES;
                                card.isMatched = YES;
                                
                            }
                            
                        }else{
                            self.score -= SCORE_PINALTY;
                            for (Card *faceChooseCard in faceChooseCards) {
                                faceChooseCard.isChosen = NO;
                                card.isChosen = NO;
                                
                            }
                        }
                       
                    }
                    
                }
                
            }
            self.score -=  COST_TO_CHOOSE;
             card.isChosen = YES;
        }
    }
}
@end
