//
//  UniqueIdRandomGeneratorStorageProtocol.swift
//  MyKeynote
//
//  Created by 양승현 on 2023/07/19.
//

protocol UniqueIdRandomGeneratorStorageProtocol {
  associatedtype UniqueId
  
  static var shared: UniqueIdRandomGeneratorStorage { get }
  var uniqueIdList: [UniqueId] { get }
  var randomGenerator: UniqueIDRandomGenerator { get }
  
  func create() -> UniqueId
  func delete(uniqueId: UniqueId)
  func contain(uniqueId: UniqueId) -> Bool
}
