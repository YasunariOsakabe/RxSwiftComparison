//
//  RxSwiftViewController.swift
//  RxSwiftComparison
//
//  Created by 小坂部泰成 on 2023/03/20.
//

import Foundation
import RxSwift
import RxCocoa

class RxViewController: UIViewController {
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var remainTextCountLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    private let maxLength: Int = 10
    private let minimumTextLength: Int = 6
    private let normalTextColor: UIColor = .black
    private let limitedTextColor: UIColor = .red
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        button.setBackgroundImage(UIImage(ciImage: .gray), for: .disabled)

        // 入力内容変更時
        inputTextField.rx.text.subscribe(onNext: { text in
            // 文字列長によってテキストカラーを変える
            if let text = text, text.count >= self.maxLength {
                self.inputTextField.text = text.prefix(self.maxLength).description
                self.inputTextField.textColor = self.limitedTextColor
                print("入力文字数上限のため文字色を赤に変更します。")
            } else {
                self.inputTextField.textColor = self.normalTextColor
            }
            // ラベルに入力された文字列を反映する
            self.outputLabel.text = self.inputTextField.text

            // 入力されている文字数を取得
            let inputTextLength = self.inputTextField.text?.count ?? 0

            // あと何文字入力できるかを表示する
            let remainCount = self.maxLength - inputTextLength
            self.remainTextCountLabel.text = "あと\(remainCount)文字入力できます"

            // ボタンの押下制御
            self.button.isEnabled = (inputTextLength >= self.minimumTextLength)
        }).disposed(by: disposeBag)

        // ボタンタップ時
        button.rx.tap.subscribe(onNext: {
            if let nextViewController = UIStoryboard(name: "NextViewController", bundle: nil)
                .instantiateInitialViewController() as? NextViewController {
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }).disposed(by: disposeBag)
    }

}
