//
//  SignInViewController.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/30.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import UIKit
import CKMnemonic

class SignInViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func startButtonTapped(_ sender: Any) {

        do {
            let language: CKMnemonicLanguageType = .english
            let mnemonic = try CKMnemonic.generateMnemonic(strength: 128, language: language)
            print(mnemonic)
            let seed = try CKMnemonic.deterministicSeedString(from: mnemonic, passphrase: "Test", language: language)
            print(seed)
        } catch {
            print(error)
        }

    }
}
