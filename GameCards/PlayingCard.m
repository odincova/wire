//
//  PlayingCard.m
//  GameCards
//
//  Created by Juliya on 07.07.15.
//  Copyright (c) 2015 Juliya Odincova. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(NSString *)contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+(NSArray *)validSuits{
   return @[@"♥️", @"♦️", @"♠️", @"♣️"];
}

-(void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit ]) {
        _suit = suit;
    }
}

-(NSString *)suit{
    return _suit ? _suit:@"?";
}

+(NSArray *)rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];

}

+(NSInteger)maxRank{
    
    return [[self rankStrings] count] - 1;
}

-(void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

-(int)match:(NSArray *)otherCards{
    int score = 0;
    
    
    NSUInteger countOtherCards = [otherCards count];
    
    if(countOtherCards){
        
        for (Card *card in otherCards) {
            if ([card isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherCard = (PlayingCard *)card;
                if ([otherCard.suit isEqual:self.suit]) {
                    score += 1;
                    
                }
                if (otherCard.rank == self.rank) {
                    score += 4;
                    
                }
            }
        }
        
    }
    if(countOtherCards > 1){
        
        score += [[otherCards firstObject] match : [otherCards subarrayWithRange:NSMakeRange(1, countOtherCards - 1)]];
                      }
                   
    return score;
    
}
@end



