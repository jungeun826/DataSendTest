//
//  ViewController.m
//  DataSendTest
//
//  Created by SDT-1 on 2014. 1. 15..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#define IMAGE_URL @"http://upload.wikimedia.org/wikipedia/commons/4/4d/Klimt_-_Der_Kuss.jpeg"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController{
    NSMutableData *buffer;
}
- (IBAction)doSync:(id)sender {
    self.imageView.image = nil;
    NSLog(@"Starting Image Download");
    NSURL *url = [NSURL URLWithString:IMAGE_URL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.imageView.image = [UIImage imageWithData:data];
    NSLog(@"Finished Image Download");
}
- (IBAction)doAsync:(id)sender {
    self.imageView.image = nil;
    NSLog(@"Start Image Dowload Request");
    NSURL *url = [NSURL URLWithString:IMAGE_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];

    NSLog(@"Finished Image Download Request");
}
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    buffer = [[NSMutableData alloc]init];
}
-(void)connection:(NSURLConnection *)connectin didReceiveData:(NSData *)data{
    NSLog(@"Receiving : %d", (int)[data length]);
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    self.imageView.image = [UIImage imageWithData:buffer];
    NSLog(@"Finished Image Download");
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Error : %@",[error localizedDescription]);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
