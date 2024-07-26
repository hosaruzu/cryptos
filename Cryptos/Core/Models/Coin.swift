//
//  Coin.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 10.07.2024.
//

import Foundation

struct Coin: Decodable, Identifiable, Equatable {
    static func == (lhs: Coin, rhs: Coin) -> Bool {
        lhs.id == rhs.id
    }

    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double
    let marketCapRank: Int
    let fullyDilutedValuation: Int?
    let totalVolume: Double
    let high24H: Double?
    let low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double
    let marketCapChange24H: Double
    let marketCapChangePercentage24H: Double
    let circulatingSupply: Double
    let totalSupply: Double?
    let maxSupply: Double?
    let ath, athChangePercentage: Double
    let athDate: String
    let atl, atlChangePercentage: Double
    let atlDate: String
    let lastUpdated: String
    let sparklineIn7D: Sparkline
    let priceChangePercentage24HInCurrency: Double
    let currentHoldings: Double?

    func updateHoldings(amount: Double) -> Coin {
        return Coin(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            marketCap: marketCap,
            marketCapRank: marketCapRank,
            fullyDilutedValuation: fullyDilutedValuation,
            totalVolume: totalVolume,
            high24H: high24H,
            low24H: low24H,
            priceChange24H: priceChange24H,
            priceChangePercentage24H: priceChangePercentage24H,
            marketCapChange24H: marketCapChange24H,
            marketCapChangePercentage24H: marketCapChangePercentage24H,
            circulatingSupply: circulatingSupply,
            totalSupply: totalSupply,
            maxSupply: maxSupply,
            ath: ath,
            athChangePercentage: athChangePercentage,
            athDate: athDate,
            atl: atl,
            atlChangePercentage: atlChangePercentage,
            atlDate: atlDate,
            lastUpdated: lastUpdated,
            sparklineIn7D: sparklineIn7D,
            priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency,
            currentHoldings: amount)
    }

    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
}

struct Sparkline: Decodable {
    let price: [Double]
}

extension Coin {
    static let mock = Coin(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        currentPrice: 57851,
        marketCap: 1143721352495,
        marketCapRank: 1,
        fullyDilutedValuation: 1217963290859,
        totalVolume: 25467407643,
        high24H: 59277,
        low24H: 57127,
        priceChange24H: -1066.5536277339052,
        priceChangePercentage24H: -1.81023,
        marketCapChange24H: -18258419562.06909,
        marketCapChangePercentage24H: -1.57132,
        circulatingSupply: 19719928.0,
        totalSupply: 21000000.0,
        maxSupply: 21000000.0,
        ath: 73738,
        athChangePercentage: -21.33255,
        athDate: "2024-03-14T07:10:36.635Z",
        atl: 67.81,
        atlChangePercentage: 85445.80864,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2024-07-11T06:09:33.812Z",
        sparklineIn7D: Sparkline(price: [
            64897.466640545805,
            64654.91835236968,
            63771.94116284888,
            63676.04850620038,
            63940.49373036791,
            63590.66331234905,
            63590.63618283955,
            63604.750257719155,
            63747.28527433048,
            63705.35583839652,
            63981.370034196996,
            63975.96715356269,
            63565.528204915856,
            63809.22054036418,
            63838.349226737955,
            64192.30665062532,
            64130.08316868449,
            64221.280424641045,
            64183.36643211268,
            63824.805155061695,
            63869.76609325864,
            63672.044363448615,
            64091.17432236077,
            64043.14970164301,
            64397.689991955085,
            65163.527672846656,
            65658.89779660033,
            66380.8935458446,
            66302.72588518042,
            66571.72882588342,
            66829.52204964789,
            67265.13367947098,
            66943.57401197092,
            66917.57260080865,
            66726.52875458487,
            66659.36403104197,
            66484.87866164831,
            66298.72115095778,
            66623.85624202447,
            66566.6291426702,
            66642.59233018276,
            66568.17448441216,
            66659.32423637372,
            66534.62101397967,
            66548.11927255774,
            66660.80847569843,
            66560.43534812235,
            66509.77639051678,
            66527.26100565071,
            66588.76510262096,
            66655.35074566986,
            66832.32565565783,
            66853.12817378907,
            67450.51323577235,
            67448.6858895166,
            67338.0822557102,
            67379.16287937594,
            67124.6556080514,
            67134.53160659164,
            67104.22118882959,
            67056.21625885785,
            67291.21529491036,
            67331.53643498228,
            67202.73761655409,
            67053.89070690276,
            67090.70761465676,
            66718.61623587705,
            66756.57142290594,
            66822.40282024264,
            66985.74445047512,
            66886.69605388425,
            66883.90222199584,
            66996.57279289034,
            66839.245024825,
            67292.99518997723,
            67212.4979759114,
            67517.0750399032,
            66656.74254454274,
            66804.10902865918,
            67295.51327779717,
            67719.15538596455,
            68175.02451860612,
            68011.0273007143,
            68167.78452534138,
            68080.21310452391,
            67851.81640902247,
            68023.17556490241,
            67895.44798763118,
            67820.19042115669,
            67638.94662805958,
            67414.73512180289,
            67241.16858195442,
            67237.8760447406,
            67362.28937566605,
            67449.56524078002,
            67548.3359838079,
            67801.39836980225,
            67088.71348756884,
            66849.48086882262,
            67071.9820190575,
            67004.33329835009,
            67406.17177075725,
            67445.01970549818,
            68038.46451277829,
            67928.24675408697,
            67821.51442139022,
            67530.50708584284,
            67620.04159250173,
            67443.08356677454,
            67495.34424861985,
            67681.93315249645,
            67466.64586739332,
            66997.752572542,
            66728.26447054958,
            66573.96799512621,
            66547.68902864128,
            66955.89302043982,
            67022.61489615958,
            66927.7693718335,
            66707.65415572512,
            66547.64952858085,
            66115.13852805208,
            67232.1099529616,
            66302.5528078418,
            65978.17813004697,
            65785.50593896376,
            66006.08864290864,
            65550.6111010191,
            65939.65251217571,
            65965.60423006085,
            65930.88044053968,
            65942.41746522837,
            65779.77376801085,
            65679.16569478507,
            65951.1084397178,
            66050.72687483058,
            65795.95176953415,
            65872.72631174345,
            66016.74289789269,
            66000.76658129529,
            66456.47345126314,
            66396.04869726383,
            66467.54238124813,
            66438.95525412414,
            66476.10276492724,
            66795.09729397231,
            66190.20109070123,
            66348.12971900392,
            66549.47643427133,
            66154.44744371835,
            66061.73458661836,
            65945.58762844752,
            65418.79740596946,
            65507.31277984199,
            65266.98516408711,
            65403.53513022529,
            64333.629956531084,
            64288.058929939034,
            64247.21309734033,
            64047.17595824331,
            64281.43999006733,
            64119.198118529355,
            64303.87816963069,
            64148.47274233018,
            64337.60914523049,
            64022.66554565128,
            64229.62895703639
        ]),
        priceChangePercentage24HInCurrency: 0.12663815965874156,
        currentHoldings: 2)
}
