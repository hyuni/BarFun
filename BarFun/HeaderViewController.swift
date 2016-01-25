//
// Created by David Whetstone on 1/23/16.
// Copyright (c) 2016 humblehacker. All rights reserved.
//

import UIKit

public
class HeaderViewController : UIViewController
{
    public var statusBarBackgroundColor: UIColor?
    {
        set { statusBarBackgroundView.backgroundColor = newValue }
        get { return statusBarBackgroundView.backgroundColor }
    }
    private let statusBarBackgroundView = UIView()
    private let headerHeight: CGFloat

    public
    init(headerHeight: CGFloat)
    {
        self.headerHeight = headerHeight
        super.init(nibName:nil, bundle: nil)
    }

    public
    required init(coder: NSCoder)
    {
        fatalError("not implemented")
    }

    public
    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellowColor()
        view.layer.borderColor = UIColor.blackColor().CGColor
        view.layer.borderWidth = 1.0

        addHeaderButton()
        addStatusBarBackgroundView()
    }

    public
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)

        // Critical point: On app start, UIApplication.statusBarFrame is {0,0,0,0},
        // so we get the height from the view controller's topLayoutGuide instead.
        adjustStatusBarHeight(self.topLayoutGuide.length)
    }

    public
    func adjustStatusBarHeight(height: CGFloat)
    {
        statusBarBackgroundView.snp_updateConstraints
        {
            make in
            make.height.equalTo(height)
        }
        statusBarBackgroundView.layoutIfNeeded()
    }

    private
    func addStatusBarBackgroundView()
    {
        statusBarBackgroundView.backgroundColor = UIColor.whiteColor()

        view.addSubview(statusBarBackgroundView)

        let statusBarFrame = UIApplication.sharedApplication().statusBarFrame
        statusBarBackgroundView.snp_makeConstraints
        {
            make in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(statusBarFrame.size.height)
        }
    }

    private
    func addHeaderButton()
    {
        let button = UIButton()
        button.setTitle("Header", forState: .Normal)
        button.addTarget(self, action: "headerTouched", forControlEvents: .TouchUpInside)
        button.backgroundColor = UIColor.magentaColor()
        view.addSubview(button)

        button.snp_makeConstraints
        {
            make in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(headerHeight)
        }
    }

    @objc
    private
    func headerTouched()
    {
        print("header touched")

        // Critical point: view controllers like alerts should be presented from MainWindow's
        // rootViewController.  They'll be pretty squashed if presented in the header.
        let alert = UIAlertController(title: "Alert", message: "Woot!", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        MainWindow.instance.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }

    public
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return .LightContent
    }
}
