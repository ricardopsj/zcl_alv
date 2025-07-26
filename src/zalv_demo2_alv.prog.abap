*&---------------------------------------------------------------------*
*& Include          ZALV_DEMO2_ALV
*&---------------------------------------------------------------------*


class lcl_alv_test definition
  inheriting from zcl_alv.
  public section.
    methods create_fieldcat_fill
        redefinition .
    methods create_layout
        redefinition .
  protected section.

  private section.
endclass.

class lcl_alv_test implementation.
  method create_fieldcat_fill.
    " Configurar catálogo de campos
    append value #( fieldname = 'CODE' scrtext_m = 'Código' outputlen = 10 ) to t_fieldcat.
    append value #( fieldname = 'NAME' scrtext_m = 'Nombre Descriptivo' outputlen = 50 ) to t_fieldcat.
  endmethod.
  method create_layout.
    s_layout-info_fname = 'LINE_COLOR'.
  endmethod.
endclass.
