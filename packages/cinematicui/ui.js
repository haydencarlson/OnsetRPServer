var cinematicStarted = false

function startCinematic (data) {
    cinematicStarted = true
    document.getElementById('cinematicui').classList.remove('hiddenui')
    buildCinematic(data)
}

function updateCinematic (data) {
    if (cinematicStarted) {
        startCinematic(data)
    } else {
        document.getElementById('cinematicui').classList.add('updatingui')
        setTimeout(() => {
            buildCinematic(data, () => {
                document.getElementById('cinematicui').classList.remove('updatingui')
            })
        }, 210)
    }
}

function buildCinematic (data, callback = null) {
    if (data.title) {
        document.getElementById('from').innerText = data.title
    }
    if (data.message) {
        document.getElementById('message').innerText = data.message
    }
    document.getElementById('actions').innerHTML = ''

    if (data.actions) {
        document.getElementById('actions').classList.add('mt')
        for (let index = 0; index < data.actions.length; index++) {
            let action = data.actions[index];
            let btnDiv = document.createElement('div')
    
            btnDiv.classList.add('btn')
            btnDiv.innerText = action.text
    
            document.getElementById('actions').appendChild(btnDiv)
    
            btnDiv.addEventListener('click', () => {
                if (action.close_on_click) {
                    stopCinematic()
                } else {
                    document.getElementById('actions').innerHTML = '<div class="btn">. . .</div>'
                }

                if (window.ue) {
                    if (action.callback) {
                        window.ue.game.callevent(action.callback, '[]');
                    }
                } else {
                    if (action.callback) {
                        console.log('Callback: ' + action.callback)
                    }
                }
            })
        }
    } else {
        document.getElementById('actions').classList.remove('mt')
    }
    if (callback) { callback() }
}

function stopCinematic (shouldTrigger = true) {
    cinematicStarted = false
    if (window.ue) {
        if (shouldTrigger) {
            window.ue.game.callevent('CUIClose', '[]');
        }
    } else {
        console.log('Callback: CUIClose' )
    }
}