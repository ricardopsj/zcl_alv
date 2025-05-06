*&---------------------------------------------------------------------*
*& Include          LZRPS_ALV_FGD01
*&---------------------------------------------------------------------*

module pbo_9001 output.
  set pf-status 'ZSTATUS' of program 'SAPLZALV_FG'.

  call method gref_alv->create( ).
  call method gref_alv->display( ).
endmodule.

module pai_9001 input.
  case sy-ucomm.
    when 'BACK' or 'EXIT' or 'CANCEL'.
      set screen 0.
      leave screen.
    when others.
      case sy-ucomm.
        when '&ODN'.
          sy-ucomm = gref_alv->ref_grid->mc_fc_sort_dsc.
        when '&OUP'.
          sy-ucomm = gref_alv->ref_grid->mc_fc_sort_asc.
          call method gref_alv->ref_grid->get_selected_columns
            importing
              et_index_columns = data(lt_row_col).
        when '&OL0'.
          sy-ucomm = gref_alv->ref_grid->mc_mb_variant.
      endcase.
      gref_alv->ref_grid->fcode_bouncer( ).
      gref_alv->ref_grid->refresh_table_display( is_stable = value lvc_s_stbl( row = 'X' col = 'X' ) ).
  endcase.
endmodule.
