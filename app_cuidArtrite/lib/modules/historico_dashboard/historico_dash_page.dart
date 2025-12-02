import 'package:app_osteoartrite/modules/relato_diario/relato_diario_service.dart';
import 'package:app_osteoartrite/shared/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fl_chart/fl_chart.dart'; // <--- Necessário para o gráfico

class RelatosHistoricoPage extends StatefulWidget {
  const RelatosHistoricoPage({super.key});

  @override
  State<RelatosHistoricoPage> createState() => _RelatosHistoricoPageState();
}

class _RelatosHistoricoPageState extends State<RelatosHistoricoPage> {
  final RelatoDiarioService service = RelatoDiarioService();
  bool isLoading = true;
  List<Map<String, dynamic>> relatos = [];

  // Estatísticas
  List<MapEntry<String, double>> topDores = []; // Guarda as ações mais dolorosas

  // Dados do Gráfico
  List<BarChartGroupData> barrasDoGrafico = [];
  List<String> datasGrafico = [];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      await initializeDateFormatting('pt_BR', null);
      final uid = AuthService.instance.usuarioAtual?.uid;
      if (uid == null) return;

      final dados = await service.getRelatos(uid);

      if (mounted) {
        setState(() {
          relatos = dados;
          processarEstatisticasEGrafico(dados);
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
      }
      print("Erro: $e");
    }
  }

  void processarEstatisticasEGrafico(List<Map<String, dynamic>> listaRelatos) {
    if (listaRelatos.isEmpty) return;

    // --- 1. LÓGICA DAS TOP DORES (Média por atividade) ---
    Map<String, int> somaPorAtividade = {};
    Map<String, int> qtdPorAtividade = {};

    // --- 2. PREPARAÇÃO DO GRÁFICO (Invertendo para ordem cronológica) ---
    // Pegamos até 7 dias para o gráfico não ficar espremido
    final listaGrafico = listaRelatos.take(7).toList().reversed.toList();
    List<BarChartGroupData> itemsChart = [];
    List<String> datasChart = [];
    int indexChart = 0;

    // Loop principal para processar estatísticas GERAIS
    for (var relato in listaRelatos) {
      final respostas = relato['respostas'] as Map<String, dynamic>;
      respostas.forEach((key, value) {
        if (value is int) {
          somaPorAtividade[key] = (somaPorAtividade[key] ?? 0) + value;
          qtdPorAtividade[key] = (qtdPorAtividade[key] ?? 0) + 1;
        }
      });
    }

    // Loop secundário APENAS para montar o Gráfico (últimos 7 dias)
    for (var relato in listaGrafico) {
       final respostas = relato['respostas'] as Map<String, dynamic>;
       double somaDia = 0;
       respostas.forEach((key, value) {
         if (value != null) somaDia += (value as int);
       });

       final timestamp = relato['data_envio'];
       DateTime data = (timestamp is Timestamp) ? timestamp.toDate() : timestamp as DateTime;
       datasChart.add(DateFormat('dd/MM').format(data));

       itemsChart.add(
         BarChartGroupData(
           x: indexChart,
           barRods: [
             BarChartRodData(
               toY: somaDia,
               color: const Color(0xFF13574C),
               width: 12,
               borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
             ),
           ],
         ),
       );
       indexChart++;
    }

    // --- CÁLCULO FINAL DAS MÉDIAS ---
    Map<String, double> medias = {};
    somaPorAtividade.forEach((key, soma) {
      int qtd = qtdPorAtividade[key] ?? 1;
      medias[key] = soma / qtd;
    });

    // Ordena do maior para o menor e pega os top 3
    var sortedEntries = medias.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    topDores = sortedEntries.take(3).toList();
    barrasDoGrafico = itemsChart;
    datasGrafico = datasChart;
  }

  // Helpers de UI
  String getLabelIntensidade(int valor) {
    if (valor <= 1) return "Fraca";
    if (valor == 2) return "Ligeira";
    if (valor == 3) return "Média";
    if (valor == 4) return "Severa";
    return "Extrema";
  }

  Color getColorIntensidade(int valor) {
    if (valor <= 1) return Colors.green;
    if (valor == 2) return Colors.lightGreen;
    if (valor == 3) return Colors.orange;
    if (valor == 4) return Colors.deepOrange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Histórico", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF13574C),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  // --- 1. CARD "ONDE MAIS DOEU" ---
                  const Text(
                    "Atividades com maior desconforto",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                         BoxShadow(color: Colors.grey.shade200, blurRadius: 5, offset: const Offset(0, 3))
                      ]
                    ),
                    child: topDores.isEmpty 
                    ? const Text("Dados insuficientes.")
                    : Column(
                      children: topDores.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            children: [
                              // Ícone de alerta ou bolinha
                              Container(
                                width: 10, height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: getColorIntensidade(entry.value.round())
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  entry.key.replaceAll('_', ' ').capitalize(),
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                              ),
                              Text(
                                getLabelIntensidade(entry.value.round()),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: getColorIntensidade(entry.value.round())
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- 2. O GRÁFICO (REINSERIDO) ---
                  const Text(
                    "Visão Geral da Semana",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(103, 124, 192, 197), // Mesma cor do card anterior
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: barrasDoGrafico.isEmpty
                    ? const Center(child: Text("Sem dados suficientes para o gráfico"))
                    : BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 100, // Ajuste conforme necessário
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: true, drawVerticalLine: false),
                          titlesData: FlTitlesData(
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  int idx = value.toInt();
                                  if (idx >= 0 && idx < datasGrafico.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(datasGrafico[idx], style: const TextStyle(fontSize: 10)),
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

                  const SizedBox(height: 24),

                  // --- 3. LISTA HISTÓRICO COMPLETO ---
                  const Text(
                    "Histórico Diário Detalhado",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: relatos.length,
                    itemBuilder: (context, index) {
                      final item = relatos[index];
                      final timestamp = item['data_envio'];
                      DateTime data = (timestamp is Timestamp) ? timestamp.toDate() : timestamp as DateTime;
                      
                      final respostas = item['respostas'] as Map<String, dynamic>;
                      int soma = 0; int qtd = 0;
                      respostas.forEach((k, v) { if(v != null) { soma += v as int; qtd++; } });
                      double media = qtd > 0 ? soma / qtd : 0;

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF13574C),
                            child: Text(DateFormat('dd').format(data), style: const TextStyle(color: Colors.white)),
                          ),
                          title: Text(
                            DateFormat("EEEE, d 'de' MMMM", 'pt_BR').format(data),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Média geral do dia: ${getLabelIntensidade(media.round())}"),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: respostas.entries.map((entry) {
                                  final perguntaFormatada = entry.key.replaceAll('_', ' ').capitalize();
                                  final valor = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(perguntaFormatada),
                                        Text(
                                          getLabelIntensidade(valor),
                                          style: TextStyle(fontWeight: FontWeight.bold, color: getColorIntensidade(valor)),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
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

// Extensãozinha auxiliar para capitalizar strings
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}