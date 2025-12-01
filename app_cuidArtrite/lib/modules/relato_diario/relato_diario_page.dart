import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:app_osteoartrite/modules/relato_diario/relato_diario_service.dart';
import 'package:app_osteoartrite/shared/services/auth_service.dart';

class RelatoDiaPage extends StatefulWidget {
  const RelatoDiaPage({super.key});

  @override
  State<RelatoDiaPage> createState() => _RelatoDiario();
}

class _RelatoDiario extends State<RelatoDiaPage> {
  int paginaIndex = 0;

  final Map<String, int?> perguntas = {};
  final relatoService = RelatoDiarioService();

  // Função que verifica se as perguntas foram respondidas de acordo com o id da questao
  bool paginaRespondida() {
    List<String> campos = [];

    if (paginaIndex == 0) {
      campos = [
        'dor_caminhar',
        'dor_subir',
        'dor_sentar',
        'dor_deitar',
        'dor_empe',
      ];
    } else if (paginaIndex == 1) {
      campos = ['rigidez_acordar', 'rigidez_levantar'];
    } else if (paginaIndex == 2) {
      campos = [
        'funcao_escadas',
        'funcao_levantar_apos_sentar',
        'funcao_ficando_de_pe',
        'funcao_abaixar',
        'funcao_andar',
      ];
    } else if (paginaIndex == 3) {
      campos = [
        'funcao_carro',
        'funcao_meias',
        'funcao_levantando',
        'funcao_deitando',
        'funcao_banho',
      ];
    } else if (paginaIndex == 4) {
      campos = [
        'funcao_sentar',
        'funcao_levantar',
        'funcao_tarefas_domesticas_leves',
        'funcao_tarefas_domesticas_pesadas',
      ];
    }

    for (var key in campos) {
      if (perguntas[key] == null) {
        return false;
      }
    }

    return true;
  }

  // Mensagem de erro quando o usuário não responde todas as perguntas
  void mostrarErro() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Responda todas as perguntas antes de continuar."),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Widget para o input radio das questões
  Widget buildRadio(String questaoId, String label, int value) {
    final selectedValue = perguntas[questaoId];

    return GestureDetector(
      onTap: () {
        setState(() {
          perguntas[questaoId] = value;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<int>(
            value: value,
            groupValue: selectedValue,
            onChanged: (v) {
              setState(() {
                perguntas[questaoId] = v;
              });
            },
          ),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }


  Widget perguntasDor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Perguntas relacionadas à dor:',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 20),

        const Text('Dor ao caminhar'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('dor_caminhar', 'Fraca', 1),
            buildRadio('dor_caminhar', 'Ligeira', 2),
            buildRadio('dor_caminhar', 'Média', 3),
            buildRadio('dor_caminhar', 'Severa', 4),
            buildRadio('dor_caminhar', 'Extrema', 5),
          ],
        ),

        const SizedBox(height: 20),

        const Text('Dor ao subir escadas'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('dor_subir', 'Fraca', 1),
            buildRadio('dor_subir', 'Ligeira', 2),
            buildRadio('dor_subir', 'Média', 3),
            buildRadio('dor_subir', 'Severa', 4),
            buildRadio('dor_subir', 'Extrema', 5),
          ],
        ),

        const SizedBox(height: 20),

        const Text('Dor ao sentar'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('dor_sentar', 'Fraca', 1),
            buildRadio('dor_sentar', 'Ligeira', 2),
            buildRadio('dor_sentar', 'Média', 3),
            buildRadio('dor_sentar', 'Severa', 4),
            buildRadio('dor_sentar', 'Extrema', 5),
          ],
        ),

        const SizedBox(height: 20),

        const Text('Dor ao deitar'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('dor_deitar', 'Fraca', 1),
            buildRadio('dor_deitar', 'Ligeira', 2),
            buildRadio('dor_deitar', 'Média', 3),
            buildRadio('dor_deitar', 'Severa', 4),
            buildRadio('dor_deitar', 'Extrema', 5),
          ],
        ),

        const SizedBox(height: 20),

        const Text('Dor ao ficar em pé'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('dor_empe', 'Fraca', 1),
            buildRadio('dor_empe', 'Ligeira', 2),
            buildRadio('dor_empe', 'Média', 3),
            buildRadio('dor_empe', 'Severa', 4),
            buildRadio('dor_empe', 'Extrema', 5),
          ],
        ),

        const SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: paginaIndex > 0,
              child: botao("Voltar", () {
                setState(() => paginaIndex--);
              }),
            ),
            botao("Próximo", () {
              if (!paginaRespondida()) {
                mostrarErro();
                return;
              }
              setState(() => paginaIndex++);
            }),
          ],
        ),
      ],
    );
  }

  Widget perguntasRigidez() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Perguntas relacionadas à rigidez:',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 20),

        const Text('Após acordar pela primeira vez'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('rigidez_acordar', 'Fraca', 1),
            buildRadio('rigidez_acordar', 'Ligeira', 2),
            buildRadio('rigidez_acordar', 'Média', 3),
            buildRadio('rigidez_acordar', 'Severa', 4),
            buildRadio('rigidez_acordar', 'Extrema', 5),
          ],
        ),

        const SizedBox(height: 20),

        const Text('Ao final do dia'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('rigidez_levantar', 'Fraca', 1),
            buildRadio('rigidez_levantar', 'Ligeira', 2),
            buildRadio('rigidez_levantar', 'Média', 3),
            buildRadio('rigidez_levantar', 'Severa', 4),
            buildRadio('rigidez_levantar', 'Extrema', 5),
          ],
        ),

        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            botao("Voltar", () {
              setState(() => paginaIndex--);
            }),
            botao("Próximo", () {
              if (!paginaRespondida()) {
                mostrarErro();
                return;
              }
              setState(() => paginaIndex++);
            }),
          ],
        ),
      ],
    );
  }

  // Separei as perguntas de função física em 3 partes para não ficar maçante parao usuário
  Widget funcaoFisicaParte1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Perguntas relacionadas a função física:"),
        const SizedBox(height: 20),
        const Text("Ao usar escadas"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_escadas', "Fraca", 1),
            buildRadio('funcao_escadas', "Ligeira", 2),
            buildRadio('funcao_escadas', "Média", 3),
            buildRadio('funcao_escadas', "Severa", 4),
            buildRadio('funcao_escadas', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Levantar após sentar"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_levantar_apos_sentar', "Fraca", 1),
            buildRadio('funcao_levantar_apos_sentar', "Ligeira", 2),
            buildRadio('funcao_levantar_apos_sentar', "Média", 3),
            buildRadio('funcao_levantar_apos_sentar', "Severa", 4),
            buildRadio('funcao_levantar_apos_sentar', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Ficando de pé"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_ficando_de_pe', "Fraca", 1),
            buildRadio('funcao_ficando_de_pe', "Ligeira", 2),
            buildRadio('funcao_ficando_de_pe', "Média", 3),
            buildRadio('funcao_ficando_de_pe', "Severa", 4),
            buildRadio('funcao_ficando_de_pe', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Ao se abaixar"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_abaixar', "Fraca", 1),
            buildRadio('funcao_abaixar', "Ligeira", 2),
            buildRadio('funcao_abaixar', "Média", 3),
            buildRadio('funcao_abaixar', "Severa", 4),
            buildRadio('funcao_abaixar', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Ao andar"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_andar', "Fraca", 1),
            buildRadio('funcao_andar', "Ligeira", 2),
            buildRadio('funcao_andar', "Média", 3),
            buildRadio('funcao_andar', "Severa", 4),
            buildRadio('funcao_andar', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            botao("Voltar", () {
              setState(() => paginaIndex--);
            }),
            botao("Próximo", () {
              if (!paginaRespondida()) {
                mostrarErro();
                return;
              }
              setState(() => paginaIndex++);
            }),
          ],
        ),
      ],
    );
  }

  Widget funcaoFisicaParte2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Perguntas relacionadas a função física:"),
        const SizedBox(height: 20),
        const Text("Entrando/Saindo do carro"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_carro', "Fraca", 1),
            buildRadio('funcao_carro', "Ligeira", 2),
            buildRadio('funcao_carro', "Média", 3),
            buildRadio('funcao_carro', "Severa", 4),
            buildRadio('funcao_carro', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Colocando/Tirando as meias"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_meias', "Fraca", 1),
            buildRadio('funcao_meias', "Ligeira", 2),
            buildRadio('funcao_meias', "Média", 3),
            buildRadio('funcao_meias', "Severa", 4),
            buildRadio('funcao_meias', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Levantando da cama"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_levantando', "Fraca", 1),
            buildRadio('funcao_levantando', "Ligeira", 2),
            buildRadio('funcao_levantando', "Média", 3),
            buildRadio('funcao_levantando', "Severa", 4),
            buildRadio('funcao_levantando', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Deitando na cama"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_deitando', "Fraca", 1),
            buildRadio('funcao_deitando', "Ligeira", 2),
            buildRadio('funcao_deitando', "Média", 3),
            buildRadio('funcao_deitando', "Severa", 4),
            buildRadio('funcao_deitando', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Entrando/saindo do banho"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_banho', "Fraca", 1),
            buildRadio('funcao_banho', "Ligeira", 2),
            buildRadio('funcao_banho', "Média", 3),
            buildRadio('funcao_banho', "Severa", 4),
            buildRadio('funcao_banho', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            botao("Voltar", () {
              setState(() => paginaIndex--);
            }),
            botao("Próximo", () {
              if (!paginaRespondida()) {
                mostrarErro();
                return;
              }
              setState(() => paginaIndex++);
            }),
          ],
        ),
      ],
    );
  }

  Widget funcaoFisicaParte3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Perguntas relacionadas a função física:"),
        const SizedBox(height: 20),
        const Text("Ao sentar-se"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_sentar', "Fraca", 1),
            buildRadio('funcao_sentar', "Ligeira", 2),
            buildRadio('funcao_sentar', "Média", 3),
            buildRadio('funcao_sentar', "Severa", 4),
            buildRadio('funcao_sentar', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Ao levantar-se"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_levantar', "Fraca", 1),
            buildRadio('funcao_levantar', "Ligeira", 2),
            buildRadio('funcao_levantar', "Média", 3),
            buildRadio('funcao_levantar', "Severa", 4),
            buildRadio('funcao_levantar', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Ao fazer tarefas domésticas leves"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_tarefas_domesticas_leves', "Fraca", 1),
            buildRadio('funcao_tarefas_domesticas_leves', "Ligeira", 2),
            buildRadio('funcao_tarefas_domesticas_leves', "Média", 3),
            buildRadio('funcao_tarefas_domesticas_leves', "Severa", 4),
            buildRadio('funcao_tarefas_domesticas_leves', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Ao fazer tarefas domésticas pesadas"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadio('funcao_tarefas_domesticas_pesadas', "Fraca", 1),
            buildRadio('funcao_tarefas_domesticas_pesadas', "Ligeira", 2),
            buildRadio('funcao_tarefas_domesticas_pesadas', "Média", 3),
            buildRadio('funcao_tarefas_domesticas_pesadas', "Severa", 4),
            buildRadio('funcao_tarefas_domesticas_pesadas', "Extrema", 5),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            botao("Voltar", () {
              setState(() => paginaIndex--);
            }),
            botao("Finalizar", () async {
              if (!paginaRespondida()) {
                mostrarErro();
                return;
              }

              try {
                await relatoService.saveRelatos(
                  usuarioID: AuthService.instance.usuarioAtual!.uid,
                  respostas: perguntas,
                );

                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Respostas salvas com sucesso!"),
                    backgroundColor: Colors.green,
                  ),
                );

                setState(() {   // limpar o formulário
                  perguntas.clear();
                  paginaIndex = 0;
                });
                Modular.to.pushNamed('/relato_resultado');
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Erro ao salvar respostas: $e"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }),
          ],
        ),
      ],
    );
  }

  // componente do botão para não precisas repetir codigo
  Widget botao(String texto, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF13574C),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.black, width: 1),
        ),
      ),
      onPressed: onTap,
      child: Text(texto),
    );
  }

  // Mudar a wiget de acordo com o index da página
  Widget get currentWidget {
    switch (paginaIndex) {
      case 0:
        return perguntasDor();
      case 1:
        return perguntasRigidez();
      case 2:
        return funcaoFisicaParte1();
      case 3:
        return funcaoFisicaParte2();
      case 4:
        return funcaoFisicaParte3();
      default:
        return perguntasDor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Relato Diário',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: Image(image: AssetImage('assets/logo.png'), width: 30),
        ),
        backgroundColor: const Color(0xFF13574C),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(71, 0, 0, 0),
                    width: 1.0,
                  ),
                ),
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Avalie a intensidade da dor ao realizar as seguintes atividade durante o dia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 35),
                      SingleChildScrollView(child: currentWidget),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
