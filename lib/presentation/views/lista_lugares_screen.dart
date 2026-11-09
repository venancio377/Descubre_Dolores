import 'package:flutter/material.dart';

import '../viewmodels/lugares_view_model.dart';
import 'detalle_lugar_screen.dart';

class ListaLugaresScreen extends StatefulWidget {
  final LugaresViewModel viewModel;

  const ListaLugaresScreen({super.key, required this.viewModel});

  @override
  State<ListaLugaresScreen> createState() => _ListaLugaresScreenState();
}

class _ListaLugaresScreenState extends State<ListaLugaresScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.cargar();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.viewModel,
      builder: (context, _) {
        final vm = widget.viewModel;
        if (vm.cargando) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final filtrados = vm.filtrados;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Descubre Dolores Hidalgo'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar lugar',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: vm.buscar,
                ),
                const SizedBox(height: 16),
                DropdownButton<String>(
                  value: vm.categoriaFiltro,
                  items: LugaresViewModel.categorias.map((opcion) {
                    return DropdownMenuItem<String>(
                      value: opcion,
                      child: Text(opcion),
                    );
                  }).toList(),
                  onChanged: (valor) => vm.cambiarCategoria(valor!),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtrados.length,
                    itemBuilder: (context, index) {
                      final lugar = filtrados[index];

                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(lugar.imagenAsset),
                          ),
                          title: Text(lugar.nombre),
                          subtitle: Text(lugar.descripcion, maxLines: 1, overflow: TextOverflow.ellipsis),
                          trailing: Text(lugar.categoria),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => DetalleLugarScreen(lugar: lugar),
                            ));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Próximamente: mapa de lugares')),
              );
            },
            child: const Icon(Icons.map),
          ),
        );
      },
    );
  }
}
