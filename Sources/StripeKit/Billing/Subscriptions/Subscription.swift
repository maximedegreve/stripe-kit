//
//  Subscription.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import Foundation

/// The [Subscription Object](https://stripe.com/docs/api/subscriptions/object)
public struct StripeSubscription: Codable {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account.
    public var applicationFeePercent: Decimal?
    /// Determines the date of the first full invoice, and, for plans with `month` or `year` intervals, the day of the month for subsequent invoices.
    public var billingCycleAnchor: Date?
    /// Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period
    public var billingThresholds: StripeSubscriptionBillingThresholds?
    /// If the subscription has been canceled with the `at_period_end` flag set to `true`, `cancel_at_period_end` on the subscription will be `true`. You can use this attribute to determine whether a subscription that has a status of active is scheduled to be canceled at the end of the current period.
    public var cancelAtPeriodEnd: Bool?
    /// A date in the future at which the subscription will automatically get canceled
    public var cancelAt: Date?
    /// If the subscription has been canceled, the date of that cancellation. If the subscription was canceled with `cancel_at_period_end`, `canceled_at` will still reflect the date of the initial cancellation request, not the end of the subscription period when the subscription is automatically moved to a canceled state.
    public var canceledAt: Date?
    /// Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this subscription at the end of the cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions.
    public var collectionMethod: StripeInvoiceCollectionMethod?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date
    /// End of the current period that the subscription has been invoiced for. At the end of this period, a new invoice will be created.
    public var currentPeriodEnd: Date?
    /// Start of the current period that the subscription has been invoiced for.
    public var currentPeriodStart: Date?
    /// ID of the customer who owns the subscription.
    @Expandable<StripeCustomer> public var customer: String?
    /// Number of days a customer has to pay invoices generated by this subscription. This value will be `null` for subscriptions where `billing=charge_automatically`.
    public var daysUntilDue: Int?
    /// ID of the default payment method for the subscription. It must belong to the customer associated with the subscription. If not set, invoices will use the default payment method in the customer’s invoice settings.
    @Expandable<StripePaymentMethod> public var defaultPaymentMethod: String?
    /// ID of the default payment source for the subscription. It must belong to the customer associated with the subscription and be in a chargeable state. If not set, defaults to the customer’s default source.
    @Expandable<StripeSource> public var defaultSource: String?
    /// The tax rates that will apply to any subscription item that does not have `tax_rates` set. Invoices created will have their `default_tax_rates` populated from the subscription.
    public var defaultTaxRates: [StripeTaxRate]?
    /// Describes the current discount applied to this subscription, if there is one. When billing, a discount applied to a subscription overrides a discount applied on a customer-wide basis.
    public var discount: StripeDiscount?
    /// If the subscription has ended, the date the subscription ended.
    public var endedAt: Date?
    /// Settings controlling the behavior of applied customer balances on invoices generated by this subscription.
    public var invoiceCustomerBalanceSettings: StripeSubscriptionInvoiceCustomerBalanceSettings?
    /// List of subscription items, each with an attached plan.
    public var items: StripeSubscriptionItemList?
    /// The most recent invoice this subscription has generated.
    @Expandable<StripeInvoice> public var latestInvoice: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// Specifies the approximate timestamp on which any pending invoice items will be billed according to the schedule provided at `pending_invoice_item_interval`.
    public var nextPendingInvoiceItemInvoice: Date?
    /// If specified, payment collection for this subscription will be paused.
    public var pauseCollection: StripeSubscriptionPauseCollection?
    /// Payment settings passed on to invoices created by the subscription.
    public var paymentSettings: StripeSubscriptionPaymentSettings?
    /// Specifies an interval for how often to bill for any pending invoice items. It is analogous to calling Create an invoice for the given subscription at the specified interval.
    public var pendingInvoiceItemInterval: StripeSubscriptionPendingInvoiceInterval?
    /// You can use this SetupIntent to collect user authentication when creating a subscription without immediate payment or updating a subscription’s payment method, allowing you to optimize for off-session payments. Learn more in the SCA Migration Guide.
    @Expandable<StripePaymentIntent> public var pendingSetupIntent: String?
    /// If specified, [pending updates](https://stripe.com/docs/billing/subscriptions/pending-updates) that will be applied to the subscription once the`latest_invoice` has been paid.
    public var pendingUpdate: StripeSubscriptionPendingUpdate?
    /// The schedule attached to the subscription
    @Expandable<StripeSubscriptionSchedule> public var schedule: String?
    /// Date when the subscription was first created. The date might differ from the `created` date due to backdating.
    public var startDate: Date?
    /// Possible values are `incomplete`, `incomplete_expired`, `trialing`, `active`, `past_due`, `canceled`, or `unpaid`.
    ///
    /// For `collection_method=charge_automatically` a subscription moves into `incomplete` if the initial payment attempt fails. A subscription in this state can only have metadata and `default_source` updated. Once the first invoice is paid, the subscription moves into an active state. If the first invoice is not paid within 23 hours, the subscription transitions to `incomplete_expired`. This is a terminal state, the open invoice will be voided and no further invoices will be generated.
    ///
    /// A subscription that is currently in a trial period is trialing and moves to active when the trial period is over.
    ///
    /// If subscription `collection_method=charge_automatically` it becomes `past_due` when payment to renew it fails and canceled or unpaid (depending on your subscriptions settings) when Stripe has exhausted all payment retry attempts.
    ///
    /// If subscription `collection_method=send_invoice` it becomes `past_due` when its invoice is not paid by the due date, and `canceled` or `unpaid` if it is still not paid by an additional deadline after that. Note that when a subscription has a status of `unpaid`, no subsequent invoices will be attempted (invoices will be created, but then immediately automatically closed). After receiving updated payment information from a customer, you may choose to reopen and pay their closed invoices.
    public var status: StripeSubscriptionStatus?
    /// The account (if any) the subscription’s payments will be attributed to for tax reporting, and where funds from each payment will be transferred to for each of the subscription’s invoices.
    public var transferData: StripeSubscriptionTransferData?
    /// If the subscription has a trial, the end of that trial.
    public var trialEnd: Date?
    /// If the subscription has a trial, the beginning of that trial.
    public var trialStart: Date?
}

public struct StripeSubscriptionBillingThresholds: Codable {
    /// Monetary threshold that triggers the subscription to create an invoice
    public var amountGte: Int?
    /// Indicates if the `billing_cycle_anchor` should be reset when a threshold is reached. If true, `billing_cycle_anchor` will be updated to the date/time the threshold was last reached; otherwise, the value will remain unchanged. This value may not be `true` if the subscription contains items with plans that have `aggregate_usage=last_ever`.
    public var resetBillingCycleAnchor: Bool?
}

public struct StripeSubscriptionPaymentSettings: Codable {
    /// Payment-method-specific configuration to provide to invoices created by the subscription.
    public var paymentMethodOptions: StripeSubscriptionPaymentSettingsPaymentMethodOptions?
    /// The list of payment method types to provide to every invoice created by the subscription. If not set, Stripe attempts to automatically determine the types to use by looking at the invoice’s default payment method, the subscription’s default payment method, the customer’s default payment method, and your invoice template settings.
    public var paymentMethodTypes: [SubscriptionPaymentSettingsPaymentMethodType]?
}

public struct StripeSubscriptionPaymentSettingsPaymentMethodOptions: Codable {
    /// This sub-hash contains details about the Bancontact payment method options to pass to invoices created by the subscription.
    public var bancontact: StripeSubscriptionPaymentSettingsPaymentMethodOptionsBancontact?
    /// This sub-hash contains details about the Card payment method options to pass to invoices created by the subscription.
    public var card: StripeSubscriptionPaymentSettingsPaymentMethodOptionsCard?
}

public struct StripeSubscriptionPaymentSettingsPaymentMethodOptionsBancontact: Codable {
    /// Preferred language of the Bancontact authorization page that the customer is redirected to.
    public var preferredLanguage: String?
}

public struct StripeSubscriptionPaymentSettingsPaymentMethodOptionsCard: Codable {
    /// We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and other requirements. However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Read our guide on manually requesting 3D Secure for more information on how this configuration interacts with Radar and our SCA Engine.
    public var requestThreeDSecure: StripeSubscriptionPaymentSettingsPaymentMethodOptionsCardRequestThreedSecure?
}

public enum StripeSubscriptionPaymentSettingsPaymentMethodOptionsCardRequestThreedSecure: String, Codable {
    /// Triggers 3D Secure authentication only if it is required.
    case automatic
    /// Requires 3D Secure authentication if it is available.
    case any
}

public enum SubscriptionPaymentSettingsPaymentMethodType: String, Codable {
    case achCreditTransfer = "ach_transfer_credit"
    case achDebit = "ach_debit"
    case auBecsDebit = "au_becs_debit"
    case bacsDebit = "bacs_debit"
    case bancontact
    case boleto
    case card
    case eps
    case fpx
    case giropay
    case ideal
    case p24
    case sepaDebit = "sepa_debit"
    case sofort
    case wechatPay = "wechat_pay"
}

public struct StripeSubscriptionPendingInvoiceInterval: Codable {
    /// Specifies invoicing frequency. Either `day`, `week`, `month` or `year`.
    public var interval: StripePlanInterval?
    /// The number of intervals between invoices. For example, `interval=month` and `interval_count=3` bills every 3 months. Maximum of one year interval allowed (1 year, 12 months, or 52 weeks).
    public var intervalCount: Int?
}

public enum StripeSubscriptionStatus: String, Codable {
    case incomplete
    case incompleteExpired = "incomplete_expired"
    case trialing
    case active
    case pastDue = "past_due"
    case canceled
    case unpaid
}

public struct StripeSubscriptionList: Codable {
    public var object: String
    public var hasMore: Bool?
    public var url: String?
    public var data: [StripeSubscription]?
}

public struct StripeSubscriptionInvoiceCustomerBalanceSettings: Codable {
    /// Controls whether a customer balance applied to this invoice should be consumed and not credited or debited back to the customer if voided.
    public var consumeAppliedBalanceOnVoid: Bool?
}

public enum StripeSubscriptionPaymentBehavior: String, Codable {
    /// Use `allow_incomplete` to transition the subscription to `status=past_due` if a payment is required but cannot be paid.
    case allowIncomplete = "allow_incomplete"
    /// Use `error_if_incomplete` if you want Stripe to return an HTTP 402 status code if a subscription’s first invoice cannot be paid.
    case errorIfIncomplete = "error_if_incomplete"
    /// Use `pending_if_incomplete` to update the subscription using pending updates. When you use `pending_if_incomplete` you can only pass the parameters supported by pending updates.
    case pendingIfIncomplete = "pending_if_incomplete"
    /// Use `default_incomplete` to create Subscriptions with `status=incomplete` when the first invoice requires payment, otherwise start as active. Subscriptions transition to `status=active` when successfully confirming the payment intent on the first invoice. This allows simpler management of scenarios where additional user actions are needed to pay a subscription’s invoice. Such as failed payments, SCA regulation, or collecting a mandate for a bank debit payment method. If the payment intent is not confirmed within 23 hours subscriptions transition to `status=incomplete_expired`, which is a terminal state.
    case defaultIncomplete = "default_incomplete"
}

public enum StripeSubscriptionProrationBehavior: String, Codable {
    case createProrations = "create_prorations"
    case none
    case alwaysInvoice = "always_invoice"
}

public struct StripeSubscriptionPendingUpdate: Codable {
    /// If the update is applied, determines the date of the first full invoice, and, for plans with `month` or `year` intervals, the day of the month for subsequent invoices.
    public var billingCycleAnchor: Date?
    /// The point after which the changes reflected by this update will be discarded and no longer applied.
    public var expiresAt: Date?
    /// List of subscription items, each with an attached plan, that will be set if the update is applied.
    public var subscriptionItems: [StripeSubscriptionItem]?
    /// Unix timestamp representing the end of the trial period the customer will get before being charged for the first time, if the update is applied.
    public var trialEnd: Date?
    /// Indicates if a plan’s `trial_period_days` should be applied to the subscription. Setting `trial_end` per subscription is preferred, and this defaults to `false`. Setting this flag to `true` together with `trial_end` is not allowed.
    public var trialFromPlan: Bool?
}

public struct StripeSubscriptionPauseCollection: Codable {
    /// The payment collection behavior for this subscription while paused. One of `keep_as_draft`, `mark_uncollectible`, or `void`.
    public var behavior: StripeSubscriptionPauseCollectionBehavior?
    /// The time after which the subscription will resume collecting payments.
    public var resumesAt: Date?
}

public enum StripeSubscriptionPauseCollectionBehavior: String, Codable {
    case keepAsDraft = "keep_as_draft"
    case markUncollectible = "mark_uncollectible"
    case void
}

public struct StripeSubscriptionTransferData: Codable {
    /// A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice subtotal that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
    public var amountPercent: Int?
    /// The account where funds from the payment will be transferred to upon payment success.
    @Expandable<StripeConnectAccount> public var destination: String?
}
