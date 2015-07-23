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
@property(strong,nonatomic) NSMutableArray *faceChooseCards;
@property (readwrite,nonatomic) NSInteger lastScoreLabel;
@property (strong,nonatomic,readwrite) NSMutableArray *logs;

@end

@implementation PlayGame

-(NSMutableArray *)cards {
    
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
    _matchedCountOfCards = matchedCountOfCards;
    self.logs = [NSMutableArray new];
    
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
          self.faceChooseCards = [[NSMutableArray alloc] init];
            self.lastScoreLabel = 0;
            for(PlayingCard *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched) {
                    
                    [self.faceChooseCards insertObject:otherCard atIndex:0];
                
                    NSString *log;
                    
                    if ([self.faceChooseCards count] == _matchedCountOfCards - 1)
                    {
                        // Будет сравнение
                        
                        int matchScore = [card match:self.faceChooseCards];
                        if (matchScore) {
                            self.lastScoreLabel = matchScore * SCORE_BONUS;
                            for (Card *faceChooseCard in self.faceChooseCards) {
                                faceChooseCard.isMatched = YES;
                                card.isMatched = YES;
                                
                            }
                            // Log about matched cards
                            log = [NSString stringWithFormat:@"Cards %@ %@ matched with score: %ld", card,
                                   [self.faceChooseCards componentsJoinedByString:@" "], (long)_lastScoreLabel];
                        } else {
                            self.lastScoreLabel =  - SCORE_PINALTY;
                            for (Card *faceChooseCard in self.faceChooseCards) {
                                faceChooseCard.isChosen = NO;
                                card.isChosen = NO;
                                
                            }
                            // Log about mismatched cards
                            log = [NSString stringWithFormat:@"Cards %@, %@ mismatched with penalty: %ld", card,
                                   [self.faceChooseCards componentsJoinedByString:@" "], (long)_lastScoreLabel];
                            
                        }
                        [self.logs addObject:log];
                        
                        break;
                    }
                    
                }
                
            }
            self.score +=  self.lastScoreLabel - COST_TO_CHOOSE;
            //

            card.isChosen = YES;
        }
    }
}
@end
