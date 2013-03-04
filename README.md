# IPA icon Quick Look generator

This is a Quick Look generator plug-in for OS X to enable QL previews and thumbnails of IPA (iPhone/iPad app) files.

![What a Finder window full of IPAs looks like with this plug-in installed.](http://boredzo.org/ipa-qlgenerator/IPAQLGen-Finder.png)
![What a Dock “grid” pop-up full of IPAs looks like with this plug-in installed.](http://boredzo.org/ipa-qlgenerator/IPAQLGen-DockPopUp.png)

This generator uses the IPA's iTunesArtwork file as the preview/thumbnail data, with the effect that the file's preview/thumbnail is the iOS application's icon, rather than the generic iTunes IPA icon.

### Installation

First, open the Home Library folder. To do this, open the Finder's Go menu, hold down the Option key, and choose Library.

Next, open the QuickLook folder within the Library folder. If there isn't one already, create it.

Finally, put the .qlgenerator plug-in bundle into Home/Library/QuickLook.

I don't know whether you have to kick Quick Look to get it to notice the plug-in, or whether it will do so automatically. If you're impatient, run `qlmanage -r` to kick Quick Look into looking for new plug-ins.
