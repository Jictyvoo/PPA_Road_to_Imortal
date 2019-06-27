local TextScript = {}; TextScript.__index = TextScript

local texts = {
    portuguese = {
        "Essa é a história de um Gado chamado Pedro Paulo...",
        "Esse pequeno e humilde gado, um dia interrompeu suas ações de mestre dos gados (badum ts) para refletir sobre suas ações na sociedade secreta dos gados...",
        "\"Como eu posso evoluir na nossa grande sociedade dos gados carecas e expandir meus negócios de gado?\"",
        "Após fazer essa pergunta, sua pouco cabelo começou a cair, a medida que não chegava a uma resposta satisfatória. Quando não lhe sobrou um fio de cabelo, lhe veio algo à mente:",
        "\"Para eu ter contato com a maior quantidade de pessoas possível eu preciso passar vergonha e fazer as pessoas rirem da minha careca, esse vai ser meu jeito CARECA de ser\"",
        "\"VOU VIRAR STREAMER!\"", "Porém subitamente lhe veio a mente que se jogar games fáceis e divertidos, o seu cabelo voltaria a crescer, e ele perderia popularidade",
        "\"Está decidido, vou virar streamer de DOTA, desse jeito sempre passarei raiva e nunca terei cabelo\"",
        "\"SEREI O MAIOR GADO DO MUNDO!\""
    }
}

function TextScript:get(language)
    return texts[language or "portuguese"]
end

return TextScript
