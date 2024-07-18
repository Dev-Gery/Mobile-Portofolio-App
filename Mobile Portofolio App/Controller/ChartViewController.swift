//
//  ViewController.swift
//  Mobile Portofolio App
//
//  Created by admin on 7/18/24.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    @IBOutlet weak var DonutChartView: PieChartView!
    @IBOutlet weak var LineChartView: LineChartView!
    let chartMgr = ChartManager()
    var chartData: [Charted]!
    var donutChartData: [DonutChartedData]?
    var lineChartData: LineChartedData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartData = chartMgr.fetchChartData()
        chartData.forEach { chartData in
            switch chartData.data {
            case .donut(let donutChartData):
                self.donutChartData = donutChartData
            case .line(let lineChartData):
                self.lineChartData = lineChartData
            }
        }
        setupDonutChart()
        setupLineChart()
    }
    
    func setupDonutChart() {
        
        let entries = donutChartData?.map({ data in
            if let percentage = Double(data.percentage) {
                return PieChartDataEntry(value: percentage, label: data.label)
            } else {
                return PieChartDataEntry()
            }
        }) as! [PieChartDataEntry]
        
        let dataSet = PieChartDataSet(entries: entries, label: "Transactions")
        dataSet.colors = ChartColorTemplates.material()
        dataSet.sliceSpace = 2.0
        dataSet.selectionShift = 5.0
        
        DonutChartView.drawHoleEnabled = true
        DonutChartView.holeRadiusPercent = 0.5
//        DonutChartView.transparentCircleColor = UIColor.clear
        
        let data = PieChartData(dataSet: dataSet)
        DonutChartView.data = data
        
        DonutChartView.centerText = "Transactions"
        DonutChartView.notifyDataSetChanged()
        
            
    }
    
    func setupLineChart() {
        
        var entries = [ChartDataEntry]()
        for i in 0..<(lineChartData?.month.count ?? 0) {
            entries.append(ChartDataEntry(x: Double(i), y: Double((lineChartData?.month[i])!)))
        }
        
        let dataSet = LineChartDataSet(entries: entries, label: "Transactions")
        dataSet.colors = [NSUIColor.blue]
        
        LineChartView.data = LineChartData(dataSet: dataSet)
        
        LineChartView.xAxis.granularity = 1
        LineChartView.xAxis.labelPosition = .top
        LineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"])
    }
    

}

