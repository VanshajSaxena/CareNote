import SwiftUI
import Charts
import Foundation
extension Color {
    init(_ hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

struct Graph: Identifiable {
    var id = UUID()
    var day: Int
    var value: Double
}

struct graphContainerView: View {
    let graphData: [Graph] = [
        Graph(day: 1, value: 23),
        Graph(day: 4, value: 68),
        Graph(day: 7, value: 82),
        Graph(day: 10, value: 79),
        Graph(day: 13, value: 75),
        Graph(day: 16, value: 71),
        Graph(day: 19, value: 87),
        Graph(day: 22, value: 98),
        Graph(day: 25, value: 80),
        Graph(day: 28, value: 74),
        Graph(day: 31, value: 71)
    ]
    
    var maxValue: Double {
        graphData.map { $0.value }.max() ?? 0
    }
    
    var minValue: Double {
        graphData.map { $0.value }.min() ?? 0
    }

    var body: some View {
        VStack {
            Chart {
                ForEach(graphData) { data in
                    LineMark(
                        x: .value("Day", data.day),
                        y: .value("Value", data.value)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(Color.blue)
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5, 5]))
                    
                    PointMark(
                        x: .value("Day", data.day),
                        y: .value("Value", data.value)
                    )
                    .foregroundStyle(Color("1432F5"))
                    .symbolSize(30)
                }
                
                // Add a red reference line for the maximum value
                RuleMark(y: .value("Max Value", 100))
                    .lineStyle(StrokeStyle(lineWidth: 1))
                    .foregroundStyle(Color.red)
                    .annotation(position: .topTrailing) {
                        Text("Max")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                
                // Add a green reference line for the minimum value
                RuleMark(y: .value("Min Value", 60))
                    .lineStyle(StrokeStyle(lineWidth: 1))
                    .foregroundStyle(Color.green)
                    .annotation(position: .bottomTrailing) {
                        Text("Min")
                            .foregroundColor(.green)
                            .font(.caption)
                    }
            }
            .frame(height: 300)
            .chartXAxis {
                AxisMarks(values: Array(stride(from: 1, through: 31, by: 3))) {
                    AxisGridLine()
                        .foregroundStyle(Color.gray)
                    AxisTick()
                        .foregroundStyle(Color.gray)
                    AxisValueLabel()
                    .foregroundStyle(Color.black) // Make axis mark numbers black
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: Array(stride(from: 40, through: 140, by: 20))) {
                    AxisGridLine()
                        .foregroundStyle(Color.gray)
                    AxisTick()
                        .foregroundStyle(Color.gray)
                    AxisValueLabel()
                    .foregroundStyle(Color.black) // Make axis mark numbers black
                }
            }
            .chartXScale(domain: 1...31) // Ensure X-axis starts from 1
            .chartYScale(domain: 40...140) // Set Y-axis scale to range from 40 to 140
            .chartPlotStyle { plotArea in
                plotArea
                    .background(Color.clear)
                    .overlay(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 1) // Add border to the chart for a clean box look
                    )
            }
        }
        .padding()
    }
}

struct graphContainerView_Previews: PreviewProvider {
    static var previews: some View {
        graphContainerView()
    }
}
