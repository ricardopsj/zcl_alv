function-pool zalv_fg.                  "MESSAGE-ID ..

types: begin of tys_dynnr
   , dynnr like sy-dynnr
   , ref_container type ref to cl_gui_custom_container
   , ref_alv type ref to zcl_alv
   , end of tys_dynnr
   , tyt_dynnr type table of tys_dynnr.

data: gt_dynnr type tyt_dynnr
      , d9001_fcode type ui_func
      , d9002_fcode type ui_func
      .
