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
    @IBOutlet weak var remainTextCountLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    private let maxLength: Int = 10
    private let minimumTextLength: Int = 6
    private let normalTextColor: UIColor = .black
    private let limitedTextColor: UIColor = .red

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setBackgroundImage(UIImage(ciImage: .gray), for: .disabled)

        setRemainCount(text: inputTextField.text)
        changeTextColorBy(limit: maxLength, textField: inputTextField)
        changeButtonEnableBy(length: minimumTextLength, textField: inputTextField)

        inputTextField.delegate = self
        inputTextField.addTarget(self,
                                 action: #selector(textFieldEditingChanged(sender:)),
                                 for: .editingChanged)
    }

    @objc private func textFieldEditingChanged(sender: UITextField) {
        if let text = sender.text, text.count > maxLength {
            sender.text = text.prefix(maxLength).description
            
        }
        outputLabel.text = sender.text
        //remainTextCountLabelに入力可能文字数を表示
        remainTextCountLabel.text = "あと\(maxLength - sender.text!.count)文字入力できます"
                
        setRemainCount(text: sender.text)
        changeTextColorBy(limit: maxLength, textField: inputTextField)
        changeButtonEnableBy(length: minimumTextLength, textField: inputTextField)

    }
    
    
    @IBAction func didTapButton(_ sender: UIButton) {
        //NextViewControllerに画面遷移
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NextViewController") as! NextViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    
    /// あと何文字入力できるかを表示する
    private func setRemainCount(text: String?) {
        let text = text ?? ""
        let remainCount = maxLength - text.count
        remainTextCountLabel.text = "あと\(remainCount)文字入力できます"
    }
    
    //入力文字数が一定以上になった時文字色を変更
    private func changeTextColorBy(limit: Int, textField: UITextField) {
        guard let text = textField.text else { return }

        textField.textColor = (text.count >= limit) ? limitedTextColor : normalTextColor
    }
    /// 入力されている文字数に応じてボタンの押下制御を行う
    private func changeButtonEnableBy(length: Int, textField: UITextField) {
        if let text = textField.text, text.count >= length {
            button.isEnabled = true
        } else {
            button.isEnabled = false
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

