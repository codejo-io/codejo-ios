//
//  File.swift
//  
//
//  Created by Cole James on 5/23/21.
//

import UIKit

public class PickerViewTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {

    private var pickerView = UIPickerView()

    public var options: [PickerViewTextFieldOption] = [] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPickerView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPickerView()
    }

    private func setupPickerView() {
        pickerView = UIPickerView()
        pickerView.delegate = self

        setupBarAccessory()

        inputView = pickerView
    }

    private func setupBarAccessory() {
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.onDoneButtonTap))

        let barAccessory = UIToolbar()

        barAccessory.barStyle = .default
        barAccessory.isTranslucent = true
        barAccessory.sizeToFit()

        barAccessory.items = [spaceButton, btnDone]
        barAccessory.isUserInteractionEnabled = true

        inputAccessoryView = barAccessory
    }

    @objc func onDoneButtonTap() {
        resignFirstResponder()
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row].text
    }

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if options[row].enabled {
            text = options[row].text
        } else if row + 1 < options.count {
            pickerView.selectRow(row + 1, inComponent: component, animated: true)
            text = options[row + 1].text
        }

        sendActions(for: .editingChanged)
    }

}
