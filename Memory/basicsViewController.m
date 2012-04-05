//
//  basicsViewController.m
//  Memory
//
//  Created by Michael Cornell on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "basicsViewController.h"

@implementation basicsViewController
@synthesize winnerDisp;
@synthesize imageArray;
@synthesize cardCompare;
@synthesize tryCount;
@synthesize winCheck;
@synthesize card1;
@synthesize card2;

- (IBAction)buttonClicked:(UIButton*)sender{
    [sender setImage:[imageArray objectAtIndex:sender.tag-1] forState:UIControlStateNormal];
    if (cardCompare==NO){
        //first card selected
        card1=sender;
        cardCompare=YES;
        }
    else if (cardCompare==YES && sender!=card1){
        //second card selected
        card2=sender;
        [self compareCards];
    }
}

-(void)compareCards{
    tryCount++;
    if(card1.tag==card2.tag){
        //match
        card1.enabled=NO;
        [card1 setImage:[UIImage imageNamed:@"cardcheck.png"] forState:UIControlStateDisabled];
        card2.enabled=NO;
        [card2 setImage:[UIImage imageNamed:@"cardcheck.png"] forState:UIControlStateDisabled];
        winCheck++;
        if(winCheck==8)winnerDisp.text=[NSString stringWithFormat:@"Winner! After %d guesses.",tryCount];
        else winnerDisp.text=[NSString stringWithFormat:@"Guesses: %d",tryCount];
        cardCompare=NO;
        card1=nil;
        card2=nil;
    }
    else {
        //not a match
        for (int place=0;place<16;place++){
            if ([cardArray[place] currentImage]!=[UIImage imageNamed:@"cardcheck.png"]){
                cardArray[place].userInteractionEnabled=NO;}
            //disable everything which isnt already correct
            //wait 1 second
            //reenable uncorrect/unused cards
            //reset img/enabled on unused cards
        }
        winnerDisp.text=@"Incorrect";
        [self performSelector:@selector(delayReset) withObject:(nil) afterDelay:0.75]; 
    }
}

-(void)delayReset{
    for (int place=0;place<16;place++)
    {
        if ([cardArray[place] currentImage]!=[UIImage imageNamed:@"cardcheck.png"]){
            cardArray[place].userInteractionEnabled=YES;}
    }
    [card1 setImage:[UIImage imageNamed:@"cardback.png"] forState:UIControlStateNormal];
    [card2 setImage:[UIImage imageNamed:@"cardback.png"] forState:UIControlStateNormal];
    winnerDisp.text=[NSString stringWithFormat:@"Guesses: %d",tryCount];
    cardCompare=NO;
    
}

-(void)newGame{
    winCheck=0;
    tryCount=0;
    cardCompare=NO;
    card1=nil;
    card2=nil;
    winnerDisp.text=nil;
    for (int a=0;a<16;a++){
        cardArray[a].enabled=YES;
        [cardArray[a] setImage:[UIImage imageNamed:@"cardback.png"] forState:UIControlStateNormal];
        cardArray[a].tag=0;
    }
//assign random pairs tag values 1 through 8
    int  b = (arc4random()%16);    
    for (int x=1; x<9; x++) 
    {
        NSLog(@"NEXT CARD PAIR-----%d",x);
        while (cardArray[b].tag != 0)
        {
            b = (arc4random()%16);
        }
        cardArray[b].tag=x;
        NSLog(@"Card Number: %d", b);
        b = (arc4random()%16);
        while (cardArray[b].tag != 0)
        {
            b = (arc4random()%16);
        }
        cardArray[b].tag=x;
        NSLog(@"Paired Card Number: %d", b);
        NSLog(@"Pair's Tag: %d", cardArray[b].tag);
    } 
}

- (IBAction)newGamePress:(id)sender {
    [self newGame];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        imageArray= [NSArray arrayWithObjects:
                 [UIImage imageNamed:@"cardfrontpear.png"],
                 [UIImage imageNamed:@"cardfrontorange.png"],
                 [UIImage imageNamed:@"cardfrontcherry.png"],
                 [UIImage imageNamed:@"cardfrontplum.png"],
                 [UIImage imageNamed:@"cardfrontlemon.png"],
                 [UIImage imageNamed:@"cardfrontstrawberry.png"],
                 [UIImage imageNamed:@"cardfrontbanana.png"],
                 [UIImage imageNamed:@"cardfrontapple.png"],
                 nil];
//generating buttons
    int yAxis = 15;
    for (int x=0; x<16; x=x+4) 
    {
        int xAxis=25;
        for (int y=0; y<4; y++) 
        {
            int indexSpot = x+y;
            cardArray[indexSpot] = [[UIButton alloc]init];
            cardArray[indexSpot]= [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [cardArray[indexSpot] addTarget:self action:@selector (buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cardArray[indexSpot] setImage:[UIImage imageNamed:@"cardback.png"] forState:UIControlStateNormal];
            cardArray[indexSpot].frame = CGRectMake(xAxis, yAxis, 60.0, 90.0);
            [self.view addSubview:cardArray[indexSpot]];
            xAxis=xAxis+70;
                    }
        yAxis=yAxis+100;
    }
    [self newGame];
}
-(void)viewDidUnload
{
    card1=nil;
    card2=nil;
    
    for (int c=0;c<16; c++) {
        cardArray[c]=nil;
    }
    
    [super viewDidUnload];
}
@end
