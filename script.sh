#!/bin/bash

listar_regras(){
    iptables_output=$(sudo iptables -L)
    dialog --msgbox "Resultado\n$iptables_output" 20 60
}

apagar_regras(){
    iptables_output=$(sudo iptables -F)
    dialog --msgbox "Resultado\n$iptables_output" 20 60
}

listar_participantes(){
    dialog --msgbox "Igor Almeida\nJúlia Borges\nRaphael Pavani" 0 0
    if [ $? -eq 0 ]; 
    then
        menu_principal
    fi
}

menu_opcoes_firewall(){
    while [ $? == 0 ];do
        opcao=$( dialog --stdout --extra-button --extra-label "Participantes" --menu 'Digite uma opção?' 0 0 0 1 'Criar uma regra' 2 'Configurar Política Padrão' 3 'Apagar uma regra'  4 'Listar todas as regras' 5 'Apagar todas as regras' 6 'Salvar as regras do firewall' 7 'Restaurar as regras do firewall')
        case $opcao in
            1) dialog --infobox 'Que Pena!' 0 0 ;;
            2) dialog --infobox 'Que Pena!' 0 0 ;;
            3) dialog --infobox 'Nem sim nem não' 0 0;;
            4) listar_regras;;
            5) apagar_regras;;
            6) dialog --infobox 'Nem sim nem não' 0 0;;
            7) dialog --infobox 'Nem sim nem não' 0 0;;
            *) dialog --infobox 'Opção inválida!' 0 0;;
        esac
    done
}

menu_principal(){
resposta=$( dialog --stdout --menu "Bem-vindo!\n Escolha sua opcao" 0 0 0 1 "Configurar firewall" 2 "Participantes" 3 "Sair")
case $resposta in 
    1) menu_opcoes_firewall;;
    2) listar_participantes;;
    3) dialog --infobox 'Saindo do Script!' 0 0 \ 
    exit 
esac
}

menu_principal          
