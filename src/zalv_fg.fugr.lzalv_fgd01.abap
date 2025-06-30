*&---------------------------------------------------------------------*
*& Include          LZRPS_ALV_FGD01
*&---------------------------------------------------------------------*

module pbo_alv output.
  read table gt_dynnr with key dynnr = sy-dynnr reference into data(ref_dynnr).
  if ref_dynnr->ref_container is initial.
    ref_dynnr->ref_container = new cl_gui_custom_container( repid = 'SAPLZALV_FG' dynnr = ref_dynnr->dynnr container_name = 'CONTAINER' ).
    ref_dynnr->ref_alv->set_container( ref_dynnr->ref_container ).
    ref_dynnr->ref_alv->create( ).
    ref_dynnr->ref_alv->display( ).
*    cl_gui_cfw=>flush( ).
  endif.
endmodule.

module pai_alv input.
  case sy-ucomm.
    when 'BACK' or 'EXIT' or 'CANCEL'.
      read table gt_dynnr with key dynnr = sy-dynnr reference into ref_dynnr.
      if sy-subrc eq 0.
        if ref_dynnr->ref_alv->ref_grid is bound.
          ref_dynnr->ref_alv->ref_grid->free( ).
        endif.
        if ref_dynnr->ref_container is bound.
          ref_dynnr->ref_container->free( ).
        endif.
        clear: ref_dynnr->ref_alv->ref_grid
             , ref_dynnr->ref_container.
      endif.
      set screen 0.
      leave screen.
    when others.
      field-symbols: <fcode> like sy-ucomm.

      read table gt_dynnr with key dynnr = sy-dynnr reference into ref_dynnr.

      data(fcode_name) = 'D' && sy-dynnr && '_FCODE'.
      assign (fcode_name) to <fcode>.
      if <fcode> is not initial.
        ref_dynnr->ref_alv->on_user_command( <fcode> ).
      endif.
  endcase.
endmodule.
