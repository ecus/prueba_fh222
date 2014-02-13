jQuery(function($) {
    var paginas = $(this)['context'].URL.toString().split("/");
    var strPag  = paginas[paginas.length-1];
    var controller=['fitness','registros','atencion'];
    $('.numerico').validarCampo('0123456789');
    $('.rpm').validarCampo('*#0123456789');
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
        marcarLinkActivo($('ul.breadcrumb'),strPag);
        cargaJS(strPag);
    }
});
function marcarLinkActivo (opciones,pag) {

    $.each(opciones.children('li'),function(){
        var posicion = $(this).children('a').attr('href').search(pag);
        if (posicion>=0){
            $(this).addClass('active');
        };
    });
}
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
function limpiaControlesBasico () {
    $('input[type="text"]').val('');
    $('input[type="date"]').val('');
    $('input[type="mail"]').val('');
    $('input[type="number"]').val('');
    $('input[type="checkbox"]').prop('checked', false);
    $('div[data-toggle="buttons"]').find('label').removeClass('active');
    $('select').find('option:nth(0)').attr("selected","selected");
    $('select[multiple="multiple"]').find('option').removeAttr('selected');
}
function muestraMensaje (idModal, espacioMensaje, mensaje) {
    $('#'+espacioMensaje).empty().html(mensaje);
    $('#'+idModal).modal('show');
}