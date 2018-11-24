//
//  FunViewController.swift
//  BarFun
//
//  Created by David Whetstone on 1/11/16.
//  Copyright (c) 2016 humblehacker. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let presentVC = #selector(FunViewController.presentVC)
    static let dismissVC = #selector(FunViewController.dismissVC)
}


class FunViewController: UIViewController
{
    override func viewDidLoad()
    {
        title = "BarFun"

        view.backgroundColor = UIColor.red
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2.0

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Present", style: .plain, target: self, action: Selector.presentVC)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: Selector.dismissVC)

        addCenterView()
    }

    func addCenterView()
    {
        let centerView = UIView()
        centerView.backgroundColor = UIColor.orange
        view.addSubview(centerView)

        centerView.snp.makeConstraints
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

    @objc func dismissVC()
    {
        dismiss(animated: true, completion: nil)
    }
}
