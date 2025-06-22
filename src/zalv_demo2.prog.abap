*&---------------------------------------------------------------------*
*& Report ZALV_DEMO2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zalv_demo2.

include zalv_demo2_alv.

start-of-selection.

  " Definir estructura de datos
  types: begin of ty_data,
           code       type char4,       " Código Cxyz
           name       type string,      " Nombre descriptivo
           line_color type char4, " Campo para color de línea
         end of ty_data.

  data: lt_data     type table of ty_data,
        ls_data     type ty_data,
        lt_fieldcat type lvc_t_fcat,
        ls_fieldcat type lvc_s_fcat,
        ls_layout   type lvc_s_layo,
        lo_grid     type ref to cl_gui_alv_grid.

  " Generar todas las combinaciones de Cxyz

start-of-selection.
  data: lv_x           type n,
        lv_y           type n,
        lv_z           type n,
        lv_code        type char4,
        lv_color_name  type string,
        lv_intensified type string,
        lv_inverse     type string.

  " Iterar sobre x (1 a 7), y (0 a 1), z (0 a 1)
  do 7 times.
    lv_x = sy-index. " Color base
    do 2 times.
      lv_y = sy-index - 1. " Intensificación
      do 2 times.
        lv_z = sy-index - 1. " Inversión

        " Construir código Cxyz
        concatenate 'C' lv_x lv_y lv_z into lv_code.

        " Determinar nombre del color base
        case lv_x.
          when 1.
            lv_color_name = 'Celeste'.
          when 2.
            lv_color_name = 'Gris'.
          when 3.
            lv_color_name = 'Amarillo'.
          when 4.
            lv_color_name = 'Azul'.
          when 5.
            lv_color_name = 'Verde'.
          when 6.
            lv_color_name = 'Rojo'.
          when 7.
            lv_color_name = 'Naranjo'.
        endcase.

        " Agregar intensificación al nombre
        if lv_y = 0.
          lv_intensified = ''.
        else.
          lv_intensified = 'Intenso'.
        endif.

        " Agregar inversión al nombre
        if lv_z = 0.
          lv_inverse = ''.
        else.
          lv_inverse = ', texto inverso'.
        endif.

        " Construir nombre descriptivo
        concatenate lv_color_name lv_intensified lv_inverse into ls_data-name separated by ' '.

        " Llenar datos
        ls_data-code = lv_code.
        ls_data-line_color = lv_code.
        append ls_data to lt_data.
      enddo.
    enddo.
  enddo.

  data(ref_alv) = new lcl_alv_test( ).
  ref_alv->set_ref_data( ref #( lt_data ) ).
  ref_alv->show( ).
