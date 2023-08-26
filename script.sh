#!/bin/bash

listar_regras(){
    iptables_output=$(sudo iptables -L)
    dialog --msgbox "$iptables_output" 20 60
}

apagar_regras(){
    iptables_output=$(sudo iptables -F)
    dialog --msgbox "$iptables_output" 20 60
}
opcao=$( dialog --stdout --menu 'Digite uma opção?' 0 0 0 1 'Criar uma regra' 2 'Configurar Política Padrão' 3 'Apagar uma regra'  4 'Listar todas as regras' 5 'Apagar todas as regras' 6 'Salvar as regras do firewall' 7 'Restaurar as regras do firewall')
    case $opcao in
        1) dialog --infobox 'Você concordou!' 0 0 ;;
        2) dialog --infobox 'Que Pena!' 0 0 ;;
        3) dialog --infobox 'Nem sim nem não' 0 0;;
        4) listar_regras;;
        5) apagar_regras ;;
        6) dialog --infobox 'Nem sim nem não' 0 0;;
        7) dialog --infobox 'Nem sim nem não' 0 0;;
        *) dialog --infobox 'Opção inválida!' 0 0;;
    esac