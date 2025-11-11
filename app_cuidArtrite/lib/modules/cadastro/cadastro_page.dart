import 'package:flutter/material.dart';  

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _cadastroPageState();
}

const List<String>  list = <String>['Masculino', 'Feminino', 'Outro'];

class _cadastroPageState extends State<CadastroPage>{
  String? _sexoSelecionado;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        'CuidArtrite',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
      ),
      centerTitle: true,
      backgroundColor: Color(0xFF13574C),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Text(
              'Cadastro',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            ),
        const SizedBox(height: 22),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(24, 0, 0, 0),
              width: 1.0,),
          borderRadius: BorderRadius.circular(8.0),
          ),
          width: 330,
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text('Nome Completo', style: TextStyle(fontSize: 18))
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Digite seu nome completo',
                      border: OutlineInputBorder()
                       ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text('Data de Nascimento', style: TextStyle(fontSize: 18))
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'DD/MM/AAAA',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 8),
                    child: Text('Sexo', style: TextStyle(fontSize: 18))
                  ), 
                  DropdownButtonFormField<String>(
                    initialValue: _sexoSelecionado,
                    decoration: InputDecoration(hintText:'Selecione seu sexo', border: OutlineInputBorder()),
                    items: list.map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue){
                      setState((){
                        _sexoSelecionado = newValue;
                      });
                    }
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Text('Telefone', style: TextStyle(fontSize: 18))
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,

                    decoration: InputDecoration(
                    hintText: '(99) 99999-9999',
                    border: OutlineInputBorder()),

                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Insira um número de telefone.';
                      }
                      if(value.length < 15){
                        return 'Número de telefone incompleto.';
                      }
                      return null;
            },
          ),
                  ]
            ),
          ),
          ),
        ]
      ),
    )
    );
  }

}
