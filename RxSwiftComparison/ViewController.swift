//
//  ViewController.swift
//  RxSwiftComparison
//
//  Created by 小坂部泰成 on 2023/03/20.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    //Rx無しバージョン
    // 結果出力用ラベル
    @IBOutlet weak var outputLabel: UILabel!
    // 入力用テキストフィールド
    @IBOutlet weak var inputTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.addTarget(self,
                                 action: #selector(textFieldEditingChanged(sender:)),
                                 for: .editingChanged)
    }

    @objc private func textFieldEditingChanged(sender: UITextField) {
        outputLabel.text = sender.text
    }
    
}

