class ZCL_ALV definition
  public
  create public .

public section.

  data:
    begin of s_actvt
        , actvt type tact-actvt
        , ltext type tactt-ltext
        , end of s_actvt .
  constants:
    begin of c
                            , begin of line_color
                              , celeste              type char4 value 'C100' " Celeste
                              , celeste_inv          type char4 value 'C101' " Celeste, texto inverso
                              , celeste_intenso      type char4 value 'C110' " Celeste Intenso
                              , celeste_intenso_inv  type char4 value 'C111' " Celeste Intenso, texto inverso
                              , gris                 type char4 value 'C200' " Gris
                              , gris_inv             type char4 value 'C201' " Gris, texto inverso
                              , gris_intenso         type char4 value 'C210' " Gris Intenso
                              , gris_intenso_inv     type char4 value 'C211' " Gris Intenso, texto inverso
                              , amarillo             type char4 value 'C300' " Amarillo
                              , amarillo_inv         type char4 value 'C301' " Amarillo, texto inverso
                              , amarillo_intenso     type char4 value 'C310' " Amarillo Intenso
                              , amarillo_intenso_inv type char4 value 'C311' " Amarillo Intenso, texto inverso
                              , azul                 type char4 value 'C400' " Azul
                              , azul_inv             type char4 value 'C401' " Azul, texto inverso
                              , azul_intenso         type char4 value 'C410' " Azul Intenso
                              , azul_intenso_inv     type char4 value 'C411' " Azul Intenso, texto inverso
                              , verde                type char4 value 'C500' " Verde
                              , verde_inv            type char4 value 'C501' " Verde, texto inverso
                              , verde_intenso        type char4 value 'C510' " Verde Intenso
                              , verde_intenso_inv    type char4 value 'C511' " Verde Intenso, texto inverso
                              , rojo                 type char4 value 'C600' " Rojo
                              , rojo_inv             type char4 value 'C601' " Rojo, texto inverso
                              , rojo_intenso         type char4 value 'C610' " Rojo Intenso
                              , rojo_intenso_inv     type char4 value 'C611' " Rojo Intenso, texto inverso
                              , naranjo              type char4 value 'C700' " Naranjo
                              , naranjo_inv          type char4 value 'C701' " Naranjo, texto inverso
                              , naranjo_intenso      type char4 value 'C710' " Naranjo Intenso
                              , naranjo_intenso_inv  type char4 value 'C711' " Naranjo Intenso, texto inverso
                            , end of line_color
                            , begin of fcode
                              , detail type ui_func value '&DETAIL' " Detalle
                              , refresh type ui_func value '&REFRESH' " Refrescar
                              , cut type ui_func value '&LOCAL&CUT' " Cortar
                              , copy type ui_func value '&LOCAL&COPY' " Copiar
                              , paste type ui_func value '&LOCAL&PASTE' " pegar
                              , undo type ui_func value '&LOCAL&UNDO' " Deshacer, undo TYPE ui_func VALUE '&LOCAL&UNDO' " Deshacer
                              , append_lines type ui_func value '&LOCAL&APPEND' " Añadir líneas, append_lines TYPE ui_func VALUE '&LOCAL&APPEND' " Añadir líneas
                              , insert_row type ui_func value '&LOCAL&INSERT_ROW' " Insertar línea, insert_row TYPE ui_func VALUE '&LOCAL&INSERT_ROW' " Insertar línea
                              , duplicate_row type ui_func value `&LOCAL&COPY_ROW` " Dupilcar Linea
                              , delete_row type ui_func value '&LOCAL&DELETE_ROW' " Borrar línea, delete_row TYPE ui_func VALUE '&LOCAL&DELETE_ROW' " Borrar línea
                              , sort_asc type ui_func value '&SORT_ASC' " Clasific.ascendente, sort_asc TYPE ui_func VALUE '&SORT_ASC' " Clasific.ascendente
                              , sort_desc type ui_func value '&SORT_DSC' " Clasific.descendente, sort_desc TYPE ui_func VALUE '&SORT_DSC' " Clasific.descendente
                              , find type ui_func value '&FIND' " Buscar..., find TYPE ui_func VALUE '&FIND' " Buscar...
                              , find_more type ui_func value '&FIND_MORE' " Continuar búsqueda, find_more TYPE ui_func VALUE '&FIND_MORE' " Continuar búsqueda
                              , filter type ui_func value '&MB_FILTER' " Fijar filtro..., filter TYPE ui_func VALUE '&MB_FILTER' " Fijar filtro...
                              , sum type ui_func value '&MB_SUM' " Total, sum TYPE ui_func VALUE '&MB_SUM' " Total
                              , subtotals type ui_func value '&MB_SUBTOT' " Subtotales, subtotals TYPE ui_func VALUE '&MB_SUBTOT' " Subtotales
                              , print type ui_func value '&PRINT_BACK' " Impr., print TYPE ui_func VALUE '&PRINT_BACK' " Impr.
                              , views type ui_func value '&MB_VIEW' " Vistas, views TYPE ui_func VALUE '&MB_VIEW' " Vistas
                              , export type ui_func value '&MB_EXPORT' " Exportar, export TYPE ui_func VALUE '&MB_EXPORT' " Exportar
                              , layout type ui_func value '&COL0' " Modificar disposición..., layout TYPE ui_func VALUE '&COL0' " Modificar disposición...
                              , documentation type ui_func value '&INFO' " Documentación usuario END OF fcode., documentation TYPE ui_func VALUE '&INFO' " Documentación usuario END OF fcode.
                            , end of fcode
                            , begin of sel_mode
                               , multiple_row_col    type lvc_libox value 'A' " Selección múltiple de filas y columnas con botones de selección
                               , single              type lvc_libox value 'B' " Selección simple (tipo listbox), permite seleccionar solo una fila o columna
                               , multiple_row_no_btn type lvc_libox value 'C' " Selección múltiple de filas sin botones de selección
                               , multiple_row_all    type lvc_libox value 'D' " Selección múltiple de filas con botones de selección y "Seleccionar todo"
                             , end of sel_mode
                             , begin of rowtype
                               , normal   type lvc_rtype value ' '
                               , total    type lvc_rtype value 'T'
                               , subtotal type lvc_rtype value 'S'
                               , locked   type lvc_rtype value 'L'
                             , end of rowtype
                            , end of c .
  data LINE_DDIC_TYPE type TYPENAME .
  data REF_ALV_CHANGED_DATA_PROTOCOL type ref to CL_ALV_CHANGED_DATA_PROTOCOL .
  data REF_CONTAINER type ref to CL_GUI_CONTAINER .
  data REF_DATA type ref to DATA .
  data REF_GRID type ref to CL_GUI_ALV_GRID .
  data REF_GUI_TIMER type ref to CL_GUI_TIMER .
  data REF_LINE_DESCR type ref to CL_ABAP_STRUCTDESCR .
  data REF_TABLE_DESCR type ref to CL_ABAP_TABLEDESCR .
  data S_LAYOUT type LVC_S_LAYO .
  data T_FIELDCAT type LVC_T_FCAT .
  data T_GRID_EXCLUDING type UI_FUNCTIONS .
  data T_PROGRAM_EXCLUDING type UI_FUNCTIONS .
  data S_VARIANT type DISVARIANT .

  methods CREATE .
  methods CREATE_FIELDCAT .
  methods CREATE_FIELDCAT_EXIT
    importing
      !REF_FIELDCAT type ref to LVC_S_FCAT .
  methods CREATE_FIELDCAT_FILL .
  methods CREATE_LAYOUT .
  methods CREATE_REGISTER_EVENTS .
  methods DISPLAY .
  methods DISPLAY_EX_BTN .
  methods DISPLAY_GRID .
  methods DISPLAY_PF_STATUS .
  methods GET_SELECTED_ROWS
    returning
      value(RT_ROWS) type ZALV_T_ROW .
  methods ON_BUTTON_CLICK
    for event BUTTON_CLICK of CL_GUI_ALV_GRID
    importing
      !ES_COL_ID
      !ES_ROW_NO .
  methods ON_DATA_CHANGED
    for event DATA_CHANGED of CL_GUI_ALV_GRID
    importing
      !ER_DATA_CHANGED
      !E_ONF4
      !E_ONF4_BEFORE
      !E_ONF4_AFTER
      !E_UCOMM .
  methods ON_DATA_CHANGED_FINISHED
    for event DATA_CHANGED_FINISHED of CL_GUI_ALV_GRID
    importing
      !E_MODIFIED
      !ET_GOOD_CELLS .
  methods ON_DOUBLE_CLICK
    for event DOUBLE_CLICK of CL_GUI_ALV_GRID .
  methods ON_HOTSPOT_CLICK
    for event HOTSPOT_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW_ID
      !E_COLUMN_ID
      !ES_ROW_NO .
  methods ON_TOOLBAR
    for event TOOLBAR of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_INTERACTIVE .
  methods ON_USER_COMMAND
    for event USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM .
  methods ON_USER_COMMAND_BEFORE
    for event BEFORE_USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM .
  methods PAI .
  methods SET_CONTAINER
    importing
      !REF_CONTAINER type ref to CL_GUI_CONTAINER .
  methods SET_REF_DATA
    importing
      !REF_DATA type ref to DATA .
  methods SHOW .
  methods SET_ACTVT
    importing
      !ACTVT type CLIKE .
  methods REFRESH_DISPLAY .
  methods SET_VARIANT
    importing
      !REPORT type REPID default SY-CPROG
      !HANDLE type SLIS_HANDL optional
      !LOG_GROUP type SLIS_LOGGR optional
      !USERNAME type SLIS_USER default SY-UNAME
      !VARIANT type SLIS_VARI optional
      !TEXT type SLIS_VARBZ optional
      !DEPENDVARS type SLIS_DEPVS optional .
  protected section.
  private section.
ENDCLASS.



CLASS ZCL_ALV IMPLEMENTATION.


  method create.
    if ref_container is initial.
      ref_grid = new cl_gui_alv_grid( cl_gui_container=>screen0 ).
    else.
      ref_grid = new cl_gui_alv_grid( ref_container ).
    endif.
    create_fieldcat( ).
    create_layout( ).
    create_register_events( ).
  endmethod.


  method create_fieldcat.
    create_fieldcat_fill( ).
    loop at t_fieldcat reference into data(ref_fieldcat).
      ref_fieldcat->col_pos = sy-tabix.
      ref_fieldcat->tabname = line_ddic_type.
      ref_fieldcat->col_opt = abap_true.
      create_fieldcat_exit( ref_fieldcat ).
    endloop.
  endmethod.


  method create_fieldcat_exit.
  endmethod.


  method create_fieldcat_fill.
    call function 'LVC_FIELDCATALOG_MERGE'
      exporting
        i_structure_name       = line_ddic_type
      changing
        ct_fieldcat            = t_fieldcat
      exceptions
        inconsistent_interface = 1
        program_error          = 2
        others                 = 3.
    if sy-subrc <> 0.
      message id sy-msgid
            type sy-msgty
          number sy-msgno
            with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      leave program.
    endif.
  endmethod.


  method create_layout.
*    ls_layout-cwidth_opt = 'X'.
*    ls_layout-edit = 'X'.
*    ls_layout-grid_title = 'My Titlebar'(300).              "#EC NOTEXT
*    ls_layout-no_toolbar = 'X'.
*    ls_layout-no_vgridln = 'X'.
*    ls_layout-no_hgridln = 'X'.
*    ls_layout-no_merging = 'X'.
*    if p_lights = 'X' or p_lightc = 'X'.
*      ls_layout-excp_fname = p_lignam.
*    else.
*      ls_layout-excp_fname = space.
*    endif.
*    if p_s_defa = 'X'.
*      ls_layout-sel_mode = space.
*    endif.
*    if p_s_lbnf = 'X'.
*      ls_layout-sel_mode = 'D'.
*    endif.
*    if p_s_lbno = 'X'.
*      ls_layout-sel_mode = 'A'.
*    endif.
*    if p_s_lbsi = 'X'.
*      ls_layout-sel_mode = 'B'.
*    endif.
*    if p_s_lbmu = 'X'.
*      ls_layout-sel_mode = 'C'.
*    endif.
*    if p_cells = 'X'.
*      ls_layout-ctab_fname = 'COLINFO'.
*    else.
*      ls_layout-ctab_fname = space.
*    endif.
*    ls_layout-info_fname = 'INFO'.
*    ls_layout-no_headers = abap_true.
*    ls_layout-no_rowmark = abap_true.
*    ls_layout-excp_conds = p_lightc.
*    ls_layout-totals_bef = p_totbef.
*    ls_layout-excp_led = p_diode.
*    ls_layout-weblook = p_webm.
*    ls_layout-webstyle = p_webs.
*    ls_layout-webrows = p_webr.
*    ls_layout-webxwidth = p_webxw.
*    ls_layout-webxheight = p_webxh.
*     ls_layout-no_toolbar = 'X'.
  endmethod.


  method create_register_events.
    " Registrar eventos para edición
    set handler on_button_click for ref_grid.
    set handler on_data_changed for ref_grid.
    set handler on_data_changed_finished for ref_grid.
    set handler on_double_click for ref_grid.
    set handler on_hotspot_click for ref_grid.
    set handler on_toolbar for ref_grid.
    set handler on_user_command for ref_grid.
    set handler on_user_command_before for ref_grid.

    ref_grid->register_edit_event( cl_gui_alv_grid=>mc_evt_modified ).
    ref_grid->register_edit_event( cl_gui_alv_grid=>mc_evt_enter ).
    ref_grid->set_ready_for_input( 1 ).
  endmethod.


  method display.
    display_ex_btn( ).
    display_pf_status( ).
    display_grid( ).
  endmethod.


  method display_ex_btn.
    "Excluir Botones de la Toolbar del Programa
*    append 'ELIMINAR' to t_program_excluding.
    "Ecluir Botones de La Grilla
*    append cl_gui_alv_grid=>mc_fc_auf to t_toolbar_excluding.                          " Análisis de órdenes
*    append cl_gui_alv_grid=>mc_fc_average to t_toolbar_excluding.                      " Calcular promedio
**   append cl_gui_alv_grid=>mc_fc_back_classic to t_toolbar_excluding.                 " Retroceder (clásico)
*    append cl_gui_alv_grid=>mc_fc_call_abc to t_toolbar_excluding.                     " Análisis ABC
*    append cl_gui_alv_grid=>mc_fc_call_chain to t_toolbar_excluding.                   " Llamar cadena
*    append cl_gui_alv_grid=>mc_fc_call_crbatch to t_toolbar_excluding.                 " Llamar Crystal Batch
*    append cl_gui_alv_grid=>mc_fc_call_crweb to t_toolbar_excluding.                   " Llamar Crystal Web
*    append cl_gui_alv_grid=>mc_fc_call_lineitems to t_toolbar_excluding.               " Llamar ítems de línea
*    append cl_gui_alv_grid=>mc_fc_call_master_data to t_toolbar_excluding.             " Llamar datos maestros
*    append cl_gui_alv_grid=>mc_fc_call_more to t_toolbar_excluding.                    " Llamar más
*    append cl_gui_alv_grid=>mc_fc_call_report to t_toolbar_excluding.                  " Llamar informe
*    append cl_gui_alv_grid=>mc_fc_call_xint to t_toolbar_excluding.                    " Integración externa
*    append cl_gui_alv_grid=>mc_fc_call_xml_export to t_toolbar_excluding.              " Exportar a XML
**    append cl_gui_alv_grid=>mc_fc_call_xxl to t_toolbar_excluding.                     " Exportar a XXL
*    append cl_gui_alv_grid=>mc_fc_check to t_toolbar_excluding.                        " Verificar entradas
**    append cl_gui_alv_grid=>mc_fc_col_invisible to t_toolbar_excluding.                " Hacer columna invisible
**    append cl_gui_alv_grid=>mc_fc_col_optimize to t_toolbar_excluding.                 " Optimizar columnas
**    append cl_gui_alv_grid=>mc_fc_count to t_toolbar_excluding.                        " Contar
**    append cl_gui_alv_grid=>mc_fc_current_variant to t_toolbar_excluding.              " Variante actual
*    append cl_gui_alv_grid=>mc_fc_data_save to t_toolbar_excluding.                    " Guardar datos
**    append cl_gui_alv_grid=>mc_fc_delete_filter to t_toolbar_excluding.                " Eliminar filtro
*    append cl_gui_alv_grid=>mc_fc_deselect_all to t_toolbar_excluding.                 " Deseleccionar todo
*    append cl_gui_alv_grid=>mc_fc_detail to t_toolbar_excluding.                       " Detalle
*    append cl_gui_alv_grid=>mc_fc_excl_all to t_toolbar_excluding.                     " Excluir todas funciones
*    append cl_gui_alv_grid=>mc_fc_expcrdata to t_toolbar_excluding.                    " Exportar datos Crystal
*    append cl_gui_alv_grid=>mc_fc_expcrdesig to t_toolbar_excluding.                   " Exportar diseño Crystal
*    append cl_gui_alv_grid=>mc_fc_expcrtempl to t_toolbar_excluding.                   " Exportar plantilla Crystal
*    append cl_gui_alv_grid=>mc_fc_expmdb to t_toolbar_excluding.                       " Exportar a MDB
**    append cl_gui_alv_grid=>mc_fc_extend to t_toolbar_excluding.                       " Extender
*    append cl_gui_alv_grid=>mc_fc_f4 to t_toolbar_excluding.                           " Ayuda F4
**    append cl_gui_alv_grid=>mc_fc_filter to t_toolbar_excluding.                       " Establecer filtro
*    append cl_gui_alv_grid=>mc_fc_find to t_toolbar_excluding.                         " Buscar
*    append cl_gui_alv_grid=>mc_fc_find_more to t_toolbar_excluding.                    " Buscar más
*    append cl_gui_alv_grid=>mc_fc_fix_columns to t_toolbar_excluding.                  " Fijar columnas
*    append cl_gui_alv_grid=>mc_fc_graph to t_toolbar_excluding.                        " Mostrar gráfico
*    append cl_gui_alv_grid=>mc_fc_help to t_toolbar_excluding.                         " Ayuda
*    append cl_gui_alv_grid=>mc_fc_html to t_toolbar_excluding.                         " Exportar a HTML
**    append cl_gui_alv_grid=>mc_fc_info to t_toolbar_excluding.                         " Información del sistema
**    append cl_gui_alv_grid=>mc_fc_load_variant to t_toolbar_excluding.                 " Cargar variante
*    append cl_gui_alv_grid=>mc_fc_loc_append_row to t_toolbar_excluding.               " Agregar fila
*    append cl_gui_alv_grid=>mc_fc_loc_copy to t_toolbar_excluding.                     " Copiar
*    append cl_gui_alv_grid=>mc_fc_loc_copy_row to t_toolbar_excluding.                 " Copiar fila
*    append cl_gui_alv_grid=>mc_fc_loc_cut to t_toolbar_excluding.                      " Cortar
*    append cl_gui_alv_grid=>mc_fc_loc_delete_row to t_toolbar_excluding.               " Eliminar fila
*    append cl_gui_alv_grid=>mc_fc_loc_insert_row to t_toolbar_excluding.               " Insertar fila
*    append cl_gui_alv_grid=>mc_fc_loc_move_row to t_toolbar_excluding.                 " Mover fila
*    append cl_gui_alv_grid=>mc_fc_loc_paste to t_toolbar_excluding.                    " Pegar
*    append cl_gui_alv_grid=>mc_fc_loc_paste_new_row to t_toolbar_excluding.            " Pegar nueva fila
*    append cl_gui_alv_grid=>mc_fc_loc_undo to t_toolbar_excluding.                     " Deshacer
**    append cl_gui_alv_grid=>mc_fc_maintain_variant to t_toolbar_excluding.             " Mantener variante
*    append cl_gui_alv_grid=>mc_fc_maximum to t_toolbar_excluding.                      " Máximo
*    append cl_gui_alv_grid=>mc_fc_minimum to t_toolbar_excluding.                      " Mínimo
*    append cl_gui_alv_grid=>mc_fc_pc_file to t_toolbar_excluding.                      " Exportar a archivo local
*    append cl_gui_alv_grid=>mc_fc_print to t_toolbar_excluding.                        " Imprimir
*    append cl_gui_alv_grid=>mc_fc_print_back to t_toolbar_excluding.                   " Imprimir fondo
*    append cl_gui_alv_grid=>mc_fc_print_prev to t_toolbar_excluding.                   " Vista previa de impresión
*    append cl_gui_alv_grid=>mc_fc_refresh to t_toolbar_excluding.                      " Actualizar
*    append cl_gui_alv_grid=>mc_fc_reprep to t_toolbar_excluding.                       " Repetir preparación
**    append cl_gui_alv_grid=>mc_fc_save_variant to t_toolbar_excluding.                 " Guardar variante
*    append cl_gui_alv_grid=>mc_fc_select_all to t_toolbar_excluding.                   " Seleccionar todo
*    append cl_gui_alv_grid=>mc_fc_send to t_toolbar_excluding.                         " Enviar
**    append cl_gui_alv_grid=>mc_fc_separator to t_toolbar_excluding.                    " Separador
**    append cl_gui_alv_grid=>mc_fc_sort to t_toolbar_excluding.                         " Ordenar
**    append cl_gui_alv_grid=>mc_fc_sort_asc to t_toolbar_excluding.                     " Ordenar ascendente
**    append cl_gui_alv_grid=>mc_fc_sort_dsc to t_toolbar_excluding.                     " Ordenar descendente
*    append cl_gui_alv_grid=>mc_fc_subtot to t_toolbar_excluding.                       " Subtotales
*    append cl_gui_alv_grid=>mc_fc_sum to t_toolbar_excluding.                          " Totales
*    append cl_gui_alv_grid=>mc_fc_to_office to t_toolbar_excluding.                    " Exportar a Office
*    append cl_gui_alv_grid=>mc_fc_to_rep_tree to t_toolbar_excluding.                  " Transferir a árbol de informes
*    append cl_gui_alv_grid=>mc_fc_unfix_columns to t_toolbar_excluding.                " Liberar columnas
*    append cl_gui_alv_grid=>mc_fc_url_copy_to_clipboard to t_toolbar_excluding.        " Copiar URL al portapapeles
**    append cl_gui_alv_grid=>mc_fc_variant_admin to t_toolbar_excluding.                " Administrar variantes
**    append cl_gui_alv_grid=>mc_fc_views to t_toolbar_excluding.                        " Cambiar vistas
*    append cl_gui_alv_grid=>mc_fc_view_crystal to t_toolbar_excluding.                 " Vista Crystal
*    append cl_gui_alv_grid=>mc_fc_view_excel to t_toolbar_excluding.                   " Vista Excel
*    append cl_gui_alv_grid=>mc_fc_view_grid to t_toolbar_excluding.                    " Vista cuadrícula
*    append cl_gui_alv_grid=>mc_fc_view_lotus to t_toolbar_excluding.                   " Vista Lotus
*    append cl_gui_alv_grid=>mc_fc_word_processor to t_toolbar_excluding.               " Procesador de textos
*    append cl_gui_alv_grid=>mc_fg_edit to t_toolbar_excluding.                         " Editar
*    append cl_gui_alv_grid=>mc_fg_sort to t_toolbar_excluding.                         " Ordenar (función grupo)
  endmethod.


  method display_grid.
    field-symbols: <lt> type any table.

    assign ref_data->* to <lt>.

    s_variant-report = sy-cprog.

    call method ref_grid->set_table_for_first_display
      exporting
        it_toolbar_excluding = t_grid_excluding
        i_structure_name     = line_ddic_type
        is_variant           = s_variant
        is_layout            = s_layout
        i_save               = 'A' "A: Todas, U: Solo usuario, X: Global
        I_DEFAULT            = abap_True "Muestra la variante por defecto
      changing
        it_fieldcatalog      = t_fieldcat
        it_outtab            = <lt>.
  endmethod.


  method display_pf_status.
    set pf-status 'ZSTATUS' of program 'SAPLZALV_FG'.
  endmethod.


  method get_selected_rows.
    data: lt_rows type lvc_t_row.
    field-symbols: <lt> type standard table.

    assign ref_data->* to <lt>.
    ref_grid->get_selected_rows( importing et_index_rows = lt_rows ).
    loop at lt_rows assigning field-symbol(<ls_rows>).
      if <ls_rows>-rowtype(1) eq c-rowtype-normal.
        append initial line to rt_rows assigning field-symbol(<rs_rows>).
        <rs_rows>-index = <ls_rows>-index.
        read table <lt> index <rs_rows>-index reference into <rs_rows>-ref_row.
      endif.
    endloop.
  endmethod.


  method ON_BUTTON_CLICK.
  endmethod.


  method on_data_changed.
  endmethod.


  method ON_DATA_CHANGED_FINISHED.
  endmethod.


  method ON_DOUBLE_CLICK.
  endmethod.


  method on_hotspot_click.
* E_ROW_ID-ROWTYPE
* E_ROW_ID-INDEX
* E_COLUMN_ID-FIELDNAME
* E_COLUMN_ID-HIERLEVEL
* ES_ROW_NOROW_ID
* ES_ROW_NO-SUB_ROW_ID
    data: lt_grouplevels type lvc_t_grpl
          , dsd type int4
          , hst type int4.

    " Obtener subtotales
    call method ref_grid->get_subtotals
      importing
        et_grouplevels = lt_grouplevels.

    case e_row_id-rowtype(1).
      when c-rowtype-normal.
        dsd = hst = es_row_no-row_id.
      when c-rowtype-subtotal.
        data(subtotal_index) = - es_row_no-row_id.
        read table lt_grouplevels index subtotal_index reference into data(ref_grouplevels).
        dsd = ref_grouplevels->index_from.
        hst = ref_grouplevels->index_to.
      when c-rowtype-total.
        field-symbols: <lt> type any table.
        assign ref_data->* to <lt>.
        dsd = 1.
        hst = lines( <lt> ).
    endcase.
    if dsd is not initial and hst is not initial.
      data(method) = 'NAV_' && e_column_id-fieldname.
      try.
          call method me->(method)
            exporting
               dsd = dsd
               hst = hst.
        catch cx_root into data(ref_cx_root).
      endtry.
    endif.
  endmethod.


  method on_toolbar.
    delete e_object->mt_toolbar
     where function eq c-fcode-append_lines
        or function eq c-fcode-copy
        or function eq c-fcode-cut
        or function eq c-fcode-paste
        or function eq c-fcode-delete_row
        or function eq c-fcode-documentation
        or function eq c-fcode-duplicate_row
        or function eq c-fcode-insert_row
        or function eq c-fcode-print
        or function eq c-fcode-refresh
        or function eq c-fcode-undo
        or function eq c-fcode-views
*        or function eq c-fcode-export
        or function eq c-fcode-duplicate_row
        or function eq c-fcode-detail
        .
  endmethod.


  method on_user_command.
    data(method_name) = 'OK_' && e_ucomm.
    data(lt_rows) = get_selected_rows( ).
    try.
        call method (method_name)
          exporting
            it_rows = lt_rows.
      catch cx_root into data(ref_cx_root).
        message ref_cx_root type 'I'.
    endtry.
  endmethod.


  method on_user_command_before.
    ref_grid->check_changed_data( ).
  endmethod.


  method pai.
  endmethod.


  method refresh_display.
    data: lt_selected_rows type lvc_t_row
        , lt_selected_cells type lvc_t_cell
        , lt_selected_columns type lvc_t_col.

    call method ref_grid->get_selected_rows
      importing
        et_index_rows = lt_selected_rows.

*    call method ref_grid->get_selected_cells
*      importing
*        et_cell = lt_selected_cells.

    call method ref_grid->get_selected_columns
      importing
        et_index_columns = lt_selected_columns.

    ref_grid->refresh_table_display( is_stable = value #( row = abap_true col = abap_true ) i_soft_refresh = abap_true ).

    if lt_selected_rows is not initial.
      call method ref_grid->set_selected_rows
        exporting
          it_index_rows            = lt_selected_rows
          is_keep_other_selections = abap_true.
    endif.
*    if lt_selected_cells is not initial.
*      call method ref_grid->set_selected_cells
*        exporting
*          it_cells = lt_selected_cells.
*    endif.
    if lt_selected_columns is not initial.
      call method ref_grid->set_selected_columns
        exporting
          it_col_table             = lt_selected_columns
          is_keep_other_selections = abap_true.
    endif.
  endmethod.


  method set_actvt.
    s_actvt-actvt = actvt.
    select single ltext
      into s_actvt-ltext
      from tactt
     where actvt eq s_actvt-actvt
       and spras eq sy-langu.
  endmethod.


  method set_container.
    me->ref_container = ref_container.
  endmethod.


  method set_ref_data.
    me->ref_data = ref_data.
    ref_table_descr ?= cl_abap_tabledescr=>describe_by_data_ref( ref_data ).
    ref_line_descr ?= ref_table_descr->get_table_line_type( ).
    if ref_line_descr->is_ddic_type( ).
      line_ddic_type = ref_line_descr->get_relative_name( ).
    endif.


    "Si el objeto tiene el un atributo ref_lt le asigna ref_data.
    field-symbols: <ref_lt> type any.
    try.
        assign ('ref_lt') to <ref_lt>.
        <ref_lt> ?= ref_data.
      catch cx_root into data(ref_cx_root).
    endtry.
  endmethod.


  method set_variant.
    s_variant-report = report.
    s_variant-handle = handle.
    s_variant-log_group = log_group.
    s_variant-username = username.
    s_variant-variant = variant.
    s_variant-text = text.
    s_variant-dependvars = dependvars.
  endmethod.


  method show.
    call function 'ZALV_SHOW'
      exporting
        ref_alv = me.
  endmethod.
ENDCLASS.
