/**
 * titanium-document-viewer
 *
 * Created by Your Name
 * Copyright (c) 2021 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import <QuickLook/QuickLook.h>

@interface TiDocumentviewerModule : TiModule<QLPreviewControllerDataSource, QLPreviewControllerDelegate> {
  QLPreviewController *_controller;
  NSArray<NSString *> *_documents;
}

- (void)showDocumentViewer:(id)args;

- (void)refresh:(id)unused;

@end
