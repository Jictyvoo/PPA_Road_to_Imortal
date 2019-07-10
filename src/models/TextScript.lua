local TextScript = {}; TextScript.__index = TextScript

local texts = {
    portuguese = {
        mainMenu = {
            "Essa é a história de um Gado chamado Pedro Paulo...",
            "Esse pequeno e humilde gado, um dia interrompeu suas ações de mestre dos gados (badum ts) para refletir sobre suas ações na sociedade secreta dos gados...",
            "\"Como eu posso evoluir na nossa grande sociedade dos gados carecas e expandir meus negócios de gado?\"",
            "Após fazer essa pergunta, seu pouco cabelo começou a cair, a medida que não chegava a uma resposta satisfatória. Quando não lhe sobrou um fio de cabelo, lhe veio algo à mente:",
            "\"Para eu ter contato com a maior quantidade de pessoas possível eu preciso passar vergonha e fazer as pessoas rirem da minha careca, esse vai ser meu jeito CARECA de ser\"",
            "\"VOU VIRAR STREAMER!\"", "Porém subitamente lhe veio a mente que se jogar games fáceis e divertidos, o seu cabelo voltaria a crescer, e ele perderia popularidade",
            "\"Está decidido, vou virar streamer de DOTA, desse jeito sempre passarei raiva e nunca terei cabelo\"",
            "\"SEREI O MAIOR GADO DO MUNDO!\""
        },
        tinkerMacro = {
            "\"Urgh! Jogar de tinker realmente é complicado, não tem como uma pessoa em sã consciência jogar com isso\"",
            "Pensou o gado careca enquanto treinava suas habilidades para stremar. \"Esse boneco é muito exaustivo! Tenho de gastar muita energia mental para jogar com ele...\"",
            "Então, como se já não bastasse idéia ruim andando por sua careca, lhe veio outra idéia à mente, uma que manteria seu status de gado careca e o ajudaria durante o jogo",
            "\"Assim como Sansão que usava a força dos seus cabelos, eu irei direcionar a energia do crescimento do meu cabelo para que possa ser usada para jogar com esse boneco mongol\"",
            "\"Ser gado nunca se tornou tão fácil. Além do mais, o fato de eu estar careca, porém ainda haver barba me dá um charme natural viking, hehehe\"",
            "\"Com certeza os gados do mundo todo vão me idolatrar, sempre me seguirão para onde quer que eu vá atrás de mulher, e os usarei como pretexto para ajudá-las... muahahaha\"",
            "E assim, o nosso grande Gado segue com seus planos"
        },
        singPPA = {
            "...", "............................................................................................................................",
            "<pigarro> ENTÃO!!!!!!!!!! ACHO QUE ESSA PERFORMANCE DO NOSSO GRANDE GADO FOI REALMENTE HORRIV... QUER DIZER MARAVILHOSA, CERTO?!!!!!!!!!",
            "A PRODUÇÃO ESTÁ ME DIZENDO QUE ESTOU GRITAND. Oh... estou gritando, peço perdão por isso. Acho que acabei ficando semi-surdo com a última performance...",
            "Não falem isso para a produção, mas esse cara canta muito mal, meu amigo... Não tem como... PPA é rum demais, não tem como...",
            "Enfim, voltando à nossa história, o grande gado PPA, sem motivo algum aparente para estourar os tímpanos dos seus viewers decidiu seguir a jornada do falsete, quer dizer gado",
            "\"Eu canto muito bem, o novo Freddie Mercury da minha geração. Com certeza essa minha perfomance vai levar ao Emmy!!\"",
            "Mal sabia nosso gado careca, que se continuasse cantando, seu destino seria o manicômio, pois nenhuma pessoa normal seria capaz de cantar dessa forma e continuar são..."
        },
        demonWords = {
            ""
        },
        chatGado = {
            ""
        }
    }
}

function TextScript:get(language)
    return texts[language or "portuguese"]
end

return TextScript
