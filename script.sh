#!/bin/bash

criar_regra(){

	# VARIÁVEIS
	cadeia=""
	alvo=""
	filtro_endereco_origem=""
	filtro_endereco_destino=""
	filtro_protocolo=""
	filtro_porta_origem=""
	filtro_porta_destino=""
	filtro_mac=""
	filtro_estado=""
	filtro_interface_origem=""
	filtro_interface_saida=""
	
	
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
	opcao=$( dialog --stdout --menu 'Escolha o ALVO da regra:' 0 0 0 1 'Aceitar' 2 'Rejeitar' 3 'Descartar' 4 'Voltar')
	case $opcao in
	    1) alvo="ACCEPT";;
	    2) alvo="REJECT";;
	    3) alvo="DROP";;
	    4) menu_opcoes_firewall;;
	    *) dialog --infobox 'Opção inválida!' 0 0;;
	esac
	
	# ESCOLHA DOS FILTROS
	while [ $? == 0 ];do
	opcao=$( dialog --stdout --menu "Escolha o FILTRO para a regra:" 0 0 0 1 'Endereço de Origem'  2 'Endereço de Destino' 3 'Protocolo' 4 'Porta de Origem' 5 'Porta de Destino' 6 'Endereço MAC' 7 'Estado' 8 'Interface de Entrada' 9 'Interface de Saída' 10 'enviar' 0 "cancelar")
	case $opcao in
	    1) endereco_origem=$(dialog --inputbox "Digite o número do IP ex (10.99.0.1):" 8 40 --stdout)
	    filtro_endereco_origem="-s $endereco_origem";;
	    2) endereco_destino=$(dialog --inputbox "Digite o número do IP ex (10.99.0.1):" 8 40 --stdout)
	    filtro_endereco_destino="-d $endereco_destino";;
	    3) nome_protocolo=$(dialog --inputbox "Digite a sigla do protocolo ex (tcp):" 8 40 --stdout)
	    filtro_protocolo="-p $nome_protocolo";;
	    4) porta_origem=$(dialog --inputbox "Digite o número da porta ex (80):" 8 40 --stdout)
	    filtro_porta_origem="--sport $porta_origem";;
	    5) porta_destino=$(dialog --inputbox "Digite o número da porta ex (80):" 8 40 --stdout)
	    filtro_porta_destino="--dport $porta_destino";;
	    6) numero_mac=$(dialog --inputbox "Digite o número de MAC\nex (00: 0d: 83: b1: c0: 8e):" 8 40 --stdout)
	    filtro_mac="-m mac --mac-source $numero_mac";;
	    7) parametro=$(dialog --inputbox "Digite o parâmetro ex (ESTABLISHED):" 8 40 --stdout)
	    filtro_estado="-m state --state $parametro";;
	    8) interface_origem=$(dialog --inputbox "Digite a interface de origem (eth1):" 8 40 --stdout)
	    filtro_interface_origem="-i $interface_origem";;
	    9) interface_saida=$(dialog --inputbox "Digite a interface de destino (eth1):" 8 40 --stdout)
	    filtro_interface_saida="-o $interface_saida";;
	    10) $? =1;;
	    0) menu_opcoes_firewall;;
	    *) dialog --infobox 'Opção inválida!' 0 0;;
	esac
 	done
 
 	# CÓDIGO RESPONSÁVEL POR CRIAR AS REGRAS UTILIZANDO AS VARÁVEIS
 	sudo iptables -I $cadeia $filtro_endereco_origem $filtro_endereco_destino $filtro_protocolo $filtro_porta_origem $filtro_porta_destino $filtro_mac $filtro_estado $filtro_interface_origem $filtro_interface_saida -j $alvo
 	
 	# MOSTRANDO A REGRA AO USUÁRIO
 	dialog --msgbox "REGRA CRIADA:\n\niptables -I $cadeia $filtro_endereco_origem $filtro_endereco_destino $filtro_protocolo $filtro_porta_origem $filtro_porta_destino $filtro_mac $filtro_estado filtro_interface_origem $filtro_interface_saida -j $alvo" 20 60
 	
	# CHAMAR O MENU DEPOIS DE CRIAR A REGRA
	menu_opcoes_firewall
}

politica_padrao(){
	
	# VARIÁVEIS
	cadeia=""
	alvo=""
	
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
	opcao=$( dialog --stdout --menu 'Escolha o ALVO da regra:' 0 0 0 1 'Aceitar' 2 'Rejeitar' 3 'Descartar' 4 'Voltar')
	case $opcao in
	    1) alvo="ACCEPT";;
	    2) alvo="REJECT";;
	    3) alvo="DROP";;
	    4) menu_opcoes_firewall;;
	    *) dialog --infobox 'Opção inválida!' 0 0;;
	esac
	
	 # CÓDIGO RESPONSÁVEL POR CRIAR AS REGRAS UTILIZANDO AS VARÁVEIS
 	sudo iptables -I $cadeia -j $alvo
 	
 	# MOSTRANDO A REGRA AO USUÁRIO
 	dialog --msgbox "REGRA CRIADA:\n\niptables -I $cadeia -j $alvo" 20 60
 	
	# CHAMAR O MENU DEPOIS DE CRIAR A REGRA
	menu_opcoes_firewall
}



listar_regras(){
    iptables_output=$(sudo iptables -L)
    dialog --msgbox "LISTA DAS REGRAS:\n\n$iptables_output" 20 60
}

apagar_regras(){
    iptables_output=$(sudo iptables -F)
    dialog --msgbox "TODAS AS REGRAS DE FIREWALL FORAM APAGADAS COM SUCESSO!$iptables_output" 20 60
}

listar_participantes(){
    dialog --msgbox "PARTICIPANTES:\n* Igor Almeida\n* Júlia Borges\n* Raphael Pavani" 0 0
    if [ $? -eq 0 ]; 
    then
        menu_principal
    fi
}

apagar_uma_regra(){
	while [ $? == 0 ];do
		opcao=$( dialog --stdout --menu 'Escolha uma cadeia.' 0 0 0 1 'Entrada' 2 'Saida'  3 'Encaminhamento' 4 'Sair')
		case $opcao in
			1) 	
				regras=$(sudo iptables -L INPUT --line-numbers)
				indice=$(dialog --inputbox "INPUT:\n\n$regras" 20 60 --stdout)
				sudo iptables -D INPUT $indice
				dialog --infobox 'Regra apagada com sucesso!' 0 0
				read
				;;
			2) 
				regras=$(sudo iptables -L OUTPUT --line-numbers)
				indice=$(dialog --inputbox "OUTPUT:\n\n$regras" 20 60 --stdout)
				sudo iptables -D OUTPUT $indice
				dialog --infobox 'Regra apagada com sucesso!' 0 0
				read
				;;
			3) 
				regras=$(sudo iptables -L FORWARD --line-numbers)
				indice=$(dialog --inputbox "FORWARD:\n\n$regras" 20 60 --stdout)
				sudo iptables -D FORWARD $indice
				dialog --infobox 'Regra apagada com sucesso!' 0 0
				read
				;;
			4) menu_principal;;
			*) dialog --infobox 'Opção inválida!' 0 0;;
		esac
	done
}

salvar_regra_do_firewall(){
	nome=$(dialog --stdout --inputbox 'Nome do arquivo(ex: firewall.txt): ' 20 60)
	sudo iptables-save > $nome
	dialog --infobox 'Arquivo salvo com sucesso!' 0 0
	read
}

restaurar_regras_do_firewall(){
	lista=$(ls)
	regras=$( dialog --inputbox "Arquivos:\n\n$lista" 20 60 --stdout )
	sudo iptables-restore < $regras
	dialog --infobox 'Regras restauradas com sucesso!' 0 0
	read
}

menu_opcoes_firewall(){
    while [ $? == 0 ];do
        opcao=$( dialog --stdout --menu 'Digite uma opção?' 0 0 0 1 'Criar uma regra' 2 'Configurar Política Padrão' 3 'Apagar uma regra'  4 'Listar todas as regras' 5 'Apagar todas as regras' 6 'Salvar as regras do firewall' 7 'Restaurar as regras do firewall' 8 'Voltar')
        case $opcao in
            1) criar_regra;;
            2) politica_padrao;;
            3) apagar_uma_regra;;
            4) listar_regras;;
            5) apagar_regras;;
            6) salvar_regra_do_firewall;;
            7) restaurar_regras_do_firewall;;
            8) menu_principal;;
            *) dialog --infobox 'Opção inválida!' 0 0;;
        esac
    done
}

menu_principal(){
resposta=$( dialog --stdout --menu "Bem-vindo!\n Escolha sua opcao:" 0 0 0 1 "Configurar firewall" 2 "Participantes" 3 "Sair")
case $resposta in 
    1) menu_opcoes_firewall;;
    2) listar_participantes;;
    3) dialog --infobox 'Saindo do Script!' 0 0 \ 
    exit 
esac
}

menu_principal