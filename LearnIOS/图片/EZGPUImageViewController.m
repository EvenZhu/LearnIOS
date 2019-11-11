//
//  EZGPUImageViewController.m
//  LearnIOS
//
//  Created by Even on 2019/7/12.
//  Copyright © 2019 Even. All rights reserved.
//

#import "EZGPUImageViewController.h"
#import <GPUImage.h>

@interface EZGPUImageViewController ()

@end

@implementation EZGPUImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showGPUImage];
}

- (void)showGPUImage {
    UIImage * image = [UIImage imageNamed:@"dog"];
    
    UIImageView *contentImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    contentImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:contentImage];
    
    GPUImagePicture *sourcePicture = [[GPUImagePicture alloc] initWithImage:image];
    
    //    GPUImageView *imageView = [[GPUImageView alloc] initWithFrame:contentImage.frame];
    //    [contentImage addSubview:imageView];
    
    GPUImageGammaFilter *fitler = [[GPUImageGammaFilter alloc] init];
    [sourcePicture addTarget:fitler];
    
    [sourcePicture processImage];
    [fitler useNextFrameForImageCapture];
    
    image = [fitler imageFromCurrentFramebuffer];
    
    contentImage.image = image;
}

@end
