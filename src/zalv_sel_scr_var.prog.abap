*&---------------------------------------------------------------------*
*& Include          ZALV_SEL_SCR_VAR
*&---------------------------------------------------------------------*


selection-screen begin of block variant with frame title text-var.
parameters:  variant type disvariant-variant.
selection-screen end of block variant.


at selection-screen on value-request for variant.
  data: ls_variant  type disvariant
        , lv_canceled type abap_bool.

  ls_variant-report = sy-cprog.
  call function 'LVC_VARIANT_F4'
    exporting
      is_variant    = ls_variant
*     IT_DEFAULT_FIELDCAT =
      i_save        = abap_true
    importing
      e_exit        = lv_canceled
      es_variant    = ls_variant
    exceptions
      not_found     = 1
      program_error = 2
      others        = 3.
  if lv_canceled eq abap_false.
    variant = ls_variant-variant.
  endif.
