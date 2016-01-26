# BarFun
*Experimental* attempt to use multiple UIWindows to manage a global message bar

To see it in action:
- swipe up/down to show/hide the header bar. 
- double tap to dismiss all presented view controllers
- tap the header to show an alert

## 64 Point Navigation Bar Workaround

This sample includes a workaround to item #4 from Jared Sinclair's [Wrestling with Status Bars and Navigation Bars on iOS 7](http://blog.jaredsinclair.com/post/61507315630/wrestling-with-status-bars-and-navigation-bars-on). 

> If the UINavigationController detects that the top of its view’s frame is visually contiguous with its UIWindow’s top, then it draws its navigation bar with a height of 64 points."

First, it's not actually true that the navigation bar is 64 points high.  It's still 44 points, but it is pushed down by 20 points to accommodate the status bar.

But in this sample, the `UIWindow` in question is placed below the status bar, so the adjusted navigation bar makes no sense.  The rule above should have been:

> If the UINavigationController detects that the top of its view’s frame is visually contiguous with its UIWindow’s top _**and the UIWindow is at the top of the screen**_, then it draws its navigation bar with a height of 64 points."

So to work around this issue, we check that case: if the window is not at the top of the screen, we prevent the navigation bar from being pushed down.

See [UINavigationBar+HeightFix.m](BarFun/UINavigationBar+HeightFix.m).
