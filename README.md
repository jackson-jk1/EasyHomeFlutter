## Estrutura do codigo

O MVC (Model-View-Controller) é um padrão de arquitetura de software que é amplamente utilizado no desenvolvimento de aplicativos, incluindo aplicativos Flutter. Ele divide um aplicativo em três componentes principais: o modelo, a visualização e o controlador.

O modelo é responsável pelos dados e pela lógica do aplicativo. Ele é responsável por gerenciar o estado e fornecer a lógica de negócios para o aplicativo. O modelo não tem conhecimento da visualização ou do controlador, e é responsável por notificar os componentes do aplicativo sempre que os dados mudam.

A visualização é responsável por exibir os dados do aplicativo. Ela é responsável por fornecer uma interface gráfica para o usuário interagir com o aplicativo. A visualização não tem conhecimento do modelo ou do controlador e é atualizada sempre que o modelo notifica que houve uma mudança de estado.

O controlador é responsável por gerenciar a interação do usuário com a visualização e a lógica do aplicativo. Ele recebe entradas do usuário e as envia para o modelo para processamento. Ele também é responsável por atualizar a visualização quando o modelo notifica que houve uma mudança de estado.

Em um aplicativo Flutter, a visualização é geralmente implementada por meio de widgets, o modelo é implementado por meio de classes de dados ou serviços, e o controlador é implementado por meio de classes que controlam a interação do usuário e a lógica do aplicativo.

## Configuração do ambiente para executar o Aplicativo


Antes de iniciar, você precisará ter o seguinte instalado em sua máquina:

## Flutter SDK:  [Instruções de instalação] (https://docs.flutter.dev/get-started/install)
## Android Studio ou Xcode (para desenvolvimento no Android ou iOS, respectivamente): 
[Instruções de instalação do Android Studio](https://developer.android.com/studio/install?hl=pt-br) ou [Instruções de instalação do Xcode](https://developer.apple.com/xcode/resources/)


##  Instalando EasyHomeFlutter

Para instalar o EasyHomeFlutter, siga estas etapas:

* Clone o repositório do projeto para sua máquina local.
* Abra o terminal e navegue até o diretório do projeto.
* Execute o seguinte comando para baixar as dependências do projeto

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
