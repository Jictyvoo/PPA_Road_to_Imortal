local states = {
    start = {
        text = "Olá, é aqui que eu acho a live do tinker careca barbudo do brasil?",
        options = {
            giveVIP = "Dar vip à ela",
            --hereTinker = "Aqui mesmo meu bem... Aqui está o Tinker mais careca das Américas",
            --youreWoman = "Amanada... Parece nome de mulher, por acaso você é uma mulher fia?"
        }
    },
    hereTinker = {
        text = "Talvez o único Tinker careca existente né? LUL"
        options = {
            ohYes = "EXATAMENTE! Kappa, é isso que eu sou, o meu jeito careca de ser",

        }
    },
    giveVIP = {
        text = "Ué... eu tenho vip agora? Comassim!!?",
        options = {
            bingo = "De vez em quando eu faço um bingo com o nome tinker careca. Com sua mensagem eu bati o bingo e estou te dando o vip em troca",
            markWoman = "Da mesma forma que se marca gado, como minha vingança de gado, eu marco as mulheres que aparecem no chat",
            getTogether = "Percebi que é nova aqui, e provavelmente é mulher. Para te (marcar) entrosar melhor, eu te dei VIP"
        }
    },
    bingo = {
        text = "Nossa, seu grosso! Vou embora!",
        options = {
            wasAngry = "Fala assim não amor, eu só estava um pouco irritado, peço perdão por isso",
            thatsJoke = "Calma, calma, hahaha, eu só estava brincando um pouco",
            makeYouClown = "Eu sou um piadista, só estava fazendo uma piada contigo querida, huehuehue"
        }
    },
    wasAngry = {
        text = "E o que eu tenho a ver com sua irritação? Sua Raiva não me merece! Passar mal",
        options = {
            start = "ME FODI!!!"
        }
    },
    makeYouClown = {
        text = "E eu tenho cara de palhaço? Hunf!",
        options = {
            notDoAgain = "Desculpa não farei isso de novo, prometo!",
            markWoman = "É claro que você tem, por isso que tem o nariz vermelho te marcando!",
            staySilence = "Perdão, vou compensar jogando uma aqui para te entreter..."
        }
    },
    thatsJoke = {
        text = "Não teve graça! Mas eu te perdôo",
        options = {
            notDoAgain = "Obrigado... Não farei isso de novo, prometo!",
            staySilence = "É... Hora de jogar um Dota!",
            youAreWelcome = "Obrigado, e muito bem-vinda!"
        }
    }
    getTogether = {
        text = "Nossa, muito obrigada... Você é realmente atensioso",
        options = {
            youAreWelcome = "Que isso, não é nada, muito bem-vinda!",
            staySilence = "(Não falar nada)",
            cattleDuty = "Apenas meu dever como gado minha querida... (pisca)"
        }
    },
    staySilence = {
        text = "Bora feedar, -25 Keepo",
        options = {
            myReason = "Esse é o motivo de eu estar aqui, só vamo!",
            markWoman = "Você está tirando uma como minha cara? Você está marcada, vai sofrer!",
            makeMeSad = "Poxa amor... Assim eu fico triste..."
        }
    },
    makeMeSad = {
        text = "<3 Por isso estamos aqui",
        finished = true
    }
    myReason = {
        text = "KappaPride",
        finished = true
    },
    youAreWelcome = {
        text = "Pepega",
        finished = true
    },
    notDoAgain = {
        text = "Acho bom mesmo, rai ai",
        finished = true
    },
    cattleDuty = {
        text = "Quê!? Seu mentiroso enganador! Você não me merece!"
        options = {
            start = "ME FUDI!"
        }
    }
    markWoman = {
        text = "Que ser nojento! Nem acredito que cheguei a achar que você poderia ser legal, juro que você está acabado!",
        options = {
            start = "Me fudi!"
        }
    }
}

return {
    currentState = states.start,
    chooseState = function(self, newState)
        if states[newState] then self.currentState = states[newState] end
    end,
    isFinished = function(self) return self.currentState.finished or false end
    getOptions = function(self) return self.currentState.options end,
    getText = function(self) return self.currentState.text end,
    restart = function(self) self.currentState = states.start end
}
