/**
 * titanium-document-viewer
 *
 * Created by Your Name
 * Copyright (c) 2021 Your Company. All rights reserved.
 */

#import "TiDocumentviewerModule.h"
#import <TitaniumKit/TitaniumKit.h>

@implementation TiDocumentviewerModule

#pragma mark Internal

- (id)moduleGUID
{
  return @"6f4ffdd2-14b7-477c-969c-8eb91bd24078";
}

- (NSString *)moduleId
{
  return @"ti.documentviewer";
}

- (QLPreviewController *)previewController
{
  if (_controller == nil) {
    _controller = [[QLPreviewController alloc] init];
    _controller.delegate = self;
    _controller.dataSource = self;
  }

  return _controller;
}

- (void)showDocumentViewer:(id)args
{
  ENSURE_SINGLE_ARG(args, NSDictionary);

  _documents = args[@"documents"];
  NSUInteger index = [TiUtils intValue:@"index" properties:args def:0];
  
  QLPreviewController *previewController = [self previewController];
  previewController.currentPreviewItemIndex = index;
  
  [[[[TiApp app] controller] topPresentedController] presentViewController:previewController
                                                                  animated:YES
                                                                completion:nil];
}

- (void)refresh:(id)unused
{
  [[self previewController] reloadData];
}

// MARK: QLPreviewControllerDataSource

- (void)previewControllerDidDismiss:(QLPreviewController *)controller
{
  _controller.delegate = nil;
  _controller = nil;
  _documents = @[];
}

// MARK: QLPreviewControllerDelegate

- (NSInteger)numberOfPreviewItemsInPreviewController:(nonnull QLPreviewController *)controller {
  return _documents.count;
}

- (nonnull id<QLPreviewItem>)previewController:(nonnull QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
  return [NSURL URLWithString:_documents[index]];
}

@end
