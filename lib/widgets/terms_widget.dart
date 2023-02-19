import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class TermsViewScreen extends StatefulWidget {
  const TermsViewScreen({Key? key}) : super(key: key);


  @override
  _TermsViewScreenState createState() => _TermsViewScreenState();
}

class _TermsViewScreenState extends State<TermsViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Termos de Uso"),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              "Termos de Consentimento de Uso de Dados",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              "Este documento descreve como os seus dados pessoais serão coletados e usados pelo aplicativo imobiliário. Ao cadastrar-se neste aplicativo, você concorda com os termos e condições descritos abaixo.",
            ),
            SizedBox(height: 16.0),
            Text(
              "1. Coleta de Dados",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "O aplicativo imobiliário coletará seus dados pessoais para viabilizar o uso dos nossos serviços e permitir que você possa acessar todas as funcionalidades disponíveis. Os dados que coletamos incluem, mas não estão limitados a:",
            ),
            Text(
              "- Nome completo",
            ),
            Text(
              "- Endereço de e-mail",
            ),
            Text(
              "- Número de telefone",
            ),
            Text(
              "- Endereço residencial",
            ),
            Text(
              "- Documentos de identificação, como RG e CPF",
            ),
            SizedBox(height: 16.0),
            Text(
              "2. Uso de Dados",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "O aplicativo imobiliário utilizará seus dados pessoais para os seguintes propósitos:",
            ),
            Text(
              "- Permitir o acesso e uso do aplicativo e seus serviços",
            ),
            Text(
              "- Fornecer informações relevantes sobre imóveis e serviços relacionados",
            ),
            Text(
              "- Realizar transações, como aluguel ou compra de imóveis",
            ),
            Text(
              "- Verificar a identidade do usuário",
            ),
            Text(
              "- Responder a solicitações de suporte ao cliente",
            ),
            Text(
              "- Cumprir obrigações legais",
            ),
            SizedBox(height: 16.0),
            Text(
              "3. Compartilhamento de Dados",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "O aplicativo imobiliário poderá compartilhar seus dados pessoais com empresas terceirizadas que nos auxiliam no fornecimento dos nossos serviços. Também poderemos compartilhar seus dados com autoridades governamentais quando necessário para cumprir obrigações legais.",
            ),
            SizedBox(height: 16.0),
            Text(
              "4. Armazenamento de Dados",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "O aplicativo imobiliário armazenará seus dados pessoais em servidores seguros e protegidos. Os seus dados serão mantidos pelo tempo necessário para cumprir as finalidades para as quais foram coletados e para cumprir obrigações legais. Ao término deste período, seus dados pessoais serão excluídos de nossos sistemas, a menos que sejam necessários para fins de arquivamento ou histórico.",
            ),
            SizedBox(height: 16.0),
            Text(
              "5. Direitos dos Titulares de Dados",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Os usuários do aplicativo imobiliário têm direitos sobre seus dados pessoais. Você pode solicitar o acesso, retificação ou exclusão de seus dados, bem como contestar o processamento de seus dados pessoais. Para exercer seus direitos, entre em contato com nossa equipe de suporte ao cliente.",
            ),
            SizedBox(height: 16.0),
            Text(
              "6. Alterações nos Termos de Uso",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "O aplicativo imobiliário se reserva o direito de modificar estes termos de uso a qualquer momento. As alterações entrarão em vigor imediatamente após a publicação. Ao continuar a utilizar o aplicativo após a publicação das alterações, você concorda com as novas condições.",
            ),
          ],
        ),
      ),
    );
  }
}