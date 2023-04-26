//handle ajax error
function ajax_Error(xhr, textStatus){
    if(xhr.status === 400){
        toastr.error("Invalid request!", "400")
        return;
    }
    if(xhr.status === 403){
        toastr.error("Access Denied!", "403")
        return;
    }
    if(textStatus === "timeout"){
        toastr.error("Access Timeout!", "Timeout")
        return;
    }
    toastr.error("Unknown Error!", "Error")
}

//Dynamically load scripts
$(document).ready(function(){
    load_script.forEach(function(data){
        $.getScript(data).fail(function(xhr, settings){
            toastr.error("Can't load "+data, "Unable to load script");
        });
    })
})

//turn to object
/* 表單轉 JSON */
$.fn.serializeObject = function() {
    let o = {};
    let a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value.trim() || null);
        } else {

            o[this.name] = this.value.trim() || null;
        }
    });
    return o;
};
