//
//  PackCards.h
//  GameCards
//
//  Created by Juliya on 07.07.15.
//  Copyright (c) 2015 Juliya Odincova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PackCards : NSObject

-(void)addCard:(Card *)card;
-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(Card *)drawRandomCard;



@end
