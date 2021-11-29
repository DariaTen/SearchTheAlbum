//
//  CoreDataManager.swift
//  Search The Album
//
//  Created by Daria Ten on 28.11.2021.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {

	func get<Entity: NSManagedObject>(ofType: Entity.Type) -> [Entity]

	func create<Entity: NSManagedObject>(ofType: Entity.Type) -> Entity

	func save()

	func delete(entity: NSManagedObject)
}

final class CoreDataManager: CoreDataManagerProtocol {

	private let context: NSManagedObjectContext

	init(context: NSManagedObjectContext) {
		self.context = context
	}

	func get<Entity: NSManagedObject>(ofType: Entity.Type) -> [Entity] {
		do {
			let request = Entity.fetchRequest()
			guard let result = try context.fetch(request) as? [Entity] else {
				return []
			}
			return result
		} catch {
			print(error)
			return []
		}
	}

	func create<Entity: NSManagedObject>(ofType: Entity.Type) -> Entity {
		return Entity(context: context)
	}

	func save() {
		do {
			try context.save()
		} catch {
			print(error)
		}
	}

	func delete(entity: NSManagedObject) {
		context.delete(entity)
	}
}
