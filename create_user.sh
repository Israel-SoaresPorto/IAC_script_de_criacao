#!/bin/bash

read -p "Nome de usuário: " name
printf "\n"

while
  echo "Grupo de usuário"
  echo "1 - GRP_ADM"
  echo "2 - GRP_VEN"
  echo "3 - GRP_SEC"
  echo "4 - Convidado"
  read -p "> " grp_option

  case $grp_option in
    1)
	grp="GRP_ADM" 
	break
	;;
    2)
	grp="GRP_VEN" 
	break
	;;
    3)
	grp="GRP_SEC" 
	break
	;;
    4)
	grp="convidado"
	break
	;;
    *)
	echo -e "\nDigite o grupo correspondente\n"
	;;
  esac
do true; done

printf "\n"

while
  echo -n "digite sua senha: "
  read -s password
  printf "\n"
  echo -n "digite sua senha novamente: "
  read -s confirm_password
  printf "\n"

  if [ "$password" = "$confirm_password" ]; then
	break
  else
	echo -e "\nsenha não corrspondem, digite novamente.\n"
  fi
do true; done

printf "\n"

if [ "$grp" = "convidado" ]; then
	sudo useradd $name -c "Usuario convidado" -s /bin/bash -m -p $(openssl passwd -6 "$password")
	sudo passwd $name -e 
else
	sudo useradd $name -m -s /bin/bash -p $(openssl passwd -6 "$password") -G $grp
fi

echo -e "Usuário criado com sucesso."
echo "Fim...."
