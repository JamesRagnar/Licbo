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
        static let addressLine1 = "address_line_1"
        static let addressLine2 = "address_line_2"
        static let city = "city"
        static let fax = "fax"
        static let hasColdBeerRoom = "has_beer_cold_room"
        static let hasBilingualServices = "has_bilingual_services"
        static let hasParking = "has_parking"
        static let hasProductConsultant = "has_product_consultant"
        static let hasSpecialOccasionPermits = "has_special_occasion_permits"
        static let hasTastingBar = "has_tasting_bar"
        static let hasTransitAccess = "has_transit_access"
        static let hasVintagesCorner = "has_vintages_corner"
        static let hasWheelchairAccessability = "has_wheelchair_accessability"
        static let lcboID = "id"
        static let inventoryCount = "inventory_count"
        static let inventoryPriceInCents = "inventory_price_in_cents"
        static let inventoryVolumeInMillileter = "inventory_volume_in_milliliters"
        static let isDead = "is_dead"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let name = "name"
        static let postalCode = "postal_code"
        static let productsCount = "products_count"
        static let storeNo = "store_no"
        static let sundayOpen = "sunday_open"
        static let sundayClose = "sunday_close"
        static let mondayOpen = "monday_open"
        static let mondayClose = "monday_close"
        static let tuesdayOpen = "tuesday_open"
        static let tuesdayClose = "tuesday_close"
        static let wednesdayOpen = "wednesday_open"
        static let wednesdayClose = "wednesday_close"
        static let thursdayOpen = "thursday_open"
        static let thursdayClose = "thursday_close"
        static let fridayOpen = "friday_open"
        static let fridayClose = "friday_close"
        static let saturdayOpen = "saturday_open"
        static let saturdayClose = "saturday_close"
        static let tags = "tags"
        static let telephone = "telephone"
        static let updatedAt = "updated_at"
    }

    public func loadData(from dict: [String: Any]) {
        setValuesForKeys(dict)
    }

    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
