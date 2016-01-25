//
// Created by David Whetstone on 1/22/16.
// Copyright (c) 2016 humblehacker. All rights reserved.
//

import UIKit

public
class MainWindow: UIWindow
{
    public static let instance = MainWindow(frame: UIScreen.mainScreen().bounds)

    private let headerWindow = UIWindow()
    private let headerVC = HeaderViewController(headerHeight: MainWindow.headerHeight)

    private class var compressedHeaderHeight: CGFloat { return UIApplication.sharedApplication().statusBarFrame.size.height }
    private class var expandedHeaderHeight: CGFloat { return compressedHeaderHeight + headerHeight }
    private var headerCompressed = true
    private static let headerHeight: CGFloat = 30.0

    public
    override init(frame: CGRect)
    {
        var f = frame
        f.origin.y = MainWindow.compressedHeaderHeight
        f.size.height = UIScreen.mainScreen().bounds.size.height - MainWindow.compressedHeaderHeight

        super.init(frame: f)

        self.layer.borderColor = UIColor.redColor().CGColor
        self.layer.borderWidth = 1.0

        NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "statusBarHeightWillChange:",
                name: UIApplicationWillChangeStatusBarFrameNotification,
                object: nil)

        addHeaderWindow()
        addGestures()
    }

    public
    required init(coder: NSCoder)
    {
        fatalError("not implemented")
    }

    func addHeaderWindow()
    {
        headerWindow.rootViewController = headerVC
        headerWindow.frame.origin.y = 0
        headerWindow.frame.size.height = MainWindow.compressedHeaderHeight
        headerWindow.hidden = false
    }

    func addGestures()
    {
        let doubleTap = UITapGestureRecognizer(target: self, action: "dismiss")
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)

        let tap = UITapGestureRecognizer(target: self, action: "present")
        tap.numberOfTapsRequired = 1
        tap.requireGestureRecognizerToFail(doubleTap)
        self.addGestureRecognizer(tap)

        let swipe = UISwipeGestureRecognizer(target: self, action: "toggleHeader")
        swipe.direction = [.Down, .Up]
        self.addGestureRecognizer(swipe)
    }

    func present()
    {
        print("present")

        let nc = UINavigationController(rootViewController: FunViewController())

        guard let rootVC = rootViewController else { return }

        if let presentedVC = rootVC.presentedViewController
        {
            presentedVC.presentViewController(nc, animated: true, completion: nil)
        }
        else
        {
            rootVC.presentViewController(nc, animated: true, completion: nil)
        }
    }

    func dismiss()
    {
        print("dismiss")

        rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    func toggleHeader()
    {
        if headerCompressed
        {
            expandHeader()
        }
        else
        {
            compressHeader()
        }
    }

    func expandHeader()
    {
        print("showHeader")

        self.adjustWindows(MainWindow.expandedHeaderHeight)
        {
            self.headerCompressed = false
        }
    }

    func compressHeader()
    {
        print("compressHeader")

        self.adjustWindows(MainWindow.compressedHeaderHeight)
        {
            self.headerCompressed = true
        }
    }

    func adjustWindows(headerHeight: CGFloat, completion: (Void)->Void)
    {
        // Critical point: Both windows and the statusBar background of the header view controller
        // must be animated together. The duration matches the duration of the in-call status bar show/hide.

        UIView.animateWithDuration(0.35)
        {
            let statusBarFrame = UIApplication.sharedApplication().statusBarFrame
            self.headerVC.adjustStatusBarHeight(statusBarFrame.size.height)

            self.headerWindow.frame.size.height = headerHeight
            self.headerWindow.layoutIfNeeded()

            self.frame.origin.y = headerHeight
            self.frame.size.height = UIScreen.mainScreen().bounds.size.height - headerHeight
            self.layoutIfNeeded()

            completion()
        }
    }

    func statusBarHeightWillChange(n: NSNotification)
    {
        // Critical point: We call the header adjustment method for the current header state to ensure
        // our header sizes animate smoothly with the change in status bar height.

        if headerCompressed
        {
            compressHeader()
        }
        else
        {
            expandHeader()
        }
    }
}
