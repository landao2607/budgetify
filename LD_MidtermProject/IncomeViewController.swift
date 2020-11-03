//
//  IncomeViewController.swift
//  LD_MidtermProject
//
//  Created by Lan Dao on 10/20/20.
//  Copyright © 2020 IS322. All rights reserved.
//

import UIKit

class IncomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var lbl_Income: UILabel!
    @IBOutlet weak var txt_EnterIncome: UITextField! //This textfield is in Decimal Pad type of keyboard. Ctrl+K to pop up the keyboard. However, if you type directly through the keyboard on your machine, you can still type in other characters. I tried to filter the keyboard with only numbers with TextField function, but it filtered both this txt_EnterIncome and txt_EnterNote. I'm still in the process of fixing this. But for now, with the keyboard type, it should work decently enough when users use the app on their phones.
    @IBOutlet weak var txt_EnterNote: UITextField!
    @IBOutlet weak var lbl_Category: UILabel!
    @IBOutlet weak var pickCategory: UIPickerView!
    @IBOutlet weak var txt_SelectDate: UITextField!
    @IBOutlet weak var btn_Done: UIButton!
    
   var strErrorMsg = "" //Hold Error message if bad values
        let datePicker = UIDatePicker()
        
        var pickerCategoryOptions: [String] = [String]()
        

    @IBAction func btn_DoneIsClicked(_ sender: Any) {
        self.txt_EnterIncome.endEditing(true) //Dismiss EnterExpense keyboard
        self.txt_EnterNote.endEditing(true) //Dismiss EnterNote keyboard
            
        guard let txtExpenseAmountValue = self.txt_EnterIncome.text,
            let _ = Float(txtExpenseAmountValue)
                else{
                    strErrorMsg = "You must provide a valid income amount." //Raise error msg if expense is not entered
                    fncShowErrors()
                    return //End the failed conversion
                    }
        guard let txtDateValue = self.txt_SelectDate.text, let _ = Optional(txtDateValue)
                else{
                    strErrorMsg = "You must select a date." //Raise error msg if date is not chosen
                    fncShowErrors()
                    return //End the failed conversion
                    }
        
        //What's left for Final Project
        //After entering the amount of money and click Done, this message will pop up
        strErrorMsg = "After users input all the information, the label 'Income' & the chart will be updated. All the info will also show up in the Expense Dropdown in Balance VC."  //My message
        fncShowErrors()
        return //End the failed conversion
        
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.pickCategory.delegate = self
            self.pickCategory.dataSource = self
            self.txt_EnterIncome.delegate = self
            self.txt_EnterNote.delegate = self
            pickerCategoryOptions = ["Salary","Deposit"]
            
            createDatePicker()
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerCategoryOptions.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerCategoryOptions[row]
        }
        
        //func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                //return string == string.filter("0123456789.".contains)
        //}
        
        //func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                //let intTagNo = textField.tag
                //switch(intTagNo){
                //case 1:
                    //textField.superview?.viewWithTag(2)?.becomeFirstResponder()
                    //break
                //case 2:
                    //textField.resignFirstResponder()
                    //textField.superview?.viewWithTag(3)?.becomeFirstResponder()
                    //break
                //default:
                    //textField.resignFirstResponder()
                    //break
            //}
                //return true;
        //}
        
        func fncShowErrors() {
            if strErrorMsg != ""{
                let alertController = UIAlertController(title: "Input Error", message: strErrorMsg, preferredStyle: .alert )
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(alertController, animated: true, completion: nil)
                return
            }
        }
        
        func createDatePicker() {
            txt_SelectDate.textAlignment = .center //align date to center of text field
            
            //toolbar
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            //bar button
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
            toolbar.setItems([doneBtn], animated: true)
            
            //assign toolbar
            txt_SelectDate.inputAccessoryView = toolbar
            
            //assign date picker to the text field
            txt_SelectDate.inputView = datePicker
            
            //date picker mode
            datePicker.datePickerMode = .date
        }
        

        @objc func donePressed() {
            //formatter to date picker
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            
            txt_SelectDate.text = formatter.string(from: datePicker.date)
            self.view.endEditing(true) //dismiss date picker
        }

    }
