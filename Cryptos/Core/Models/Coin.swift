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
    let marketCap: Int
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
            name: name, image: image,
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
                0.9993690724057125,
                0.9987155704313939,
                0.9986724702061377,
                0.9982077203908072,
                0.9989083565316601,
                0.9999060547982729,
                0.9991940828066781,
                0.998520600611451,
                1.001034563512229,
                0.9994470893210579,
                0.9992626539827245,
                0.9993313172025098,
                0.9994321683863362,
                0.9993660069862421,
                0.9991936590769108,
                0.9994207563409352,
                0.9996456569554879,
                0.99929068056285,
                0.9964625298525628,
                0.998830804761255,
                0.9986041602866682,
                0.9978365754530346,
                0.9990676808722849,
                0.9994000743650681,
                0.9977577486859713,
                1.000088506113212,
                1.0004963001137088,
                0.9991557594957429,
                0.998912289476813,
                1.001944925095949,
                0.9987189213379107,
                0.9991652605534537,
                1.000741481105862,
                1.0020038032749201,
                1.0000790848034575,
                0.9999195824747665,
                0.9996901835370814,
                1.0001711971804896,
                0.9998720435895473,
                1.0000669367890391,
                0.9993539342628126,
                1.0005519714195263,
                1.0003636009107908,
                0.999490306576865,
                1.0000995118006915,
                0.9996446252337641,
                0.9999544436055589,
                1.0017326243454896,
                0.9998603253667844,
                1.0002190077933173,
                1.0003342853293398,
                1.0001025734820705,
                1.0005731963903473,
                0.9999455187477942,
                1.000359040896874,
                0.9998172289126408,
                0.9999836449397511,
                1.0003716665520994,
                1.001107229697802,
                0.9998558681604659,
                1.0001456732975726,
                1.0005625675368122,
                1.0003748287131775,
                1.0013053158983305,
                0.9997060395044043,
                1.0000896497104288,
                1.000907066539064,
                0.9998125329863374,
                1.0005370901121897,
                1.0007400753396254,
                1.000047329161105,
                0.9996515482300762,
                0.9990553538916167,
                1.0001126028442677,
                0.9999547696281811,
                1.0009491595678774,
                0.9999715044379096,
                0.9995265153823638,
                1.0002708010562833,
                1.0000250555291272,
                0.9999971716874225,
                0.999591693291853,
                0.9996209645338023,
                1.0004046937676303,
                1.0001990530219846,
                0.9994741505494995,
                0.9996266480781308,
                0.9997413218565865,
                1.0007617643313782,
                0.9997080403796291,
                0.9998589229979054,
                0.9992965025900316,
                1.0008622130852618,
                1.0005624733251024,
                0.9989178247704961,
                1.0018395166963774,
                0.9998502461998271,
                0.9998283692188235,
                1.0003422328239373,
                1.0021903732432063,
                0.9995920492239322,
                1.0022205626648177,
                0.9998696987742037,
                0.9994172148629759,
                1.0001292094530128,
                0.9983844496084416,
                0.9980592861940532,
                0.9996974326238681,
                1.000687872596905,
                0.999184166484616,
                1.0000605423174698,
                0.9999404978391686,
                1.0005603672415837,
                0.9993144107231501,
                0.9997615658275408,
                0.9999415647625295,
                1.001099217120973,
                1.0001696661944968,
                0.9994570029421836,
                1.0013729272797032,
                1.0002578531209347,
                1.0002045152440555,
                0.9996844404393231,
                0.9993320458443272,
                0.9994192990562342,
                1.0001747784402248,
                0.9998336031835325,
                0.9994713211689886,
                1.0011826507912234,
                0.9996556569731613,
                1.0008297864591598,
                1.000594337538274,
                1.0003641148601,
                0.9994003582259526,
                1.0003008430380236,
                0.9998661544063515,
                0.9998001939498137,
                0.999219462325177,
                1.0002650029147877,
                0.9998084775465509,
                1.0009810834816864,
                1.0007160072131618,
                1.0016675396811807,
                1.0017751541861872,
                0.9999649045256999,
                1.000202261168835,
                0.9996258701460919,
                1.0000348004534056,
                1.0002661095026129,
                0.9999168752290418,
                0.9998078762357223,
                1.0020074111101704,
                1.0012576839621186,
                0.9995986242386755,
                1.0003487542257965,
                0.9998189842104707,
                0.9997722584858995,
                1.0003784465131977,
                0.9999925868838146,
                0.999963761637514,
                1.0000639169669254,
                0.9995010604339166,
                0.9991367699806522,
                1.000571558901843,
                0.9993297399929412,
                1.000379004137265,
                1.0005764949223963,
                0.999796250588653
            ]),
        priceChangePercentage24HInCurrency: 0.12663815965874156,
        currentHoldings: 2)
}
