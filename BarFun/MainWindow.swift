//
// Created by David Whetstone on 1/22/16.
// Copyright (c) 2016 humblehacker. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let statusBarHeightWillChange = #selector(MainWindow.statusBarHeightWillChange(n:))
    
    static let dismiss = #selector(MainWindow.dismiss)
    static let toggleHeader = #selector(MainWindow.toggleHeader)
}


public
class MainWindow: UIWindow
{
    public static let instance = MainWindow(frame: UIScreen.main.bounds)

    private let headerWindow = UIWindow()
    private let headerVC = HeaderViewController(headerHeight: MainWindow.headerHeight)

    private class var compressedHeaderHeight: CGFloat { return UIApplication.shared.statusBarFrame.size.height }
    private class var expandedHeaderHeight: CGFloat { return compressedHeaderHeight + headerHeight }
    private var headerCompressed = true
    private static let headerHeight: CGFloat = 30.0

    public
    override init(frame: CGRect)
    {
        var f = frame
        f.origin.y = MainWindow.compressedHeaderHeight
        f.size.height = UIScreen.main.bounds.size.height - MainWindow.compressedHeaderHeight

        super.init(frame: f)

        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.0

        NotificationCenter.default.addObserver(self,
                selector: Selector.statusBarHeightWillChange,
                name: UIApplication.willChangeStatusBarFrameNotification,
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
        headerWindow.isHidden = false
    }

    func addGestures()
    {
        let doubleTap = UITapGestureRecognizer(target: self, action: Selector.dismiss)
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)

        let swipe = UISwipeGestureRecognizer(target: self, action: Selector.toggleHeader)
        swipe.direction = [.down, .up]
        self.addGestureRecognizer(swipe)
    }

    @objc func dismiss()
    {
        print("dismiss")

        rootViewController?.dismiss(animated: true, completion: nil)
    }

    @objc func toggleHeader()
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

        self.adjustWindows(headerHeight: MainWindow.expandedHeaderHeight)
        {
            self.headerCompressed = false
        }
    }

    func compressHeader()
    {
        print("compressHeader")

        self.adjustWindows(headerHeight: MainWindow.compressedHeaderHeight)
        {
            self.headerCompressed = true
        }
    }

    func adjustWindows(headerHeight: CGFloat, completion: @escaping ()->Void)
    {
        // Critical point: Both windows and the statusBar background of the header view controller
        // must be animated together. The duration matches the duration of the in-call status bar show/hide.

        UIView.animate(withDuration: 0.35)
        {
            let statusBarFrame = UIApplication.shared.statusBarFrame
            self.headerVC.adjustStatusBarHeight(height: statusBarFrame.size.height)

            self.headerWindow.frame.size.height = headerHeight
            self.headerWindow.layoutIfNeeded()

            self.frame.origin.y = headerHeight
            self.frame.size.height = UIScreen.main.bounds.size.height - headerHeight
            self.layoutIfNeeded()

            completion()
        }
    }

    @objc func statusBarHeightWillChange(n: NSNotification)
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
