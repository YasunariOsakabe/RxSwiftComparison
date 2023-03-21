//
//  RxSwiftViewController.swift
//  RxSwiftComparison
//
//  Created by 小坂部泰成 on 2023/03/20.
//

import Foundation
import RxSwift
import RxCocoa

class RxSwiftViewController: UIViewController {
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    private let maxLength: Int = 10
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.rx.text.subscribe(onNext: { text in
            if let text = text, text.count >= self.maxLength {
                self.inputTextField.text = text.prefix(self.maxLength).description
            }
            //inputTextFieldの値がoutputLabelに反映されるように設定
            self.outputLabel.text = self.inputTextField.text
        })
        //購読解除
        .disposed(by: disposeBag)
    }

}
