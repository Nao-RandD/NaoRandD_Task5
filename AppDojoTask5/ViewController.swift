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
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// 数字のみの入力とする設定
		leftTextField.keyboardType = .numberPad
		rightTextField.keyboardType = .numberPad
	}

	@IBAction private func tappedCalButton(_ sender: Any) {
		do{
			let result = try calField()
			resultLabel.text = String(result)
		}catch let error as UserError{
			// OKボタンの処理
			let oKAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)

			switch error {
			case .emptyLeftTextField:
				let alert: UIAlertController = UIAlertController(title: "課題5", message:  "割られる数を入力してください", preferredStyle:  UIAlertController.Style.alert)
				print("割られる数の入力がありません")
				alert.addAction(oKAction)
				present(alert, animated: true, completion: nil)
			case .emptyRightTextField:
				let alert: UIAlertController = UIAlertController(title: "課題5", message:  "割る数を入力してください", preferredStyle:  UIAlertController.Style.alert)
				print("割る数の入力がありません")
				alert.addAction(oKAction)
				present(alert, animated: true, completion: nil)
			case .divisionByZero:
				let alert: UIAlertController = UIAlertController(title: "課題5", message:  "割る数には0を入力しないでください", preferredStyle:  UIAlertController.Style.alert)
				print("0除算になっています")
				alert.addAction(oKAction)
				present(alert, animated: true, completion: nil)
			}
		}catch {
			print("その他のエラーです")
		}
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

		// ゼロ除算になる場合にはエラーを投げる
		guard value2 != 0 else {
			throw UserError.divisionByZero
		}
		return Float(value1 / value2)
	}
}

