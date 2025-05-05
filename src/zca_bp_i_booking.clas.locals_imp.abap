CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Booking.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Booking.

    METHODS read FOR READ
      IMPORTING keys FOR READ Booking RESULT result.

    METHODS rba_Travel FOR READ
      IMPORTING keys_rba FOR READ Booking\_Travel FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD update.

    DATA: lt_msg TYPE /dmo/t_message.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_booking>).
      DATA(ls_booking) = CORRESPONDING /dmo/booking( <lfs_booking> MAPPING FROM ENTITY ).

      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_UPDATE'
        EXPORTING
          is_travel   = VALUE /dmo/s_travel_in( travel_id = <lfs_booking>-TravelId )
          is_travelx  = VALUE /dmo/s_travel_inx( travel_id = <lfs_booking>-TravelId )
          it_booking  = VALUE /dmo/t_booking_in( ( CORRESPONDING #( ls_booking ) ) )
          it_bookingx = VALUE /dmo/t_booking_inx(
                                              ( booking_id  = <lfs_booking>-BookingId
                                                _intx       = CORRESPONDING #( <lfs_booking> MAPPING FROM ENTITY
                                              )
                                                action_code = /dmo/if_flight_legacy=>action_code-update

                             )
      )
        IMPORTING
          et_messages = lt_msg.

      "Pass data back to UI
      INSERT VALUE #(
                        %cid      = <lfs_booking>-%cid_ref
                        travelid  = <lfs_booking>-TravelId
                        bookingid = <lfs_booking>-BookingId
      ) INTO TABLE mapped-booking.

      LOOP AT lt_msg INTO DATA(ls_msg) WHERE msgty CA 'EA'.

        APPEND VALUE #(
                %cid      = <lfs_booking>-%cid_ref
                travelid  = <lfs_booking>-TravelId
                bookingid = <lfs_booking>-BookingId
        ) TO failed-booking.

        APPEND VALUE #(

                   %msg           = new_message(
                   id       = ls_msg-msgid
                   number   = ls_msg-msgno
                   severity = if_abap_behv_message=>severity-error
                   v1       = ls_msg-msgv1
                   v2       = ls_msg-msgv2
                   v3       = ls_msg-msgv3
                   v4       = ls_msg-msgv4
                   )
                   %cid           = <lfs_booking>-%cid_ref
                   %key-travelid  = <lfs_booking>-TravelId
                   %key-bookingid = <lfs_booking>-BookingId
                   %update        = 'X'
                   travelid       = <lfs_booking>-TravelId
                   bookingid      = <lfs_booking>-BookingId


        ) TO reported-booking.

      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

  METHOD delete.

    DATA: lt_msg TYPE /dmo/t_message.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<lfs_booking>).

      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_UPDATE'
        EXPORTING
          is_travel   = VALUE /dmo/s_travel_in( travel_id = <lfs_booking>-TravelId )
          is_travelx  = VALUE /dmo/s_travel_inx( travel_id = <lfs_booking>-TravelId )
          it_booking  = VALUE /dmo/t_booking( ( booking_id = <lfs_booking>-BookingId ) )
          it_bookingx = VALUE /dmo/t_booking_inx(
                                              ( booking_id  = <lfs_booking>-BookingId
                                                action_code = /dmo/if_flight_legacy=>action_code-delete
                                              )

      )
        IMPORTING
          et_messages = lt_msg.

      IF lt_msg IS NOT INITIAL.

        LOOP AT lt_msg INTO DATA(ls_msg) WHERE msgty CA 'EA'.

          APPEND VALUE #(
                  %cid      = <lfs_booking>-%cid_ref
                  travelid  = <lfs_booking>-TravelId
                  bookingid = <lfs_booking>-BookingId
          ) TO failed-booking.

          APPEND VALUE #(

                     %msg           = new_message(
                     id       = ls_msg-msgid
                     number   = ls_msg-msgno
                     severity = if_abap_behv_message=>severity-error
                     v1       = ls_msg-msgv1
                     v2       = ls_msg-msgv2
                     v3       = ls_msg-msgv3
                     v4       = ls_msg-msgv4
                     )
                     %cid           = <lfs_booking>-%cid_ref
                     %key-travelid  = <lfs_booking>-TravelId
                     %key-bookingid = <lfs_booking>-BookingId
                     %delete        = 'X'
                     travelid       = <lfs_booking>-TravelId
                     bookingid      = <lfs_booking>-BookingId


          ) TO reported-booking.

        ENDLOOP.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Travel.
  ENDMETHOD.

ENDCLASS.
