local states = {
    start = {
        text = "Olá, é aqui que eu acho a live do tinker careca barbudo do brasil?",
        options = {
            giveVIP = "Dar vip à ela",
            hereTinker = "Aqui mesmo meu bem... Aqui está o Tinker mais careca das Américas",
            youreWoman = "Amanada... Parece nome de mulher, por acaso você é uma mulher fia?"
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
            wasAngry = "Fala assim não amor, eu só estava um pouco irritado, peço perdão por isso"
        }
    },
    getTogether = {
        text = "Nossa, muito obrigada... Você é realmente atensioso",
        options = {
            youAreWelcome = "Que isso, não é nada, muito bem-vinda!",
            staySilence = "(Não falar nada)",
            cattleDuty = "Apenas meu dever como gado minha querida... (pisca)"
        }
    },
    youAreWelcome = {
        text = "Pepega",
        finished = true
    },
    cattleDuty = {
        text = "Quê!? Seu mentiroso enganador!"
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