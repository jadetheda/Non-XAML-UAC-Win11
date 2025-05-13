
# Miss the old UAC dialog with native window stylings? You're in the right place!
## Full credit goes to [@aubymori](https://github.com/aubymori) and [@ephemeralViolette](https://github.com/ephemeralViolette/)

### Win10 Version: https://aubymori.github.io/#!/files/classic-uac
![themedOldUAC](https://github.com/user-attachments/assets/70e1ee9f-c676-4034-82ab-d890a117aae9)

#### Beware! The current version doesn't seem to support passkeys.
While I have not verified that this tool is for certain the cause as of yet, it does seem to be.

This isn't really mine but 
- The latest official version presumably works on Windows 10, but is broken on Windows 11 (only throws a bad handle error)
  
- The old version linked at https://web.archive.org/web/20240223150635/https://winclassic.net/thread/1778/non-xaml-uac-back
  - used an expired Discord attachment link, requiring you to send the link in a server to refresh it,
  - doesn't have the automatic installer the new version has.
 
So, I just replaced the resources in the new version with those from the old version (most importantly the compatible consent.exe), letting you easily download and install this on Windows 11, even 24H2!

### P.S. 
GitHub 'fixed' the line endings on some of these dlls, and while that shouldn't affect anything, I have not independently verified this.
