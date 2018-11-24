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
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        self.alertWindow = alertWindow

        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(self, animated: animated, completion: nil)
    }

    func show()
    {
        show(animated: true)
    }

    func dismiss()
    {
        self.alertWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

