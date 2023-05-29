figuring out which keys to remap and how was a real pain

https://usb.org/sites/default/files/hut1_4.pdf
https://www.reddit.com/r/MacOS/comments/jy5ry8/comment/gtlsbhw/?context=8&depth=9
https://hidutil-generator.netlify.app/
https://developer.apple.com/library/archive/technotes/tn2450/_index.html
https://apple.stackexchange.com/questions/408359/how-can-i-adjust-keyboard-backlight-on-the-new-m1-macbook-air
https://www.drakware.dev/blog/005-mackeys/
https://opensource.apple.com/source/IOHIDFamily/IOHIDFamily-870.60.4/IOHIDFamily/AppleHIDUsageTables.h.auto.html

this actually solved it for me. key being padding the value for f3 to 64
bits, but it's not clear that it's moving msb and lsb away from each
other. really that makes sense, but it's definitely not obvious to me,
since they're listed as 0xff01 and 0x10 or whatever.
https://www.nanoant.com/mac/macos-function-key-remapping-with-hidutil

