//
// Created by David Whetstone on 1/25/16.
// Copyright (c) 2016 humblehacker. All rights reserved.
//

import UIKit

extension UIAlertController
{
    private struct AssociatedKeys
    {
        static var AlertWindow = "humblehacker.alertcontroller.alertWindow"
    }

    private var alertWindow: UIWindow?
    {
        get
        {
            return objc_getAssociatedObject(self, &AssociatedKeys.AlertWindow) as? UIWindow
        }
        set
        {
            if let newValue = newValue
            {
                objc_setAssociatedObject(self, &AssociatedKeys.AlertWindow, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    func show(animated: Bool)
    {
        let alertWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.alertWindow = alertWindow

        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.presentViewController(self, animated: animated, completion: nil)
    }

    func show()
    {
        show(true)
    }

    func dismiss()
    {
        self.alertWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

