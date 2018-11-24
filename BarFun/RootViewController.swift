//
//  RootViewController.swift
//  BarFun
//
//  Created by David Whetstone on 1/11/16.
//  Copyright © 2016 humblehacker. All rights reserved.
//

import UIKit
import SnapKit

fileprivate extension Selector {
    static let presentVC = #selector(RootViewController.presentVC)
}


class RootViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        title = "Root View Controller"

        navigationController?.navigationBar.layer.borderColor = UIColor.cyan.cgColor
        navigationController?.navigationBar.layer.borderWidth = 1.0

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Present", style: .plain, target: self, action: Selector.presentVC)

        addInnerView()
        print("rootView: \(view)")
    }

    func addInnerView()
    {
        let innerView = UIView()
        innerView.backgroundColor = UIColor.lightGray
        view.addSubview(innerView)

        innerView.snp.makeConstraints
        {
            make in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }

    @objc func presentVC()
    {
        let nc = UINavigationController(rootViewController: FunViewController())
        present(nc, animated: true, completion: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
}

