@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View for Booking'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zca_i_booking
  as select from /dmo/booking
    association        to parent zca_i_travel as _Travel     on  $projection.TravelId = _Travel.TravelId
  association [1..1] to /DMO/I_Customer      as _Customer   on  $projection.CustomerId = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier       as _Carrier    on  $projection.AirlineId = _Carrier.AirlineID
  association [1..1] to /dmo/connection      as _Connection on  $projection.AirlineId    = _Connection.carrier_id
                                                            and $projection.ConnectionId = _Connection.connection_id
{
  key booking_id    as BookingId,
  key travel_id     as TravelId,
      booking_date  as BookingDate,
      customer_id   as CustomerId,
      carrier_id    as AirlineId,
      connection_id as ConnectionId,
      flight_date   as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price  as FlightPrice,
      currency_code as CurrencyCode,
            _Travel,
            _Customer,
            _Carrier,
            _Connection
}
