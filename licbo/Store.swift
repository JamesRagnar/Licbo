//
//  Store.swift
//  licbo
//
//  Created by James Harquail on 2017-05-02.
//  Copyright © 2017 Ragnar Development. All rights reserved.
//

import Foundation
import CoreData
import MapKit

@objc(Store)
public class Store: NSManagedObject {

    private struct Attributes {
        private static let addressLine1 = "address_line_1"
        private static let addressLine2 = "address_line_2"
        private static let city = "city"
        private static let fax = "fax"
        private static let hasColdBeerRoom = "has_beer_cold_room"
        private static let hasBilingualServices = "has_bilingual_services"
        private static let hasParking = "has_parking"
        private static let hasProductConsultant = "has_product_consultant"
        private static let hasSpecialOccasionPermits = "has_special_occasion_permits"
        private static let hasTastingBar = "has_tasting_bar"
        private static let hasTransitAccess = "has_transit_access"
        private static let hasVintagesCorner = "has_vintages_corner"
        private static let hasWheelchairAccessability = "has_wheelchair_accessability"
        private static let lcboID = "id"
        private static let inventoryCount = "inventory_count"
        private static let inventoryPriceInCents = "inventory_price_in_cents"
        private static let inventoryVolumeInMillileter = "inventory_volume_in_milliliters"
        private static let isDead = "is_dead"
        private static let latitude = "latitude"
        private static let longitude = "longitude"
        private static let name = "name"
        private static let postalCode = "postal_code"
        private static let productsCount = "products_count"
        private static let storeNo = "store_no"
        private static let sundayOpen = "sunday_open"
        private static let sundayClose = "sunday_close"
        private static let mondayOpen = "monday_open"
        private static let mondayClose = "monday_close"
        private static let tuesdayOpen = "tuesday_open"
        private static let tuesdayClose = "tuesday_close"
        private static let wednesdayOpen = "wednesday_open"
        private static let wednesdayClose = "wednesday_close"
        private static let thursdayOpen = "thursday_open"
        private static let thursdayClose = "thursday_close"
        private static let fridayOpen = "friday_open"
        private static let fridayClose = "friday_close"
        private static let saturdayOpen = "saturday_open"
        private static let saturdayClose = "saturday_close"
        private static let tags = "tags"
        private static let telephone = "telephone"
        private static let updatedAt = "updated_at"
    }

    init?(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?, data: [String: Any]?) {
        


        super.init(entity: entity, insertInto: context)
    }

    override public init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
