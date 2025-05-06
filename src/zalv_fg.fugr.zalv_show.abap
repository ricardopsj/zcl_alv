function ZALV_SHOW.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(REF_ALV) TYPE REF TO  ZCL_ALV
*"----------------------------------------------------------------------

  gref_alv = ref_alv.
*  gref_alv->set_container( new cl_gui_custom_container( container_name = 'CONTAINER' ) ).
  call screen 9001.
endfunction.
