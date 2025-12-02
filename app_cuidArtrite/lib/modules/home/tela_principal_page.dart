import 'package:app_osteoartrite/modules/fortalecimento/fortalecimento_page.dart';
import 'package:app_osteoartrite/modules/alivia_dores/alivia_dores_page.dart';
import 'package:app_osteoartrite/modules/relato_diario/relato_diario_page.dart';
import 'package:app_osteoartrite/modules/relato_diario/relato_diario_service.dart';
import 'package:app_osteoartrite/shared/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:app_osteoartrite/modules/historico_dashboard/historico_dash_page.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class TelaPrincipalPage extends StatefulWidget {
  const TelaPrincipalPage({super.key});

  @override
  State<TelaPrincipalPage> createState() => _TelaPrincipal();
}

class _TelaPrincipal extends State<TelaPrincipalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CuidArtrite',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: Image(
            image: AssetImage('assets/logo.png'),
            width: 30,
          ),
        ),
        backgroundColor: const Color(0xFF13574C),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(159, 249, 252, 73),
                    border: Border.all(
                      color: const Color.fromARGB(23, 100, 100, 100),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                          child: Text(
                            'Relato Diário',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 71, 71, 71),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset('assets/ImageRelatoDiario.png'),
                        ),
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Perguntas sobre sua dor e intensidade.',
                            textAlign: TextAlign.center,

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 71, 71, 71),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              final usuarioId =
                                  AuthService.instance.usuarioAtual!.uid;
                              final relatoService = RelatoDiarioService();

                              // Verifica se já enviou hoje
                              final jaEnviado = await relatoService
                                  .relatoEnviadoHoje(usuarioId);

                              if (jaEnviado) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Você já enviou um relato hoje."),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              if (!mounted) return;

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RelatoDiaPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF13574C),
                            ),
                            child: const Text(
                              'Iniciar Relato',
                              style: TextStyle(color: Color(0xFF13574C)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // --- ALTERAÇÃO FEITA AQUI ---
              // Gráfico do histórico do usuário (Agora Clicável)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: InkWell(
                  // Adiciona o efeito de clique
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    // Navega para a página de detalhes que criamos
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RelatosHistoricoPage()),
                    );
                  },
                  child: const GraficoSemanalCard(),
                ),
              ),
              // ----------------------------

              // --- CARD 2: PRÁTICAS FÍSICAS ---
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(121, 181, 243, 214),
                    border: Border.all(
                      color: const Color.fromARGB(23, 100, 100, 100),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(197, 33, 129, 100),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: const Center(
                          child: Text(
                            'Exerça Práticas Físicas!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 49, 49, 49),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'A prática de exercícios físicos pode ser numa grande aliada contra a osteoartrite.'
                                '\nAo executá-las, fortalecemos nossas articulações e criamos uma “barreira” contra lesões.',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // --- CARD 3: ALIVIA DORES ---
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(121, 181, 243, 214),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 400,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset('assets/iconHappy.png'),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Aliviando as dores',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 49, 49, 49),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('Assita aos vídeos!',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 117, 117, 117))),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AliviaDor()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF13574C)),
                            child: const Text(
                              'Iniciar',
                              style: TextStyle(color: Color(0xFF13574C)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(121, 181, 243, 214),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: 400,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child:
                            Image.asset('assets/iconFortalecimentoJoelho.png'),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Fortalecendo a articulação',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 49, 49, 49),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('Assita aos vídeos!',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 117, 117, 117))),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FortalecimentoJoelho()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF13574C)),
                            child: const Text(
                              'Iniciar',
                              style: TextStyle(color: Color(0xFF13574C)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GraficoSemanalCard extends StatefulWidget {
  const GraficoSemanalCard({super.key});

  @override
  State<GraficoSemanalCard> createState() => _GraficoSemanalCardState();
}

class _GraficoSemanalCardState extends State<GraficoSemanalCard> {
  final RelatoDiarioService service = RelatoDiarioService();
  bool isLoading = true;
  List<BarChartGroupData> barrasDoGrafico = [];
  List<String> datasFormatadas = [];

  @override
  void initState() {
    super.initState();
    carregarDadosDoGrafico();
  }

  Future<void> carregarDadosDoGrafico() async {
    try {
      final uid = AuthService.instance.usuarioAtual?.uid;
      if (uid == null) {
        setState(() => isLoading = false);
        return;
      }

      final relatos = await service.getRelatos(uid);
      final relatosRecentes = relatos.take(7).toList().reversed.toList();

      List<BarChartGroupData> items = [];
      List<String> datas = [];
      int index = 0;

      for (var relato in relatosRecentes) {
        final respostas = relato['respostas'] as Map<String, dynamic>;
        double somaPontos = 0;
        respostas.forEach((key, value) {
          if (value != null) somaPontos += (value as int);
        });

        final timestamp = relato['data_envio'];
        DateTime data = (timestamp is Timestamp)
            ? timestamp.toDate()
            : timestamp as DateTime;

        datas.add(DateFormat('dd/MM').format(data));

        items.add(
          BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: somaPontos,
                color: const Color(0xFF13574C),
                width: 14,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          ),
        );
        index++;
      }

      if (mounted) {
        setState(() {
          barrasDoGrafico = items;
          datasFormatadas = datas;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => isLoading = false);
      print("Erro gráfico: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: const Color.fromARGB(103, 124, 192, 197),
        border: Border.all(
          color: const Color.fromARGB(255, 158, 158, 158),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Seu Histórico Recente',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 49, 49, 49),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Nível de dor relatada nos últimos dias',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 116, 116, 116),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : barrasDoGrafico.isEmpty
                      ? const Center(
                          child: Text("Nenhum relato encontrado ainda."),
                        )
                      : BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 100,
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              horizontalInterval: 25,
                              getDrawingHorizontalLine: (value) => FlLine(
                                color:
                                    const Color.fromARGB(255, 160, 160, 160),
                                strokeWidth: 1,
                              ),
                            ),
                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: false)), 
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    int idx = value.toInt();
                                    if (idx >= 0 &&
                                        idx < datasFormatadas.length) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          datasFormatadas[idx],
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      );
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                            ),
                            barGroups: barrasDoGrafico,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
