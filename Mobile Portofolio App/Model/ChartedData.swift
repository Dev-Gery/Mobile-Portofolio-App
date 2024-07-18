//
//  ChartData.swift
//  Mobile Portofolio App
//
//  Created by admin on 7/18/24.
//

import Foundation

struct Charted: Decodable {
    let type: String, data: ChartedData
}

enum ChartedData: Decodable {
    case donut([DonutChartedData])
    case line(LineChartedData)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let donutValue = try? container.decode([DonutChartedData].self) {
            self = .donut(donutValue)
            return
        }
        
        if let lineValue = try? container.decode(LineChartedData.self) {
            self = .line(lineValue)
            return
        }
        
        throw DecodingError.typeMismatch(ChartedData.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected either an array of DonutChartData or an object of LineChartData"))
    }
    
}

struct DonutChartedData: Decodable {
    let label: String, percentage: String, data: [DonutChartTrxData]
}

struct DonutChartTrxData: Decodable {
    let trx_date: Date, nominal: Int
}

struct LineChartedData: Decodable {
    let month: [Int]
}


let jsonData = """
[
    {
        "type": "donutChart",
        "data": [
            {
                "label": "Tarik Tunai",
                "percentage": "55",
                "data": [
                    {
                        "trx_date": "21/01/2023",
                        "nominal": 1000000
                    },
                    {
                        "trx_date": "20/01/2023",
                        "nominal": 500000
                    },
                    {
                        "trx_date": "19/01/2023",
                        "nominal": 1000000
                    }
                ]
            },
            {
                "label": "QRIS Payment",
                "percentage": "31",
                "data": [
                    {
                        "trx_date": "21/01/2023",
                        "nominal": 159000
                    },
                    {
                        "trx_date": "20/01/2023",
                        "nominal": 35000
                    },
                    {
                        "trx_date": "19/01/2023",
                        "nominal": 1500
                    }
                ]
            },
            {
                "label": "Topup Gopay",
                "percentage": "7.7",
                "data": [
                    {
                        "trx_date": "21/01/2023",
                        "nominal": 200000
                    },
                    {
                        "trx_date": "20/01/2023",
                        "nominal": 195000
                    },
                    {
                        "trx_date": "19/01/2023",
                        "nominal": 5000000
                    }
                ]
            },
            {
                "label": "Lainnya",
                "percentage": "6.3",
                "data": [
                    {
                        "trx_date": "21/01/2023",
                        "nominal": 1000000
                    },
                    {
                        "trx_date": "20/01/2023",
                        "nominal": 500000
                    },
                    {
                        "trx_date": "19/01/2023",
                        "nominal": 1000000
                    }
                ]
            }
        ]
    },
    {
        "type": "lineChart",
        "data": {
            "month": [
                3,
                7,
                8,
                10,
                5,
                10,
                1,
                3,
                5,
                10,
                7,
                7
            ]
        }
    }
]
""".data(using: .utf8)
