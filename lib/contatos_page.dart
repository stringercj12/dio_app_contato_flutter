import 'package:flutter/material.dart';
import 'package:lista_de_contatos/contato_model.dart';
import 'package:lista_de_contatos/contato_repository.dart';
import 'package:lista_de_contatos/main.dart';

class ContatosPage extends StatefulWidget {
  const ContatosPage({super.key});

  @override
  State<ContatosPage> createState() => _ContatosPageState();
}

class _ContatosPageState extends State<ContatosPage> {
  var nomeController = TextEditingController(text: "");
  var telefoneController = TextEditingController(text: "");
  var contatoRepository = ContatoRepository();
  var loading = false;

  Future<void> salvarContato() async {
    setState(() {
      loading = true;
    });
    await contatoRepository.criarTarefa(
      Contato.criar(
        'sdsdsd',
        nomeController.text,
        telefoneController.text,
      ),
    );
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de contato'),
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const Text('Nome'),
              TextField(
                controller: nomeController,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Celular'),
              TextField(
                controller: telefoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  await contatoRepository.criarTarefa(
                    Contato.criar(
                      'sdsdsd',
                      nomeController.text,
                      telefoneController.text,
                    ),
                  );
                },
                child: loading
                    ? const Center(child: CircularProgressIndicator())
                    : const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
