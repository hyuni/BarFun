//
//  FunViewController.swift
//  BarFun
//
//  Created by David Whetstone on 1/11/16.
//  Copyright (c) 2016 humblehacker. All rights reserved.
//

import UIKit

class FunViewController: UIViewController
{
    override func viewDidLoad()
    {
        title = "BarFun"

        view.backgroundColor = UIColor.redColor()
        view.layer.borderColor = UIColor.blackColor().CGColor
        view.layer.borderWidth = 2.0

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Present", style: .Plain, target: self, action: "present")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .Plain, target: self, action: "dismiss")

        addCenterView()
    }

    func addCenterView()
    {
        let centerView = UIView()
        centerView.backgroundColor = UIColor.orangeColor()
        view.addSubview(centerView)

        centerView.snp_makeConstraints
        {
            make in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(10, 10, 10, 10))
        }
    }

    func present()
    {
        let nc = UINavigationController(rootViewController: FunViewController())
        presentViewController(nc, animated: true, completion: nil)
    }

    func dismiss()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
