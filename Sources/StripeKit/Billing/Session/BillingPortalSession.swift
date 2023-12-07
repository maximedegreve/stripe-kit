//
//  BillingPortalSession.swift
//
//
//  Created by Bruno Alves on 06/12/23.
//

import Foundation

/// DOC: - https://stripe.com/docs/api/customer_portal/sessions/object
public struct BillingPortalSession: StripeModel {
    let id: String
    let object: String
    let configuration: String
    let created: Date
    let customer: String
    let livemode: Bool
    let onBehalfOf: String?
    let returnURL: String?
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, object, configuration, created, customer, livemode
        case onBehalfOf = "on_behalf_of"
        case returnURL = "return_url"
        case url
    }
}
