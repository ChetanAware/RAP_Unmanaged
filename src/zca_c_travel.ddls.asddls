@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Travel'
@Metadata.ignorePropagatedAnnotations: false

@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@UI:{
    headerInfo:{
        typeName: 'Travel',
        typeNamePlural: 'Travels',
        title:{
            type: #STANDARD,
            value: 'TravelID'
        }
    }
}

define root view entity zca_c_travel
  as projection on zca_i_travel
{
      @Search.defaultSearchElement: true
  key TravelId,

      @Consumption.valueHelpDefinition: [{
             entity:{
                 name: '/dmo/i_agency',
                 element:'AgencyID'
             }
        }]
      AgencyId,

      @Consumption.valueHelpDefinition: [{
           entity:{
                 name: '/dmo/i_customer',
                 element: 'CustomerID'
           }
       }]
      @Search.defaultSearchElement: true
      CustomerId,
      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,

      @Consumption.valueHelpDefinition: [{
          entity:{
                  name: 'I_Currency',
                  element: 'Currency'
          }
         }]
      @Search.defaultSearchElement: true
      CurrencyCode,
      Description,
      Status,
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      /* Associations */
      _Agency,
      _Booking : redirected to composition child zca_c_booking,
      _Currency,
      _Customer
}
