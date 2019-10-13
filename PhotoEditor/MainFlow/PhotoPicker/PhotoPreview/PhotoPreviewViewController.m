//
//  PhotoPreviewViewController.m
//  PhotoEditor
//
//  Created by Марк on 13/10/2019.
//  Copyright © 2019 Agranat Mark. All rights reserved.
//

#import "PhotoPreviewViewController.h"
@import AVFoundation;

@interface PhotoPreviewViewController () <AVCapturePhotoCaptureDelegate>

@property (nonatomic) void (^imageObtainingCallback)(NSData *imageData);
@property (nonatomic) dispatch_queue_t captureQueue;
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCapturePhotoOutput *imageOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *imagePreviewLayer;

@end

@implementation PhotoPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captureQueue = dispatch_queue_create("com.PhotoEditor.CapterSessionQueue", DISPATCH_QUEUE_SERIAL);
    __weak __typeof(self) weakSelf = self;
    dispatch_async(self.captureQueue, ^{
        __typeof(self) self = weakSelf;
        [self configureCaptureSession];
    });
}

- (void)viewDidDisappear:(BOOL)animated {
    dispatch_async(self.captureQueue, ^{
        [self.captureSession stopRunning];
        self.captureSession = nil;
        self.captureQueue = nil;
    });
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.imagePreviewLayer.frame = self.view.bounds;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    if (UIDeviceOrientationIsPortrait(deviceOrientation) || UIDeviceOrientationIsLandscape(deviceOrientation)) {
        self.imagePreviewLayer.connection.videoOrientation = (AVCaptureVideoOrientation)deviceOrientation;
    }
}

#pragma mark - Public API

- (void)obtainImageData:(void (^)(NSData *imageData))callback {
    __weak __typeof(self) weakSelf = self;
    dispatch_async(self.captureQueue, ^{
        __typeof(self) self = weakSelf;
        self.imageObtainingCallback = callback;
        AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{ AVVideoCodecKey: AVVideoCodecTypeJPEG }];
        [self.imageOutput connectionWithMediaType:AVMediaTypeVideo].videoOrientation = self.imagePreviewLayer.connection.videoOrientation;
        [self.imageOutput capturePhotoWithSettings:settings delegate:self];
    });
}

#pragma mark - AVCapturePhotoCaptureDelegate

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error {
    NSData *imageData = photo.fileDataRepresentation ?: NSData.new;
    if (self.imageObtainingCallback)
        self.imageObtainingCallback(imageData);
}

#pragma mark - Private API

- (void)configureCaptureSession {
    [self.captureSession stopRunning];
    self.captureSession = AVCaptureSession.new;
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:nil];
    self.imageOutput = AVCapturePhotoOutput.new;
    [self.captureSession addInput:input];
    [self.captureSession addOutput:self.imageOutput];
    
    [self.imagePreviewLayer removeFromSuperlayer];
    self.imagePreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.imagePreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.captureSession startRunning];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view.layer addSublayer:self.imagePreviewLayer];
        self.imagePreviewLayer.frame = self.view.bounds;
    });
}

@end
