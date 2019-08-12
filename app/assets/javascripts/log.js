function log(side, kind, content, user_id) {

    let data = {
        side: side,
        kind: kind,
        content: content,
        user_id: user_id
    }

    $.ajax({
        type: "POST",
        dataType: "JSON",
        url: "/log/",
        data: data,
        success: function (response) {
            console.log(response);
        }
    })

}