//
//  ViewController.m
//  GameCards
//
//  Created by Juliya on 07.07.15.
//  Copyright (c) 2015 Juliya Odincova. All rights reserved.
//

#import "ViewController.h"
//#import "PlayCardPack.h"
#import "PlayGame.h"

@interface ViewController ()

//@property (strong, nonatomic) PackCards *packCards;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) PlayGame *game;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentOfNumberOfCards;

@property (weak, nonatomic) IBOutlet UISlider *sliderScore;
@property (weak, nonatomic) IBOutlet UILabel *labelSliderText;
@property(strong, nonatomic) NSMutableArray *changeScore;
@property(nonatomic) NSInteger flipCount;


- (IBAction)newGame:(id)sender;

- (IBAction)segmentButton:(id)sender;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PlayGame *)game {
    
    if(!_game) {
        
        int matchedCardsCount = self.segmentOfNumberOfCards.selectedSegmentIndex == 0 ? 2 : 3;
        
        _game =[[PlayGame alloc] initWithCardCount:[self.cardButtons count]
                                    usingPackCards:[self packCards]
                                      matchedCards:matchedCardsCount];
    }
    
    return _game;
}


-(PackCards *)packCards{
    
    return nil; // abstract
    
}

- (NSMutableArray *)changeScore
{
    if (!_changeScore)_changeScore = [[NSMutableArray alloc] init];
    
    return _changeScore;
}


-(void)updateHistory {
    
    self.sliderScore.minimumValue = 0;
    self.sliderScore.maximumValue = self.game.logs.count;
    self.sliderScore.value = self.sliderScore.maximumValue;
    [self sliderChange:self.sliderScore];
    
    if (self.game.logs.count > 0) {
        self.sliderScore.hidden = NO;
        self.labelSliderText.hidden = NO;
    }
    
    
//    NSString *text=@" ";
//    if ([self.game.matchedCards  count] > 0)
//    {
//        text = [text stringByAppendingString:[self.game.matchedCards componentsJoinedByString:@" "]];
//        
//        if ([ self.game.matchedCards count ] == [self matchedCountOfCards]){
//            
//            if (self.game.lastScorelabel < 0) {
//                text = [text stringByAppendingString:[NSString stringWithFormat:@"✘ %ld penalty",(long)self.game.lastScorelabel]];
//            } else {
//                text = [text stringByAppendingString:[NSString stringWithFormat:@"✔ +%ld bonus",(long)self.game.lastScorelabel]];
//            }
//        } else text =[self textForSingleCard];
//        
//        [self.changeScore addObject:text];
//        
//    } else text = @"Play game!";
//    
//    self.labelSliderText.text = text;
//             
//    
//    [self.changeScore addObject:text];
    
}
 

//- (NSString *)textForSingleCard
//{
//    Card *card = [self.game.matchedCards lastObject];
//    return [NSString stringWithFormat:@" %@ flipped %@",card,(card.isChosen) ? @"up!" : @"back!"];
//}


- (IBAction)touchCardButton:(UIButton *)sender{
    
    NSInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    self.flipCount ++;
    [self updateUI];

}



-(void)updateUI{
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
         self.scoreLabel.text = [NSString stringWithFormat:@"Score : %ld", (long)self.game.score];
    }
    
    [self updateHistory];
//    
//    [self updateLabelResult];
//    self.sliderScore.maximumValue = self.flipCount;
//    [self.sliderScore setValue:(float)self.flipCount animated:YES];
}

-(NSString*)titleForCard:(Card *)card{
    
    return card.isChosen ? card.contents:@" ";
   
}

-(UIImage *)backgroundForCard:(Card*)card{
   
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)newGame:(id)sender {
    self.game = nil;
    self.changeScore = nil;
    self.flipCount = 0;
    self.sliderScore.hidden = YES;
    self.labelSliderText.hidden = YES;
    
    [self updateUI];
    
}

             
- (IBAction)segmentButton:(id)sender
{
    [self newGame:sender];
}

- (IBAction)sliderChange:(UISlider *)sender {
    
    int currentIndex = (int)self.sliderScore.value - 1;
    if (currentIndex < self.game.logs.count) {
        NSString *log = self.game.logs[currentIndex];
        self.labelSliderText.text = log;
    }
    
    
//    int selectedIndex = (int) sender.value;
//    if (selectedIndex < 0 || (selectedIndex > self.flipCount-1)) return;
//    self.labelSliderText.alpha = (selectedIndex < self.flipCount-1 ) ? 0.5 : 1.0;
//    NSString *text = [NSString stringWithFormat:@"%d:",(selectedIndex+1)];
//    self.labelSliderText.text = [text stringByAppendingString:[self.changeScore objectAtIndex:selectedIndex]];
    
    
     //self.labelSliderText.text = 1;
    
   // NSString *sliderValue = [NSString stringWithFormat:@"%f", self.sliderScore.value];
    
    
       // self.labelSliderText.text = sliderValue;
    
       // [self updateUI];

//   [_sliderScore setMinimumValue:0.0];
//   [_sliderScore setMaximumValue: self.game.score];
//    
    //  self.labelSliderText.text = [NSString stringWithFormat:@"%f", self.sliderScore.value];

}






@end
