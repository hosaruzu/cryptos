//
//  PortfolioDataService.swift
//  Cryptos
//
//  Created by Artem Tebenkov on 23.07.2024.
//

import CoreData

final class PortfolioDataService {

    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"

    // MARK: - Public properties

    @Published var savedEntites: [PortfolioEntity] = []

    // MARK: - Init

    init() {
        self.container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                print("Error loading Core Data \(error)")
            }
            self.getPortfolio()
        }

    }

    // MARK: - Public

    func updatePortfolio(_ coin: Coin, amount: Double) {
        if let entity = savedEntites.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity, amount: amount)
            } else {
                delete(entity)
            }
        } else {
            if amount > 0 {
                add(coin, amount: amount)
            }
        }
    }

    // MARK: - CRUD

    private func add(_ coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }

    private func update(_ entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }

    private func delete(_ entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }

    // MARK: - Helpers

    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntites = try container.viewContext.fetch(request)
        } catch {
            print("Erro fetching Portfolio Entities: \(error)")
        }
    }

    private func save() {
        do {
           try container.viewContext.save()
        } catch {
            print("Error saving to Core Data: \(error)")
        }
    }

    private func applyChanges() {
        save()
        getPortfolio()
    }
}
