@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Booking'
@Metadata.ignorePropagatedAnnotations: false

@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity zca_c_booking
  as projection on zca_i_booking
{
      @Search.defaultSearchElement: true
  key BookingId,
  key TravelId,
      BookingDate,

      @Consumption.valueHelpDefinition: [{
            entity:{
                  name: '/dmo/i_customer',
                  element: 'CustomerID'
            }
        }]
      @Search.defaultSearchElement: true
      CustomerId,

      @Consumption.valueHelpDefinition: [{
            entity:{
                  name: '/DMO/I_Carrier',
                  element: 'AirlineID'
            }
        }]
      @Search.defaultSearchElement: true
      AirlineId,

      @Consumption.valueHelpDefinition: [{
            entity:{
                  name: '/DMO/I_Connection',
                  element: 'ConnectionID'
            },
            additionalBinding: [
                    { localElement: 'FlightDate', element: 'FlightDate'},
                    { localElement: 'AirlineID', element: 'AirlineID'},
                    { localElement: 'FlightPrice', element: 'Price'},
                    { localElement: 'CurrencyCode', element: 'CurrencyCode'}
            ]
        }]
      @Search.defaultSearchElement: true
      ConnectionId,
      FlightDate,
      FlightPrice,

      @Consumption.valueHelpDefinition: [{
          entity:{
                  name: 'I_Currency',
                  element: 'Currency'
          }
         }]
      @Search.defaultSearchElement: true
      CurrencyCode,
      /* Associations */
      _Carrier,
      _Connection,
      _Customer,
      _Travel : redirected to parent zca_c_travel
}
