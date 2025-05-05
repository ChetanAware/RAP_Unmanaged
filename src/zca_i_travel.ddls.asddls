@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View to Travel'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zca_i_travel as select from /dmo/travel
 composition [0..*] of zca_i_booking  as _Booking
  association [0..1] to /DMO/I_Agency   as _Agency   on $projection.AgencyId = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer as _Customer on $projection.CustomerId = _Customer.CustomerID
  association [0..1] to I_Currency      as _Currency on $projection.CurrencyCode = _Currency.Currency
//composition of target_data_source_name as _association_name
{

 key travel_id     as TravelId,
      agency_id     as AgencyId,
      customer_id   as CustomerId,
      begin_date    as BeginDate,
      end_date      as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee   as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price   as TotalPrice,
      currency_code as CurrencyCode,
      description   as Description,
      status        as Status,
      createdby     as Createdby,
      createdat     as Createdat,
      lastchangedby as Lastchangedby,
      lastchangedat as Lastchangedat,
      _Booking, // Make association public
      _Agency,
      _Customer,
      _Currency
     
//    _association_name // Make association public
}
