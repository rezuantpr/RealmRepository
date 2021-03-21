//
//  RealmRepository.swift
//  MyMoney
//
//  Created by  Rezuan on 08.12.2020.
//

import Foundation
import RealmSwift

protocol RealmRepository: class {
  associatedtype Object: RealmSwift.Object
  static func selectAll() -> Results<Object>
  static func selectAll(sortedKeyPath keyPath: String, acsending: Bool) -> Results<Object>
  static func select(with predicate: NSPredicate) -> Results<Object>
  static func select(primaryKey: String) -> Object?
  static func delete(_ object: Object)
  static func delete(primaryKey: String)
  static func deleteAll()
  static func insert(_ object: Object)
  static func insert(_ object: Object, update: Realm.UpdatePolicy)
  static func insert(_ objects: [Object], update: Realm.UpdatePolicy)
}

extension RealmRepository {
  // =====================================================================================
  static func selectAll() -> Results<Object> {
    return try! Realm().objects(Object.self)
  }
  
  static func selectAll(sortedKeyPath keyPath: String, acsending: Bool) -> Results<Object> {
    return selectAll().sorted(byKeyPath: keyPath, ascending: acsending)
  }
  
  static func select(with predicate: NSPredicate) -> Results<Object> {
    return selectAll().filter(predicate)
  }
  
  static func select(primaryKey: String) -> Object? {
    return try! Realm().object(ofType: Object.self, forPrimaryKey: primaryKey)
  }
  // =====================================================================================
  
  // =====================================================================================
  static func delete(_ object: Object) {
    let realm = try! Realm()
    try! realm.write {
      realm.delete(object)
    }
  }
  
  static func delete(primaryKey: String) {
    guard let object = select(primaryKey: primaryKey) else { return }
    delete(object)
  }
  
  static func deleteAll() {
    let objects = selectAll()
    let realm = try! Realm()
    try! realm.write {
      realm.delete(objects)
    }
  }
  // =====================================================================================
  
  // =====================================================================================
  static func insert(_ object: Object) {
    let realm = try! Realm()
    try! realm.write {
      realm.add(object)
    }
  }
  
  static func insert(_ object: Object, update: Realm.UpdatePolicy) {
    let realm = try! Realm()
    try! realm.write {
      realm.add(object, update: update)
    }
  }
  
  static func insert(_ objects: [Object], update: Realm.UpdatePolicy) {
    let realm = try! Realm()
    try! realm.write {
      realm.add(objects, update: update)
    }
  }
}
