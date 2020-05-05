//
//  HistoryVC.swift
//  Glass-Half-Full
//
//  Created by XCodeClub on 2020-05-04.
//  Copyright © 2020 Tyler Ciarmataro. All rights reserved.
//

import UIKit
import Charts

class HistoryVC: UIViewController {
    @IBOutlet weak var chartView: LineChartView!
    var daysList : [Day] = []
    var dates:[String] = []
    var cups:[Int] = []
    var appBlue:UIColor = UIColor(cgColor: CGColor(srgbRed: 0.137, green: 0.627, blue: 0.984, alpha: 1.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // load the daysList here
        
        let defaults = UserDefaults.standard
        if let savedDays = defaults.object(forKey: "waterData") as? Data {
            let decoder = JSONDecoder()
            if let loadedDays = try? decoder.decode([Day].self, from: savedDays) {
                daysList = loadedDays
                
                // only show the last week of data to the user
                if daysList.count > 7 {
                    daysList.removeSubrange(0..<(daysList.count - 8))
                }
            }
        }
        
        // reset value arrays
        dates = []
        cups = []
        
        for day in daysList {
            dates.append(day.date)
            cups.append(day.cups)
        }
        
        chartView.animate(xAxisDuration: 2.0, yAxisDuration:2.0, easingOption: .easeInSine)
        
        createChart()
    }
    
    // draws the chart on the view
    func createChart(){
        //create data entries variable
        var dataEntries:[ChartDataEntry] = []
        
        for i in 0..<dates.count{
           // print(forX[i])
            //let dataEntry = ChartDataEntry(x: (xVals[i] as NSString).doubleValue, y: Double(yVals[i]))
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(cups[i]) , data: dates as AnyObject?)
            print(dataEntry)
            dataEntries.append(dataEntry)
        }
        
        // set data and it's styling
        let waterLine = LineChartDataSet(entries: dataEntries, label: "Water in Cups") //Here we convert lineChartEntry to a LineChartDataSet
        waterLine.colors = [appBlue] //Sets the colour to blue
        waterLine.setCircleColor(appBlue)
        waterLine.circleHoleColor = appBlue
        waterLine.circleRadius = 5.0
        
        //gradient settings for underneath the line
        let colors = [CGColor(srgbRed: 0.137, green: 0.627, blue: 0.984, alpha: 1.0), UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: colorLocations) else { print("gradient error"); return}
        waterLine.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        waterLine.drawFilledEnabled = true
        
        //data settings
        let data = LineChartData() //This is the object that will be added to the chart
        data.addDataSet(waterLine) //Adds the line to the dataSet
        data.setDrawValues(true)
        
        // chartView styling and setting data
        chartView.backgroundColor = UIColor.white
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        chartView.xAxis.granularity = 1
        chartView.data = data //finally - it adds the chart data to the chart and causes an update
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
