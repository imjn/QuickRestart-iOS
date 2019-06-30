//
//  SignInViewController.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import UIKit
import CKMnemonic
import IQKeyboardManagerSwift

class SignInViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.shared.enable = true
    }

    @IBAction func startButtonTapped(_ sender: Any) {

        guard let text = textField.text else { return }
        SignInService().signIn(username: text) { success in
            if success {
                UIStoryboard.moveToAnotherStoryboard(for: .Main, currentView: self)
            }
        }

    }
}
