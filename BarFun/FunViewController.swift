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

        preferredContentSize = CGSizeMake(100, 100)

        addCenterView()
        addDismissButton()
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

    func addDismissButton()
    {
        let button = UIButton()
        button.setTitle("Dismiss", forState: .Normal)
        button.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)
        button.backgroundColor = UIColor.blueColor()
        view.addSubview(button)

        button.snp_makeConstraints
        {
            make in
            make.center.equalTo(self.view)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
    }

    func dismiss()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
