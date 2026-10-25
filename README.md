# zcl_alv

Clase base que facilita el uso de `CL_GUI_ALV_GRID`. Encapsula la creación del grid, el catálogo de campos, el layout, el registro de eventos y la visualización en pantalla completa, de modo que mostrar un ALV se reduce a tres líneas:

```abap
select * from sbook into table @data(lt) up to 10 rows.

data(ref_alv) = new zcl_alv( ).
ref_alv->set_ref_data( ref #( lt ) ).
ref_alv->show( ).
```

No hace falta crear dynpro, contenedor ni PF-STATUS propios: el grupo de funciones `ZALV_FG` aporta todo eso.

## Instalación

Importar con [abapGit](https://abapgit.org). Requiere ABAP 7.40 o superior (expresiones `NEW`, `VALUE`, RTTS).

El grupo de funciones `ZALV_FG` trae serializados el PF-STATUS `ZSTATUS` y los dynpros 9001–9010 con su custom control `CONTAINER`.

El programa llamante debe tener un **titlebar `MAIN`** (lo usa `display_title`), o la subclase debe redefinir ese método.

## Objetos del paquete

| Objeto | Tipo | Descripción |
|---|---|---|
| `ZCL_ALV` | Clase | Clase base del ALV; se usa directa o heredada |
| `ZALV_FG` | Grupo de funciones | Infraestructura de visualización: FM `ZALV_SHOW`, dynpros 9001–9010 con custom control `CONTAINER`, módulos `PBO_ALV`/`PAI_ALV` |
| `ZALV_S_ROW` / `ZALV_T_ROW` | Estructura / Tabla | Fila seleccionada: `INDEX` (índice en la tabla) + `REF_ROW` (referencia a la línea de datos) |
| `ZALV_DEMO1` | Programa | Demo: herencia con `create_fieldcat_exit` y `create_layout` sobre datos de `SBOOK` |
| `ZALV_DEMO2` (+ include `ZALV_DEMO2_ALV`) | Programa | Demo: catálogo de campos manual (`create_fieldcat_fill`) y colores de línea (`info_fname`) |
| `ZALV_SEL_SCR_VAR` | Include | Bloque de selección reutilizable con parámetro `VARIANT` y ayuda F4 de variantes de disposición (`LVC_VARIANT_F4`) |

## Cómo funciona

1. `set_ref_data( ref #( itab ) )` recibe la tabla por referencia. Con RTTS detecta si la línea es un tipo DDIC:
   - Si lo es, el fieldcat se genera con `LVC_FIELDCATALOG_MERGE`.
   - Si no (tipo local), se genera con `cl_salv_data_descr=>read_structdescr`.
2. `show( )` llama al FM `ZALV_SHOW`, que asigna el siguiente dynpro libre (9001–9010, hasta 10 ALVs apilados; ver *Problemas conocidos* desde el tercer nivel), crea el `cl_gui_custom_container` y ejecuta `create( )` + `display( )`.
3. Alternativamente, con `set_container( )` se puede incrustar el grid en un contenedor propio (ver `create( )`; sin contenedor usa `cl_gui_container=>screen0`). Ver *Uso en un contenedor propio*.

El grid queda **listo para edición** por defecto: se registran `mc_evt_modified` y `mc_evt_enter` y se llama `set_ready_for_input( 1 )`.

## Uso en un contenedor propio

Para mostrar el grid dentro de una pantalla propia (por ejemplo, en un lado de un `cl_gui_splitter_container`), en lugar de `show( )`:

```abap
ref_alv = new lcl_alv( ).
ref_alv->set_container( ref_splitter->get_container( row = 1 column = 2 ) ).
ref_alv->set_ref_data( ref #( mt_datos ) ).
ref_alv->create( ).
ref_alv->display_grid( ).

" más tarde, tras cambiar el contenido de mt_datos:
ref_alv->refresh_display( ).
```

- Llamar a `display_grid( )` y no a `display( )`. `display( )` además fija el PF-STATUS `ZSTATUS` de `SAPLZALV_FG` y el titlebar `MAIN`, y reemplazaría el status de la pantalla propia.
- `set_ref_data` guarda una referencia: la tabla debe seguir viva (por ejemplo, un atributo) mientras se muestre el grid.
- Declarar en la subclase el atributo `ref_lt` tipado con la tabla, como hacen las subclases de los repos `frs_*`. `set_ref_data` lo asigna dinámicamente.

Ejemplo real: transacción `ZCLFI160` del repo `frs_ZCLFI160`.

## Puntos de extensión (heredar y redefinir)

| Método | Para qué |
|---|---|
| `create_fieldcat_exit( ref_fieldcat )` | Ajustar cada campo del catálogo (checkbox, edit, hotspot, textos…) |
| `create_fieldcat_fill` | Reemplazar por completo la generación del catálogo |
| `create_layout` | Ajustar `s_layout` (zebra, sel_mode, info_fname, etc.; trae comentadas las opciones más comunes) |
| `display_pf_status` / `display_title` | Usar PF-STATUS / titlebar propios. Un status propio debe usar los códigos `BACK`, `EXIT` y `CANCEL` para salir: son los únicos que reconoce el PAI de `ZALV_FG` |
| `display_ex_btn` | Poblar `t_grid_excluding` / `t_program_excluding` (trae comentado el listado completo de `mc_fc_*`) |
| `on_toolbar` | Modificar la toolbar (por defecto elimina funciones de edición local, refresh, print, views, detail…) |
| `on_data_changed`, `on_data_changed_finished`, `on_double_click`, `on_button_click`, `pai` | Hooks de eventos vacíos para redefinir |

## Convenciones de despacho dinámico

- **User command**: `on_user_command` llama dinámicamente al método `OK_<E_UCOMM>` de la subclase, pasándole `it_rows type zalv_t_row` con las filas seleccionadas (índice + referencia a la línea). Basta declarar en la subclase, por ejemplo, `methods ok_eliminar importing it_rows type zalv_t_row`.
- **Hotspot**: `on_hotspot_click` llama dinámicamente a `NAV_<FIELDNAME>` con `dsd` y `hst` (rango de índices de fila). Funciona también al hacer clic sobre líneas de **subtotal** (resuelve el rango con `get_subtotals`) y de **total** (toda la tabla).
- Antes de cada user command se ejecuta `check_changed_data( )` para volcar las ediciones pendientes.

## Utilidades públicas

- `get_selected_rows( )` → `ZALV_T_ROW`: filas seleccionadas con referencia directa a los datos (ignora líneas de total/subtotal).
- `refresh_display( )`: refresh estable que conserva filas y columnas seleccionadas.
- `set_variant( )` / `s_variant`: control de variantes de disposición (grabación `i_save = 'A'` y carga de la variante por defecto). `display_grid` siempre fija `report = sy-cprog`, así que el parámetro `report` de `set_variant` no tiene efecto.
- `set_actvt( )`: guarda la actividad (`TACT`/`TACTT`) para usarla en verificaciones de autorización de la subclase.
- Constantes en `c`:
  - `c-line_color-*`: los 28 códigos de color `Cxyz` con nombre (ver demo 2).
  - `c-fcode-*`: fcodes estándar de la toolbar.
  - `c-sel_mode-*`: modos de selección (`A`/`B`/`C`/`D`).
  - `c-rowtype-*`: tipo de fila (normal, total, subtotal).

## Demos

- **ZALV_DEMO1**: subclase con checkboxes, columna editable y zebra sobre `SBOOK`.
- **ZALV_DEMO2**: catálogo manual de 2 columnas y coloreado de líneas mostrando los 28 colores ALV con su código.

## Problemas conocidos

- **Campos OK sin declarar desde el tercer nivel.** El include `LZALV_FGTOP` declara solo `D9001_FCODE` y `D9002_FCODE`, pero los dynpros 9003–9010 usan `D9003_FCODE`…`D9010_FCODE` como campo OK. Si el sistema no los tiene declarados por otra vía, la generación de esas pantallas o el despacho de botones en `PAI_ALV` falla desde el tercer ALV apilado.
- **Más de 10 niveles.** `ZALV_SHOW` calcula el dynpro como 9000 + nivel; un undécimo ALV pide la pantalla 9011, que no existe.
- **Código de función sin limpiar.** `PAI_ALV` no limpia el campo OK después de llamar a `on_user_command`.
- **Variante.** `set_variant( report = ... )` se ignora (ver *Utilidades públicas*).
- **Hotspot en subtotales.** Si `get_subtotals` no devuelve la fila del subtotal, `on_hotspot_click` termina en dump. Las excepciones de los métodos `NAV_*` se descartan sin aviso.
