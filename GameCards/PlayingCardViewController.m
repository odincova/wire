//
//  PlayingCardViewController.m
//  GameCards
//
//  Created by Juliya on 20.07.15.
//  Copyright (c) 2015 Juliya Odincova. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayCardPack.h"

@interface PlayingCardViewController ()


@end

@implementation PlayingCardViewController



-(PackCards *)packCards{
    
    return [[PlayCardPack alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
