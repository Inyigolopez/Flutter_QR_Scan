import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:qr_reader_app/src/model/scan_model.dart';


class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final mapController = new MapController();

  String tipoMapa = 'dark-v10';

  @override
  Widget build(BuildContext context) {
    
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: (){
              mapController.move(scan.getLatLng(), 17.0);
            },
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  _crearFlutterMap(ScanModel scan) {

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 17.0,
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ]
    ); 

  }

  _crearMapa() {

    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/styles/v1/'
            '{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {
          'accessToken':'pk.eyJ1IjoiaW55aWdvbG9wZXoiLCJhIjoiY2thandmazFxMGF6MTJxbzZzZDFudzl5bSJ9.bF_NnCIh8r4RqRK2_oudow',
          'id': 'mapbox/${this.tipoMapa}'
                        // streets-v11
                        // outdoors-v11
                        // light-v10
                        // dark-v10
                        // satellite-v9
                        // satellite-streets-v11

        }
    );

  }

  _crearMarcadores(ScanModel scan) {

    return  MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 80.0,
          height: 80.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor
            ),
          ),
        ),
      ]
    );

  }

  Widget _crearBotonFlotante(BuildContext context) {

    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if(tipoMapa == 'streets-v11'){
          tipoMapa = 'outdoors-v11';
        }else if(tipoMapa == 'outdoors-v11'){
          tipoMapa = 'light-v10';
        }else if(tipoMapa == 'light-v10'){
          tipoMapa = 'dark-v10';
        }else if(tipoMapa == 'dark-v10'){
          tipoMapa = 'satellite-v9';
        }else if(tipoMapa == 'satellite-v9'){
          tipoMapa = 'satellite-streets-v11';
        }else{
          tipoMapa = 'streets-v11';
        }
        // streets-v11
        // outdoors-v11
        // light-v10
        // dark-v10
        // satellite-v9
        // satellite-streets-v11
        setState((){});

      },
    );

  }
}


