@interface PRHIconFromIPAExtractor : NSObject

@property QLThumbnailRequestRef thumbnailRequest;
@property QLPreviewRequestRef previewRequest;
@property NSURL *URL;

- (OSStatus) goOffInSearchOfAnIcon;

@end
