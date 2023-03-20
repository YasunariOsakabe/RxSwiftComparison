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
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.rx.text
            .bind(to: outputLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
