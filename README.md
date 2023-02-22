## Estrutura do codigo

Este projeto possui uma arqutetura baseado no DDD("Domain Drive Desing")

Aqui está uma explicação da arquitetura DDD implementada no projeto:

A camada de aplicação ("Application") é responsável por orquestrar o fluxo de dados e serviços do sistema. É responsável por receber as requisições, delegar a lógica de negócio e orquestrar o fluxo dos dados através das camadas. Essa camada deve ser mantida o mais simples possível e não deve conter lógica de negócio.

A camada de domínio ("Domain") contém classes que são de dominio global tais como envio de e-mails, e outras funcionalidades.

A camada de infraestrutura ("Infra") é responsável por fornecer serviços de baixo nível, como acesso a banco de dados. É aqui que a persistência de dados é implementada, bem como a integração com outros sistemas.

A camada de Service("Service") é responsável por toda a logica de negocio da aplicação.

## Configuração do ambiente para executar o Aplicativo


Antes de iniciar, você precisará ter o seguinte instalado em sua máquina:

## Flutter SDK:  [Instruções de instalação] (https://docs.flutter.dev/get-started/install)
## Android Studio ou Xcode (para desenvolvimento no Android ou iOS, respectivamente): 
[Instruções de instalação do Android Studio](https://developer.android.com/studio/install?hl=pt-br) ou [Instruções de instalação do Xcode](https://developer.apple.com/xcode/resources/)


##  Instalando EasyHomeFlutter

Para instalar o EasyHomeFlutter, siga estas etapas:

Clone o repositório do projeto para sua máquina local.
Abra o terminal e navegue até o diretório do projeto.
Execute o seguinte comando para baixar as dependências do projeto

~~~flutter 
flutter pub get
~~~~

Conecte um dispositivo físico ou inicie um emulador. Para verificar se há dispositivos disponíveis, execute o seguinte comando:
~~~flutter 
flutter devices
~~~~

Execute o aplicativo em um dispositivo com o seguinte comando:
~~~flutter 
flutter run
~~~~

##  Colaboradores

Agradecemos às seguintes pessoas que contribuíram para este projeto:

<table>
  <tr>
    <td align="center">
      <a href="#">
        <img src="https://avatars.githubusercontent.com/u/54186456?v=4" width="100px;" alt="Foto do pagoto"/><br>
        <sub>
          <b>Gabriel Pagoto</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="#">
        <img src="https://avatars.githubusercontent.com/u/56005941?s=400&u=0282b7888567a9f7f3df62df4433743a38289305&v=4" width="100px;" alt="Foto do Jackson"/><br>
        <sub>
          <b>Jackson Longo</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="#">
        <img src="https://pps.whatsapp.net/v/t61.24694-24/298393423_191871359934710_1423164344747583347_n.jpg?ccb=11-4&oh=01_AdSyHhlJAx-4oOvzefy_-rsjgT97CccprYQ7J8Xo8UoVRw&oe=64037008" width="100px;" alt="Foto do Jose"/><br>
        <sub>
          <b>Jose Adilson</b>
        </sub>
      </a>
    </td>
  </tr>
</table>
