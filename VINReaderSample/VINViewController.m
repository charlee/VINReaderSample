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

@implementation VINViewController

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

- (IBAction)scanButtonTapped {
  // ADD: present a barcode reader that scans from the camera feed
  ZBarReaderViewController *reader = [ZBarReaderViewController new];
  reader.readerDelegate = self;
  reader.supportedOrientationsMask = ZBarOrientationMaskAll;
  
  ZBarImageScanner *scanner = reader.scanner;
  // TODO: (optional) additional reader configuration here
  
  // EXAMPLE: disable rarely used I2/5 to improve performance
  [scanner setSymbology: ZBAR_I25
                 config: ZBAR_CFG_ENABLE
                     to: 0];
  
  // present and release the controller
  [self presentModalViewController: reader
                          animated: YES];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
  // ADD: get the decode results
  id<NSFastEnumeration> results =
  [info objectForKey: ZBarReaderControllerResults];
  ZBarSymbol *symbol = nil;
  for(symbol in results)
    // EXAMPLE: just grab the first barcode
    break;
  
  // EXAMPLE: do something useful with the barcode data
  self.resultText.text = symbol.data;
  
  // EXAMPLE: do something useful with the barcode image
  self.resultImage.image =
  [info objectForKey: UIImagePickerControllerOriginalImage];
  
  // ADD: dismiss the controller (NB dismiss from the *reader*!)
  [reader dismissModalViewControllerAnimated: YES];
}

@end
