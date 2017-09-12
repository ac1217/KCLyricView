//
//  ViewController.m
//  KCLyricView
//
//  Created by iMac on 2017/9/12.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ViewController.h"
#import "KCLyricView.h"
#import "KCPlayer.h"

@interface ViewController ()<KCLyricViewDataSource>
@property (nonatomic,strong) KCLyricView *lyricView;
@property (nonatomic,strong) KCPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.lyricView = [[KCLyricView alloc] init];
    self.lyricView.dataSource = self;
    self.lyricView.frame = CGRectMake(50, 200, 300, 150);
    [self.view addSubview:self.lyricView];
    
    [self.lyricView reloadData];
    
    
    self.player = [KCPlayer new];
    [self.player setURL:[NSURL URLWithString:@"http://fs.android2.kugou.com/29d5204045a26af408ef203a46e47baa/59b7b70a/G009/M02/09/13/qYYBAFUJNg2APIvvABASXwgDeoQ508.m4a"]];
    [self.player play];
    
    self.player.playerItemProgressDidChangeBlock = ^(float currentTime, float duration, float progress) {
        
        self.lyricView.currentTime = currentTime;
    };
    
}

- (NSString *)lyricContentWithLyricView:(KCLyricView *)lyricView
{
    
    NSString *content =  [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lyric.txt" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    
    return content;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    self.lyricView.currentTime = arc4random_uniform(100);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -KCLyricViewDataSource
- (NSInteger)numberOfRowsInLyricView:(KCLyricView *)lyricView
{
    return 5;
}


@end
