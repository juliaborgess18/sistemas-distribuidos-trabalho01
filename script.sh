#!/bin/bash

criar_regra(){

	# VARIÁVEIS
	cadeia=""
	alvo=""
	filtro_protocolo==""
	
	# DEFINE A CADEIA DA REGRA
	opcao=$( dialog --stdout --menu 'Escolha a CADEIA para regra:' 0 0 0 1 'Entrada' 2 'Saída' 3 'Encaminhamento' 4 'Voltar')
	case $opcao in
	    1) cadeia="INPUT";;
	    2) cadeia="OUTPUT";;
	    3) cadeia="FORWARD";;
	    4) menu_opcoes_firewall;;
	    *) dialog --infobox 'Opção inválida!' 0 0;;
	esac
	
	# DEFINE O ALVO DA REGRA
	opcao=$( dialog --stdout --menu 'Escolha o ALVO da rera:' 0 0 0 1 'Aceitar' 2 'Rejeitar' 3 'Descartar' 4 'Voltar')
	case $opcao in
	    1) alvo="ACCEPT";;
	    2) alvo="REJECT";;
	    3) alvo="DROP";;
	    4) menu_opcoes_firewall;;
	    *) dialog --infobox 'Opção inválida!' 0 0;;
	esac
	
	# ESCOLHA DAS FILTROS - FALTA TERMINAR FAVOR NÃO MEXER KKKKKKKK
	while [ $? == 0 ];do
	opcao=$( dialog --stdout --menu "Escolha o $i° filtro" 0 0 0 1 'Endereço de Origem'  2 'CEndereço de Destino' 3 'Protocolo' 4 'Porta de Origem' 5 'Porta de Destino' 6 'Endereço MAC' 7 'Estado' 8 'Interface de Entrada' 9 'Interface de Saída' 0 'enviar')
	case $opcao in
	    1) nome_protocolo=$(dialog --inputbox "Digite a sigla do protocolo" 8 40 --stdout)
	    filtro_protocolo="-p $nome_protocolo";;
	    2) alterar 0 0;;
	    3) alterar 0 0;;
	    4) alterar 0 0;;
	    5) alterar 0 0;;
	    6) alterar 0 0;;
	    7) alterar 0 0;;
	    8) alterar 0 0;;
	    9) alterar 0 0;;
	    0) alterar 0 0;;
	    *) dialog --infobox 'Opção inválida!' 0 0;;
	esac
 	done
 
 	# CÓDIGO RESPONSÁVEL POR CRIAR AS REGRAS UTILIZANDO AS VARÁVEIS - FALTA TERMINAR :)
 	# _____________________
 	
	# CHAMAR O MENU DEPOIS DE CRIAR A REGRA
	menu_opcoes_firewall
}

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
        opcao=$( dialog --stdout --menu 'Digite uma opção?' 0 0 0 1 'Criar uma regra' 2 'Configurar Política Padrão' 3 'Apagar uma regra'  4 'Listar todas as regras' 5 'Apagar todas as regras' 6 'Salvar as regras do firewall' 7 'Restaurar as regras do firewall' 8 'Retornar ao menu principal')
        case $opcao in
            1) criar_regra;;
            2) dialog --infobox 'Que Pena!' 0 0 ;;
            3) dialog --infobox 'Nem sim nem não' 0 0;;
            4) listar_regras;;
            5) apagar_regras;;
            6) dialog --infobox 'Nem sim nem não' 0 0;;
            7) dialog --infobox 'Nem sim nem não' 0 0;;
            8) menu_principal;;
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