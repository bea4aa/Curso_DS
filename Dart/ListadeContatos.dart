import 'package:flutter/material.dart'; 

 

void main() { 

  runApp(MyApp()); 

} 

 

class MyApp extends StatelessWidget { 

  @override 

  Widget build(BuildContext context) { 

    return MaterialApp( 

      title: 'Contatos', 

      debugShowCheckedModeBanner: false, 

      theme: ThemeData( 

        colorSchemeSeed: Color.fromARGB(255, 31, 131, 162), 

        useMaterial3: true, 

        scaffoldBackgroundColor: Color.fromARGB(255, 201, 204, 206), 

      ), 

      home: ContatoPage(), 

    ); 

  } 

} 

 

class Contato { 

  String nome; 

  String telefone; 

 

  Contato({required this.nome, required this.telefone}); 

} 

 

class ContatoPage extends StatefulWidget { 

  @override 

  State<ContatoPage> createState() => _ContatoPageState(); 

} 

 

class _ContatoPageState extends State<ContatoPage> { 

  final List<Contato> _contatos = []; 

  final _formKey = GlobalKey<FormState>(); 

  final _nomeController = TextEditingController(); 

  final _telController = TextEditingController(); 

  int? _editIndex; 

 

  void _salvarContato() { 

    if (_formKey.currentState!.validate()) { 

      setState(() { 

        if (_editIndex == null) { 

          _contatos.add(Contato( 

            nome: _nomeController.text.trim(), 

            telefone: _telController.text.trim(), 

          )); 

          _mostrarSnack('Contato adicionado'); 

        } else { 

          _contatos[_editIndex!] = Contato( 

            nome: _nomeController.text.trim(), 

            telefone: _telController.text.trim(), 

          ); 

          _mostrarSnack('Contato foi atualizado'); 

          _editIndex = null; 

        } 

        _nomeController.clear(); 

        _telController.clear(); 

        FocusScope.of(context).unfocus(); 

      }); 

    } 

  } 

 

  void _deletarContato(int index) { 

    final nome = _contatos[index].nome; 

    showDialog( 

      context: context, 

      builder: (ctx) => AlertDialog( 

        title: const Text('Excluir contato'), 

        content: Text('Quer excluir "$nome"?'), 

        actions: [ 

          TextButton( 

            onPressed: () => Navigator.pop(ctx), 

            child: const Text('Cancelar'), 

          ), 

          FilledButton( 

            style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(255, 85, 82, 255)), 

            onPressed: () { 

              setState(() => _contatos.removeAt(index)); 

              Navigator.pop(ctx); 

              _mostrarSnack('Contato "$nome" excluído'); 

            }, 

            child: const Text('Excluir'), 

          ), 

        ], 

      ), 

    ); 

  } 

 

  void _editarContato(int index) { 

    setState(() { 

      _editIndex = index; 

      _nomeController.text = _contatos[index].nome; 

      _telController.text = _contatos[index].telefone; 

    }); 

  } 

 

  void _mostrarSnack(String mensagem) { 

    ScaffoldMessenger.of(context).showSnackBar( 

      SnackBar( 

        content: Text(mensagem), 

        backgroundColor: Color.fromARGB(255, 31, 131, 162), 

        duration: const Duration(seconds: 2), 

      ), 

    ); 

  } 

 

  void _cEdicao() { 

    setState(() { 

      _editIndex = null; 

      _nomeController.clear(); 

      _telController.clear(); 

      FocusScope.of(context).unfocus(); 

    }); 

  } 

 

  @override 

  Widget build(BuildContext context) { 

    final bool isEditando = _editIndex != null; 

 

    return Scaffold( 

      appBar: AppBar( 

        title: const Text( 

          'Contatos', 

          style: TextStyle(fontWeight: FontWeight.bold), 

        ), 

        backgroundColor: Color.fromARGB(255, 31, 131, 162), 

        foregroundColor: Colors.white, 

        centerTitle: true, 

      ), 

      body: SingleChildScrollView( 

        padding: const EdgeInsets.all(16), 

        child: Column( 

          children: [ 

            AnimatedContainer( 

              duration: const Duration(milliseconds: 300), 

              decoration: BoxDecoration( 

                color: Color.fromARGB(255, 240, 238, 238), 

                borderRadius: BorderRadius.circular(16), 

                boxShadow: [ 

                  BoxShadow( 

                    color: Colors.black.withOpacity(0.05), 

                    blurRadius: 6, 

                    offset: const Offset(0, 3), 

                  ), 

                ], 

              ), 

              padding: const EdgeInsets.all(16), 

              child: Form( 

                key: _formKey, 

                child: Column( 

                  children: [ 

                    TextFormField( 

                      controller: _nomeController, 

                      decoration: const InputDecoration( 

                        labelText: 'Nome', 

                        prefixIcon: Icon(Icons.person), 

                        border: OutlineInputBorder(), 

                      ), 

                      validator: (v) => 

                          v == null || v.trim().isEmpty ? 'Digite o nome' : null, 

                    ), 

                    const SizedBox(height: 12), 

                    TextFormField( 

                      controller: _telController, 

                      keyboardType: TextInputType.phone, 

                      decoration: const InputDecoration( 

                        labelText: 'Telefone', 

                        prefixIcon: Icon(Icons.phone), 

                        border: OutlineInputBorder(), 

                      ), 

                      validator: (v) { 

                        if (v == null || v.trim().isEmpty) { 

                          return 'Digite o telefone'; 

                        } 

                        if (!RegExp(r'^[0-9()\-\s]+$').hasMatch(v)) { 

                          return 'Inválido'; 

                        } 

                        return null; 

                      }, 

                    ), 

                    const SizedBox(height: 16), 

                    Row( 

                      children: [ 

                        Expanded( 

                          child: FilledButton.icon( 

                            onPressed: _salvarContato, 

                            icon: Icon(isEditando ? Icons.save : Icons.add), 

                            label: Text( 

                                isEditando ? 'Atualizar' : 'Adicionar'), 

                            style: FilledButton.styleFrom( 

                              backgroundColor: isEditando 

                                  ? Color.fromARGB(255, 31, 131, 162) 

                                  : Color.fromARGB(255, 31, 131, 162), 

                              foregroundColor: Colors.black87, 

                              padding: const EdgeInsets.symmetric(vertical: 14), 

                            ), 

                          ), 

                        ), 

                        if (isEditando) ...[ 

                          const SizedBox(width: 8), 

                          IconButton( 

                            onPressed: _cEdicao, 

                            icon: const Icon(Icons.close, color: Color.fromARGB(255, 54, 105, 244)), 

                            tooltip: 'Cancelar', 

                          ), 

                        ], 

                      ], 

                    ), 

                  ], 

                ), 

              ), 

            ), 

            const SizedBox(height: 24), 

            _contatos.isEmpty 

                ? Padding( 

                    padding: const EdgeInsets.only(top: 50), 

                    child: Column( 

                      children: const [ 

                        Icon(Icons.contacts, size: 80, color: Colors.grey), 

                        SizedBox(height: 10), 

                        Text( 

                          'Nenhum contato aparente', 

                          style: TextStyle(color: Color.fromARGB(255, 49, 114, 235), fontSize: 16), 

                        ), 

                      ], 

                    ), 

                  ) 

                : ListView.builder( 

                    shrinkWrap: true, 

                    physics: const NeverScrollableScrollPhysics(), 

                    itemCount: _contatos.length, 

                    itemBuilder: (context, index) { 

                      final contato = _contatos[index]; 

                      return Card( 

                        shape: RoundedRectangleBorder( 

                          borderRadius: BorderRadius.circular(12), 

                        ), 

                        margin: const EdgeInsets.symmetric(vertical: 6), 

                        elevation: 2, 

                        child: ListTile( 

                          leading: CircleAvatar( 

                            backgroundColor: Color.fromARGB(255, 31, 131, 162), 

                            child: Text( 

                              contato.nome.isNotEmpty 

                                  ? contato.nome[0].toUpperCase() 

                                  : '?', 

                              style: const TextStyle(color: Colors.white), 

                            ), 

                          ), 

                          title: Text( 

                            contato.nome, 

                            style: const TextStyle(fontWeight: FontWeight.w600), 

                          ), 

                          subtitle: Text(contato.telefone), 

                          trailing: Wrap( 

                            spacing: 6, 

                            children: [ 

                              IconButton( 

                                icon: const Icon(Icons.edit, 

                                    color: Color.fromARGB(255, 34, 110, 241)), 

                                onPressed: () => _editarContato(index), 

                              ), 

                              IconButton( 

                                icon: const Icon(Icons.delete, 

                                    color: Color.fromARGB(255, 82, 137, 255)), 

                                onPressed: () => _deletarContato(index), 

                              ), 

                            ], 

                          ), 

                        ), 

                      ); 

                    }, 

                  ), 

          ], 

        ), 

      ), 

    ); 

  } 

} 