#import "PRHIconFromIPAExtractor.h"

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url,
	CFStringRef contentTypeUTI, CFDictionaryRef options
);

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url,
	CFStringRef contentTypeUTI, CFDictionaryRef options
) {
	PRHIconFromIPAExtractor *extractor = [[PRHIconFromIPAExtractor alloc] init];
	extractor.URL = (__bridge NSURL *)url;
	extractor.previewRequest = preview;
	return [extractor goOffInSearchOfAnIcon];
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview) {
	// Implement only if supported
}
