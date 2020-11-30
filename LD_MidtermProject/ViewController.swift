//
//  ViewController.swift
//  LD_MidtermProject
//  Name: Lan Dao
//  Programming Language: Swift 5 on Xcode 11
//  Target Device: iPhone 11
//  Version: iOS 13.4
//  This money tracking app lets user enter amount of expense/income and generates a chart of
//  total income and expense monthly.
//
//  For this midterm project, I created a chart and inputs for users. For final project, I will finish up with putting user's input in arrays and calculate the total and balance, as well as updating the chart. I will also create a ViewController for the Balance button that shows all the transactions.
//
//  Created by Lan Dao on 10/17/20.
//  Copyright © 2020 IS322. All rights reserved.
//

import Charts //I installed CocoaPod to import Charts
import UIKit

class ViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var lbl_Month: UILabel!
    @IBOutlet weak var lbl_ExpenseTotal: UILabel!
    @IBOutlet weak var lbl_IncomeTotal: UILabel!
    @IBOutlet weak var btn_Balance: UIButton!
    @IBOutlet weak var btn_CreateNewExpense: UIButton!
    @IBOutlet weak var btn_CreateNewIncome: UIButton!
    
    var pieChart = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Update current month on lbl_Month
        let today = Date()
        let month = Calendar.current.component(.month, from: today)
        lbl_Month.text = "\(Calendar.current.monthSymbols[month-1])"
        
        //Pie Chart
        pieChart.delegate = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        var entries = [ChartDataEntry]()
        for x in 1..<3 {
            entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.joyful()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }

}

