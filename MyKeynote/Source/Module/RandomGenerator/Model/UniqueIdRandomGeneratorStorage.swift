//
//  UniqueIdRandomGeneratorStorage.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

class UniqueIdRandomGeneratorStorage: UniqueIdRandomGeneratorStorageProtocol {
  // MARK: - Constant
  typealias UniqueId = String
  
  // MARK: - Properites
  static let shared = UniqueIdRandomGeneratorStorage()
  
  private(set) var uniqueIdList: [UniqueId] = []
  
  private(set) var randomGenerator = UniqueIDRandomGenerator()
  
  // MARK: - Lifecycle
  private init() { }
}

// MARK: - Helper
extension UniqueIdRandomGeneratorStorage {
  func create() -> UniqueId {
    while true {
      let specificId = randomGenerator.randValue()
      if contain(uniqueId: specificId) { continue }
      uniqueIdList.append(specificId)
      return specificId
    }
  }
  
  func delete(uniqueId: UniqueId) {
    guard let idx = uniqueIdList.firstIndex(of: uniqueId) else {
      return
    }
    uniqueIdList.remove(at: idx)
  }
  
  func contain(uniqueId: UniqueId) -> Bool {
    return uniqueIdList.contains(uniqueId)
  }
}
