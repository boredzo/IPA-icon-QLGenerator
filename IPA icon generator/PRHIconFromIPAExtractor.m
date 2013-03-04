#import "PRHIconFromIPAExtractor.h"

@interface PRHIconFromIPAExtractor ()
- (bool) allRequestsAreCanceled;
@end

@implementation PRHIconFromIPAExtractor

- (OSStatus) goOffInSearchOfAnIcon {
	NSString *pathToIPA = self.URL.path;

	NSUInteger artworkLength = [self lengthOfArtworkFromIPAAtPath:pathToIPA];
	if (artworkLength == 0)
		return eofErr;

	if (self.allRequestsAreCanceled)
		return userCanceledErr;

	NSTask *unzip = [[NSTask alloc] init];
	unzip.launchPath = @"/usr/bin/unzip";
	unzip.arguments = @[ @"-p", pathToIPA, @"iTunesArtwork" ];

	NSPipe *stdoutPipe = [NSPipe pipe];
	unzip.standardOutput = stdoutPipe;

	[unzip launch];

	NSFileHandle *handleForReading = stdoutPipe.fileHandleForReading;
	NSData *stdoutData = [handleForReading readDataOfLength:artworkLength];

	int status = 0;
	waitpid(unzip.processIdentifier, &status, /*flags*/ 0);

	if (self.previewRequest) {
		QLPreviewRequestSetDataRepresentation(self.previewRequest, (__bridge CFDataRef)stdoutData, kUTTypeImage, /*properties*/ NULL);
	}
	if (self.thumbnailRequest) {
		QLThumbnailRequestSetImageWithData(self.thumbnailRequest, (__bridge CFDataRef)stdoutData, /*properties*/ NULL);
	}

	return noErr;
}

- (NSUInteger) lengthOfArtworkFromIPAAtPath:(NSString *)pathToIPA {
	NSTask *unzip = [[NSTask alloc] init];
	unzip.launchPath = @"/usr/bin/unzip";
	//Example output (including leading whitespace):
	//    16803  12-03-08 04:44   iTunesArtwork
	unzip.arguments = @[ @"-qqql", pathToIPA, @"iTunesArtwork" ];

	NSPipe *stdoutPipe = [NSPipe pipe];
	unzip.standardOutput = stdoutPipe;
	NSFileHandle *handleForReading = stdoutPipe.fileHandleForReading;

	[unzip launch];

	NSData *stdoutData = [handleForReading readDataOfLength:20];
	[handleForReading closeFile];

	int status = 0;
	waitpid(unzip.processIdentifier, &status, /*flags*/ 0);

	unsigned long length = strtoul(stdoutData.bytes, NULL, 10);
	return length;
}

- (bool) allRequestsAreCanceled {
	QLPreviewRequestRef previewRequest = self.previewRequest;
	QLThumbnailRequestRef thumbnailRequest = self.thumbnailRequest;
	return ((!previewRequest) || QLPreviewRequestIsCancelled(previewRequest))
	    && ((!thumbnailRequest) || QLThumbnailRequestIsCancelled(thumbnailRequest));
}

@end
