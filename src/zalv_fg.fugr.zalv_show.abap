function zalv_show.
*"----------------------------------------------------------------------
*"*"Interfase local
*"  IMPORTING
*"     REFERENCE(REF_ALV) TYPE REF TO  ZCL_ALV
*"----------------------------------------------------------------------

  data: dynnr like sy-dynnr.

  dynnr = 9000 + lines( gt_dynnr ) + 1.
  append
   value #( dynnr = dynnr ref_alv = ref_alv )
      to gt_dynnr.
  call screen dynnr.
  delete gt_dynnr
   where dynnr eq dynnr.
  cl_gui_cfw=>flush( ).
endfunction.
