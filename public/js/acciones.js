jQuery(function($) {
    var paginas = $(this)['context'].URL.toString().split("/");
    var strPag  = paginas[paginas.length-1];
    var controller=['fitness','registros','atencion'];
    $('.numerico').validarCampo('0123456789');
    $('.moneda').validarCampo('.0123456789');
    $('.soloTexto').validarCampo(' abcdefghijklmnñopqrstuvwxyzáéíóú');
    $('.soloTextoNombre').validarCampo(' abcdefghijklmnñopqrstuvwxyzáéíóú-123456789');
    $('.email').validarCampo('abcdefghijklmnopqrstuvwxyz0123456789_-.@');
    $('.direccion').validarCampo(' abcdefghijklmnopqrstuvwxyz0123456789_-#°.');
    if(jQuery.inArray(strPag, controller)>0){
        strPag="index";
    pace.start();

        cargaJS(strPag);
    }else{
        cargaJS(strPag);
    }
});

function cargaJS(accion) {
    var ele = document.getElementById(accion);
    if (ele == undefined) {
        var tagjs = document.createElement("script");
        tagjs.setAttribute("type", "text/javascript");
        tagjs.setAttribute("id", accion);
        tagjs.setAttribute("src", "../../js/"+accion+".js");
        document.getElementsByTagName("head")[0].appendChild(tagjs);
    }
}