## Instrucoes

## Arquivo Vagrantfile

O arquivo Vagrantfile é onde está definido as configurações dos servidores que serão criados.

Nas linhas 6,7,8 e 9, estão as configurações das maquinas virtuais:
    ex: nome do servidor
        memoria
        cpu
        IP
        sistema operacional
        Disco

    ** Obs: Caso voce altere o nome do servidor, irá precisar editar o nome tambem no final do arquivo provision/script.sh


Na linha 20 estamos definindo o hostname das maquinas baseado nos nomes presentes no bloco machines, seguido pelo dominio "lab.example"

    ** Obs: Caso voce altere esse dominio, será necessário colocar o mesmo dominio tambem no arquivo provision/script.sh

Na linha 21 estamos definindo o tamanho do disco das maquinas baseado nos tamanhos presentes no bloco machines.

Na linha 22 estamos defininfo a rede que estes servidores irá utilizar, "172.16.17" (fica a seu criterio alterar).
    ** Caso voce altere essa rede, será necessário colocar a mesma rede tambem no arquivo provision/script.sh

Na linha 27 será criado 1 grupo no seu virtualbox chamado lab-monitoramento, onde será inserido suas maquinas virtuais recem criadas, facilitando na organização.

Na linha 31 será invocado 1 script que irá realizar alguns passos iniciais, como desabilitar o selinux, instalar pacotes basicos, criar 1 usuario e adicionar ao grupo de administradores, enviar 1 par de chaves rsa para evetuar login entre os servidores sem necessidade de informa senhas.


## Arquivo provision/script.sh

Dentro do diretorio provision , está o script que irá realizar algumas configurações basicas dos servidores que serão utilizados.

Nas linhas de 2 a 5 estão definidas algumas variaveis para definir a rede que voce utilizará neste lab,
o dominio, 1 usuario que será criado, e a senha desse usuario. Edite essas variaveis conforme seu ambiente.

As linhas 19, 20,21,35,36 e 38 , são referentes as chaves rsa que serão utilizadas para realizar login entre os servidores sem a necessidade de inserir senhas.
Obs: (Gere 1 par de chaves rsa ou copie as chaves rsa que voce já possui, e coloque dentro do diretorio files)
ex para gerar novas chaves rsa: ssh-keygen -t rsa -b 4096 -m PEM


Caso voce tenha editado os nomes das maquinas que serão criadas no arquivo Vagrantfile, altere respectivamente nas linhas linhas 45, 46, 47, 48 .


## Provisionamento do Lab

Apos realizar os ajustes necessarios nos arquivos, entre no diretorio onde está o arquivo Vagrantfile

Execute o comando:

$vagrant up

Ao final da execução do comando, serão criado 4 maquinas virtuais com 2 cpu e 2G de memoria.

Os servidores e ips serão os abaixos, caso não tenha alterado no Vagranfile e script.sh, em caso de alteração, estaram os dados que voce definiu.

172.16.17.10 | database-01.lab.example
172.16.17.20 | docker-swarm-01.lab.example
172.16.17.30 | docker-swarm-02.lab.example
172.16.17.40 | docker-swarm-03.lab.example
