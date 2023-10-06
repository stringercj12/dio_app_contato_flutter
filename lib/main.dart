import 'package:flutter/material.dart';
import 'package:lista_de_contatos/contato_model.dart';
import 'package:lista_de_contatos/contato_repository.dart';
import 'package:lista_de_contatos/contatos_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Lista de contatos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var contatoRepository = ContatoRepository();
  var contatosModel = ContatosModel([]);
  var nomeController = TextEditingController(text: "");
  var telefoneController = TextEditingController(text: "");
  var loading = false;

  void carregarDados() async {
    setState(() {
      loading = true;
    });
    contatosModel = await contatoRepository.obterContatos();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: ListView.builder(
                  itemCount: contatosModel.contatos.length,
                  itemBuilder: (BuildContext buildContext, int index) {
                    var contato = contatosModel.contatos[index];
                    return ListTile(title: Text(contato.nome));
                  },
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            nomeController.text = "";
            telefoneController.text = "";
            showDialog(
              context: context,
              builder: (BuildContext buildContext) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: const Text('Adicionar Contato'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(
                        height: 20,
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
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {});
                        carregarDados();
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        debugPrint(nomeController.text);
                        contatoRepository.criarTarefa(
                          Contato.criar(
                            "dsfdsf",
                            nomeController.text,
                            telefoneController.text,
                          ),
                        );
                        Navigator.pop(context);
                        setState(() {});
                        carregarDados();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Contato adicionado'),
                          ),
                        );
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
