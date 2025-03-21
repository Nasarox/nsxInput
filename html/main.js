let currentMenuAction;

$(document).ready(function() {
    window.addEventListener('message', function(event) {
        let item = event.data;
        if (item.action == 'showDialog') {
            playOpenSound();
            handleDialog(item);
        }
    });

    $('#close').click(function() {
        playCloseSound();
        $.post('https://nsxInput/exit', JSON.stringify({}));
        $('#container').hide();
        currentMenuAction = null;
    });

    $('#input').keypress(function(event) {
        if (event.which == 13) { 
            event.preventDefault(); 
            $(document).submit();
        }
    });
});

function playOpenSound() {
    var soundO = new Audio('sound_open.mp3');
    soundO.volume = 0.5;
    soundO.play();
}

function playCloseSound() {
    var soundC = new Audio('sound_close.mp3');
    soundC.volume = 0.4;
    soundC.play();
}

function playSubmitSound() {
    var soundS = new Audio('sound_submit.mp3');
    soundS.volume = 0.5;
    soundS.play();
}

function handleDialog(item) {
    if (item.textarea) {
        $("#input").replaceWith($('<textarea placeholder="" class="form-control" id="input"></textarea>'));
    } else {
        $("#input").replaceWith($('<input placeholder="" class="form-control" id="input"></input>'));
    }
    $('#container').show();
    $('#input').val(item.defaultInput);
    $('#dialogLabel').html(item.label);
    $('#hint').text(item.helpText);
    currentMenuAction = item.menuAction;

    $('#input').keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            $(document).submit();
        }
    });
}

$(document).keyup(function(event) {
    if (event.which == 27) {
        playCloseSound();
        $.post('https://nsxInput/exit', JSON.stringify({}));
        $('#container').hide();
        currentMenuAction = null;
        return;
    }
});

$(document).submit(function(event) {
    event.preventDefault();
    playSubmitSound();
    let dialog = $("#input").val();
    const data = JSON.stringify({ text: dialog, currMA: currentMenuAction });
    $.post('https://nsxInput/submit', data);
    currentMenuAction = null;
    $('#container').hide();
});