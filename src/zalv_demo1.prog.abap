*&---------------------------------------------------------------------*
*& Report ZRPS_ALV_TEST1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zalv_demo1.



class zcl_alv_test1 definition
  inheriting from zcl_alv.
  public section.
    methods create_fieldcat_exit
        redefinition .
    methods create_layout
        redefinition .
  protected section.

  private section.
endclass.

class zcl_alv_test1 implementation.
  method create_fieldcat_exit.
    case ref_fieldcat->fieldname.
      when 'SMOKER' or 'INVOICE' or 'CANCELLED' or 'RESERVED'.
        ref_fieldcat->checkbox = abap_true.
        ref_fieldcat->edit = boolc( ref_fieldcat->fieldname eq 'SMOKER' ).
      when 'INVOICE' or 'CANCELLED' or 'RESERVED'.
        ref_fieldcat->checkbox = abap_true.
    endcase.
    if ref_fieldcat->key = abap_true.
      ref_fieldcat->key = abap_false.
    endif.
  endmethod.
  method create_layout.
    s_layout-sel_mode = c-sel_mode-multiple_row_all.
    s_layout-zebra = abap_true.
  endmethod.
endclass.

start-of-selection.
  select *
    into table @data(lt)
    from sbook
  up to 10 rows.

  data(ref_alv) = new zcl_alv_test1( ).
  ref_alv->set_ref_data( ref #( lt ) ).
  ref_alv->show( ).
