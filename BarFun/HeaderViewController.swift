//
// Created by David Whetstone on 1/23/16.
// Copyright (c) 2016 humblehacker. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let headerTouched = #selector(HeaderViewController.headerTouched)
}


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

        view.backgroundColor = UIColor.yellow
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1.0

        addHeaderButton()
        addStatusBarBackgroundView()
    }

    public
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)

        // Critical point: On app start, UIApplication.statusBarFrame is {0,0,0,0},
        // so we get the height from the view controller's topLayoutGuide instead.
        adjustStatusBarHeight(height: self.topLayoutGuide.length)
    }

    public
    func adjustStatusBarHeight(height: CGFloat)
    {
        statusBarBackgroundView.snp.updateConstraints
        {
            make in
            make.height.equalTo(height)
        }
        statusBarBackgroundView.layoutIfNeeded()
    }

    private
    func addStatusBarBackgroundView()
    {
        statusBarBackgroundView.backgroundColor = UIColor.white

        view.addSubview(statusBarBackgroundView)

        let statusBarFrame = UIApplication.shared.statusBarFrame
        statusBarBackgroundView.snp.makeConstraints
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
        button.setTitle("Header", for: .normal)
        button.addTarget(self, action: Selector.headerTouched, for: .touchUpInside)
        button.backgroundColor = UIColor.magenta
        view.addSubview(button)

        button.snp.makeConstraints
        {
            make in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(headerHeight)
        }
    }

    @objc
    public
    func headerTouched()
    {
        print("header touched")

        // Critical point: view controllers like alerts should not be presented from any view controller
        // attached to the HeaderWindow, otherwise the alert will be squashed into the window.
        // To avoid this, we present the alert from it's own window (see UIAlertController.show()).
        let alert = UIAlertController(title: "Alert", message: "Woot!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alert.show()
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
}
