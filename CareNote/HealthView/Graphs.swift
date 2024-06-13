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
    var time: Int
    var value: Double
}


struct GraphContainerView: View {
    let graphData: [Graph]
    let xAxisRange: ClosedRange<Int>
    let yAxisRange: ClosedRange<Int>
    let xAxisStride: Int
    let yAxisStride: Int

    
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
                        x: .value("Time", data.time),
                        y: .value("Value", data.value)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(Color.blue)
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5, 5]))
                    
                    PointMark(
                        x: .value("Time", data.time),
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
                AxisMarks(values: Array(stride(from: xAxisRange.lowerBound, through: xAxisRange.upperBound, by: xAxisStride))) {
                    AxisTick()
                        .foregroundStyle(Color.gray)
                    AxisValueLabel()
                        .foregroundStyle(Color.black) // Make axis mark numbers black
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: Array(stride(from: yAxisRange.lowerBound, through: yAxisRange.upperBound, by: yAxisStride))) {
                    AxisTick()
                        .foregroundStyle(Color.gray)
                    AxisValueLabel()
                        .foregroundStyle(Color.black) // Make axis mark numbers black
                }
            }
            .chartXScale(domain: xAxisRange) // Ensure X-axis starts from lower bound to upper bound
            .chartYScale(domain: yAxisRange) // Set Y-axis scale to range from 40 to 140
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

struct GraphContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GraphContainerView(graphData: [Graph(time: 1, value: 70)], xAxisRange: 1...31, yAxisRange: 0...100, xAxisStride: 3, yAxisStride: 2)
    }
}
