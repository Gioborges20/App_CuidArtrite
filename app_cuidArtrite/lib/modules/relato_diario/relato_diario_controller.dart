import 'package:app_osteoartrite/modules/relato_diario/relato_diario_service.dart';
import 'package:app_osteoartrite/modules/stat_item.dart';
import 'package:app_osteoartrite/shared/services/auth_service.dart';

class RelatoDiarioController {
  final _service = RelatoDiarioService();

  Future<List<StatItem>> carregarGraficoDaSemana(String pergunta) async {
    final uid = AuthService.instance.usuarioAtual!.uid;

    final historico = await _service.getRelatosUltimos7Dias(uid);

    if (historico.isEmpty) return [];

    Map<int, double> soma = {};
    Map<int, int> cont = {};

    for (var doc in historico) {
      final data = doc["data"]?.toDate();
      if (data == null) continue;

      final valor = double.tryParse(doc[pergunta].toString());
      if (valor == null) continue;

      final dia = data.weekday;

      soma[dia] = (soma[dia] ?? 0) + valor;
      cont[dia] = (cont[dia] ?? 0) + 1;
    }

    List<StatItem> lista = [];

    for (int dia = 1; dia <= 7; dia++) {
      final media = (soma[dia] ?? 0) / (cont[dia] ?? 1);
      lista.add(StatItem(day: dia, value: media));
    }

    return lista;
  }
}