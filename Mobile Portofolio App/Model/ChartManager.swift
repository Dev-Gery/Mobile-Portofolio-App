//
//  ChartManager.swift
//  Mobile Portofolio App
//
//  Created by admin on 7/18/24.
//

import Foundation

struct ChartManager {
    func fetchChartData(withJsonData json: Data = jsonData ?? "".data(using: .utf8)!) -> [Charted] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            let decodedData = try decoder.decode([Charted].self, from: json)
            print(decodedData)
            return decodedData
        } catch {
            print(error)
            return []
        }
    }
}
