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
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!

    private let maxLength: Int = 10

    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.delegate = self
        inputTextField.addTarget(self,
                                 action: #selector(textFieldEditingChanged(sender:)),
                                 for: .editingChanged)
    }
    //UITextField内の値が更新されるたびに実行される
    @objc private func textFieldEditingChanged(sender: UITextField) {
        if let text = sender.text, text.count > maxLength {
            sender.text = text.prefix(maxLength).description
            //descriptionでInt型からString型に変換
        }
        outputLabel.text = sender.text
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

