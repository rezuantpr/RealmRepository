//
//  RealmSingleton.swift
//  StepsActivity
//
//  Created by Rezuan Bidzhiev on 21.01.2021.
//

import Foundation
import RealmSwift


protocol RealmSingleton {
  associatedtype Object: RealmSwift.Object
  static var current: Object { get }
}

extension RealmSingleton {
  static var current: Object {
    let realm = try! Realm()
    if let object = realm.objects(Object.self).first {
      return object
    }
    
    let object = Object()
    try! realm.write {
      realm.add(object)
    }
    
    return object
  }
}
