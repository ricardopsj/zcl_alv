class zcl_alv definition
  public
  create public .

  public section.

    constants:
      begin of cs_layout
                     , begin of sel_mode
                     , multiple_row_col    type lvc_libox value 'A' " Selección múltiple de filas y columnas con botones de selección
                     , single              type lvc_libox value 'B' " Selección simple (tipo listbox), permite seleccionar solo una fila o columna
                     , multiple_row_no_btn type lvc_libox value 'C' " Selección múltiple de filas sin botones de selección
                     , multiple_row_all    type lvc_libox value 'D' " Selección múltiple de filas con botones de selección y "Seleccionar todo"
                     , end of sel_mode
                 , end of cs_layout .
    data ref_data type ref to data .
    data ref_container type ref to cl_gui_container .
    data ref_grid type ref to cl_gui_alv_grid .
    data ref_gui_timer type ref to cl_gui_timer .
    data ref_table_descr type ref to cl_abap_tabledescr .
    data ref_line_descr type ref to cl_abap_structdescr .
    data line_ddic_type type typename .
    data lt_fieldcat type lvc_t_fcat .
    data ls_layout type lvc_s_layo .

    methods create .
    methods create_fieldcat .
    methods create_fieldcat_exit
      importing
        !ref_fieldcat type ref to lvc_s_fcat .
    methods create_layout
      importing
        !ref_layout type ref to lvc_s_layo .
    methods display .
    methods display_grid .
    methods display_pf_status .
    methods set_ref_data
      importing
        !ref_data type ref to data .
    methods set_container
      importing
        !ref_container type ref to cl_gui_container .
    methods show .
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
    create_layout( ref #( ls_layout ) ).
  endmethod.


  method create_fieldcat.
    call function 'LVC_FIELDCATALOG_MERGE'
      exporting
        i_structure_name       = line_ddic_type
      changing
        ct_fieldcat            = lt_fieldcat
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
    else.
      loop at lt_fieldcat reference into data(ref_fieldcat).
        ref_fieldcat->col_pos = sy-tabix.
        ref_fieldcat->tabname = line_ddic_type.
        ref_fieldcat->col_opt = abap_true.
        create_fieldcat_exit( ref_fieldcat ).
      endloop.
    endif.
  endmethod.


  method create_fieldcat_exit.
  endmethod.


  method create_layout.
*    ref_layout->cwidth_opt = 'X'.
*    ref_layout->edit = 'X'.
*    ref_layout->grid_title = 'My Titlebar'(300).              "#EC NOTEXT
*    ref_layout->no_toolbar = 'X'.
*    ref_layout->no_vgridln = 'X'.
*    ref_layout->no_hgridln = 'X'.
*    ref_layout->no_merging = 'X'.
*    if p_lights = 'X' or p_lightc = 'X'.
*      ref_layout->excp_fname = p_lignam.
*    else.
*      ref_layout->excp_fname = space.
*    endif.
*    if p_s_defa = 'X'.
*      ref_layout->sel_mode = space.
*    endif.
*    if p_s_lbnf = 'X'.
*      ref_layout->sel_mode = 'D'.
*    endif.
*    if p_s_lbno = 'X'.
*      ref_layout->sel_mode = 'A'.
*    endif.
*    if p_s_lbsi = 'X'.
*      ref_layout->sel_mode = 'B'.
*    endif.
*    if p_s_lbmu = 'X'.
*      ref_layout->sel_mode = 'C'.
*    endif.
*    if p_cells = 'X'.
*      ref_layout->ctab_fname = 'COLINFO'.
*    else.
*      ref_layout->ctab_fname = space.
*    endif.
*    ref_layout->info_fname = 'INFO'.
*    ref_layout->no_headers = 'X'.
*    ref_layout->no_rowmark = 'X'.
*    ref_layout->excp_conds = p_lightc.
*    ref_layout->totals_bef = p_totbef.
*    ref_layout->excp_led = p_diode.
*    ref_layout->weblook = p_webm.
*    ref_layout->webstyle = p_webs.
*    ref_layout->webrows = p_webr.
*    ref_layout->webxwidth = p_webxw.
*    ref_layout->webxheight = p_webxh.
*    ref_layout->no_toolbar = 'X'.
  endmethod.


  method display.
    display_pf_status( ).
    display_grid( ).
  endmethod.


  method display_grid.
    field-symbols: <lt> type any table.

    assign ref_data->* to <lt>.

    call method ref_grid->set_table_for_first_display
      exporting
*	      it_toolbar_excluding  = lt_exclude
        i_structure_name = line_ddic_type
        is_layout        = ls_layout
        i_save           = abap_false
      changing
        it_fieldcatalog  = lt_fieldcat
        it_outtab        = <lt>.
  endmethod.


  method display_pf_status.
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
  endmethod.


  method show.
    call function 'ZALV_SHOW'
      exporting
        ref_alv = me.
  endmethod.
ENDCLASS.
