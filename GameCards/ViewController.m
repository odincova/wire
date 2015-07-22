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
@property (weak, nonatomic) IBOutlet UILabel *sliderMaxScore;


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

- (PlayGame *)game{
    
    if(!_game)
        _game =[[PlayGame alloc] initWithCardCount:[self.cardButtons count] usingPackCards:[self packCards] matchedCards:2];
    
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
    
    self.sliderScore.maximumValue = self.flipCount;
    [self.sliderScore setValue:(float)self.flipCount animated:YES];
   self.sliderMaxScore.text = [NSString stringWithFormat:@"%d",(int)ceilf(self.sliderScore.maximumValue)];
}

-(NSString*)titleForCard:(Card *)card{
    
    return card.isChosen ? card.contents:@"";
   
}

-(UIImage *)backgroundForCard:(Card*)card{
    
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)newGame:(id)sender {
    self.game = nil;
    self.changeScore = nil;
    self.flipCount = 0;
    [self updateUI];
    
}

- (IBAction)segmentButton:(id)sender {
    
    if (_segmentOfNumberOfCards.selectedSegmentIndex == 0) {
        
        
        self.game = nil;
        
        
        self.game =[[PlayGame alloc] initWithCardCount:[self.cardButtons count] usingPackCards:[self packCards] matchedCards:2];
        
        self.changeScore = nil;
        
        self.flipCount = 0;
        
        [self updateUI];
    }
    
    if (_segmentOfNumberOfCards.selectedSegmentIndex == 1) {
        
        
        self.game = nil;
        
        self.game =[[PlayGame alloc] initWithCardCount:[self.cardButtons count] usingPackCards:[self packCards] matchedCards:3];
        
        self.changeScore = nil;
        
        self.flipCount = 0;
        
        [self updateUI];
    }
    
}

- (IBAction)sliderChange:(UISlider *)sender {
    
    
    int selectedIndex = (int) sender.value;
    if (selectedIndex <0 || (selectedIndex > self.flipCount-1)) return;
    self.scoreLabel.alpha = (selectedIndex < self.flipCount-1 ) ? 0.5 : 1.0;
    NSString *text = [NSString stringWithFormat:@"%d:",(selectedIndex+1)];
    self.scoreLabel.text = [text stringByAppendingString:[self.changeScore objectAtIndex:selectedIndex]];
    
    
   // NSString *sliderValue = [NSString stringWithFormat:@"%f", self.sliderScore.value];
    
    
       // self.labelSliderText.text = sliderValue;
    
       // [self updateUI];

//   [_sliderScore setMinimumValue:0.0];
//   [_sliderScore setMaximumValue: self.game.score];
//    
    //  self.labelSliderText.text = [NSString stringWithFormat:@"%f", self.sliderScore.value];

}






@end
