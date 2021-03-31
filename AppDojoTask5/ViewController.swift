//
//  ViewController.swift
//  AppDojoTask5
//
//  Created by Naoyuki Kan on 2021/03/28.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet private weak var leftTextField: UITextField!
	@IBOutlet private weak var rightTextField: UITextField!
	@IBOutlet private weak var resultLabel: UILabel!

	// 独自のエラー定義
	enum UserError: Error {
		case emptyLeftTextField
		case emptyRightTextField
		case divisionByZero

        var message: String {
            switch self {
            case .emptyLeftTextField:
                return "割られる数を入力してください"
            case .emptyRightTextField:
                return "割る数を入力してください"
            case .divisionByZero:
                return "割る数には0を入力しないでください"
            }
        }
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// 数字のみの入力とする設定
		leftTextField.keyboardType = .numberPad
		rightTextField.keyboardType = .numberPad
	}

	@IBAction private func tappedCalButton(_ sender: Any) {
		do{
			resultLabel.text = String(format: "%.5f", try calField())
		} catch let error as UserError {
            showAlert(message: error.message)
		} catch {
			print("その他のエラーです")
		}
	}

	// アラートを表示する関数
	private func showAlert(message: String){
		// OKボタンの処理
		let oKAction = UIAlertAction(title: "OK", style: .cancel)

        let alert = UIAlertController(title: "課題5", message: message, preferredStyle: .alert)
		alert.addAction(oKAction)

		present(alert, animated: true, completion: nil)
	}

	// 計算を行う関数
	private func calField() throws -> Float{
		guard !leftTextField.text!.isEmpty else{
			throw UserError.emptyLeftTextField
		}

		guard !rightTextField.text!.isEmpty else {
			throw UserError.emptyRightTextField
		}

		let value1 = Int(leftTextField.text!) ?? 0
		let value2 = Int(rightTextField.text!) ?? 0

		guard value2 != 0 else {
			throw UserError.divisionByZero
		}

		return Float(value1) / Float(value2)
	}
}
