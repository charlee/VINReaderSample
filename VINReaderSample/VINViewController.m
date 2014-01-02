//
//  VINViewController.m
//  VINReaderSample
//
//  Created by charlee on 12/27/2013.
//  Copyright (c) 2013 envisageny.com. All rights reserved.
//

#import "VINViewController.h"

@interface VINViewController ()

@end

@implementation VINViewController {
  ZBarReaderViewController *reader;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
}

- (void)viewDidAppear:(BOOL)animated {
  
  reader = [ZBarReaderViewController new];
  reader.readerDelegate = self;
  reader.showsZBarControls = NO;
  reader.tracksSymbols = YES;
  reader.wantsFullScreenLayout = NO;
  
  reader.readerView.showsFPS = YES;
  reader.readerView.zoom = 1.0;
  
//  reader.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
  reader.supportedOrientationsMask = ZBarOrientationMask(UIInterfaceOrientationLandscapeLeft);
  reader.scanCrop = CGRectMake(0, 0.25, 1, 0.25);
  
  ZBarImageScanner *scanner = reader.scanner;
  [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
  [scanner setSymbology:0 config:ZBAR_CFG_X_DENSITY to:1];
  [scanner setSymbology:0 config:ZBAR_CFG_Y_DENSITY to:1];
  
  
  reader.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
  
    reader.view.frame = CGRectMake(0, self.view.frame.size.width / 3, self.view.frame.size.height, self.view.frame.size.width / 3);
  [self.view addSubview:reader.view];
  
  NSLog(@"scanner showed.");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) imagePickerController: (UIImagePickerController*)reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
  // ADD: get the decode results
  id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
  ZBarSymbol *symbol = nil;
  for(symbol in results)
    // EXAMPLE: just grab the first barcode
    break;
  
  // EXAMPLE: do something useful with the barcode data
  self.resultText.text = symbol.data;
  
  // ADD: dismiss the controller (NB dismiss from the *reader*!)
//  [reader dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearButtonTapped {
  self.resultText.text = @"";
}

@end
