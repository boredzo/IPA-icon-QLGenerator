#import "PRHIconFromIPAExtractor.h"

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url,
	CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize
);

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail);

/* -----------------------------------------------------------------------------
    Generate a thumbnail for file

   This function's job is to create thumbnail for designated file as fast as possible
   ----------------------------------------------------------------------------- */

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url,
	CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize
) {
	PRHIconFromIPAExtractor *extractor = [[PRHIconFromIPAExtractor alloc] init];
	extractor.URL = (__bridge NSURL *)url;
	extractor.thumbnailRequest = thumbnail;
	return [extractor goOffInSearchOfAnIcon];
}

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail) {
	// Implement only if supported
}
