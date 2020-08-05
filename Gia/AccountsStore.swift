//
//  AccountsStore.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

class AccountsStore {
    
    static var shared = AccountsStore()
    static var favorites: [AccountsData] = AccountsStore.getFavorites()
    
    func getAllAccounts() -> [AccountsData] {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "accounts") as? Data {
            let decoder = JSONDecoder()
            if let accountsData = try? decoder.decode([AccountsData].self, from: data) {
                return accountsData
            }
        }
        
        return []
    }
    
    static func getFavorites() -> [AccountsData] {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "favs") as? Data {
            let decoder = JSONDecoder()
            if let accountsData = try? decoder.decode([AccountsData].self, from: data) {
                return accountsData
            }
        }
        
        return []
    }
    
    static func saveFavorites() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(AccountsStore.favorites) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "favs")
            print("Saved Favorites")
        } else {
            print("Error Saving")
        }
    }
    
    
    func getAllFavoriteAccounts() -> [AccountsData] {
        getAllAccounts().filter { $0.isFavorite }
    }
    
    func save(_ accounts: [AccountsData]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(accounts) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "accounts")
            print("Saved")
        } else {
            print("Error Saving")
        }
    }
    
    func update(_ account: AccountsData) {
        var accounts = getAllAccounts()
        if let i = accounts.firstIndex(of: account) {
            accounts[i].isFavorite = true
            save(accounts)
        }
    }
}
