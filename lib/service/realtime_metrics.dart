import 'dart:developer' as developer;
import 'package:vm_service/vm_service.dart' as vm_service;
import 'package:vm_service/vm_service_io.dart' as vm_service_io;
import 'dart:async';

class RealTimeMetrics {
  Timer? _timer;
  final int intervalMilliseconds;

  RealTimeMetrics({this.intervalMilliseconds = 1000});

  Future<void> startMonitoring() async {
    try {
      final serviceProtocolInfo = await developer.Service.getInfo();
      final wsUri = serviceProtocolInfo.serverUri!.replace(scheme: 'ws').toString() + 'ws';
      final service = await vm_service_io.vmServiceConnectUri(wsUri);
      final vm = await service.getVM();
      final isolate = vm.isolates!.first;

      _timer = Timer.periodic(Duration(milliseconds: intervalMilliseconds), (timer) async {
        try {
          final allocationProfile = await service.getAllocationProfile(isolate.id!);
          final memoryUsage = allocationProfile.memoryUsage;
          print('Memory usage: $memoryUsage');

          final cpuUsage = await service.getCpuSamples(isolate.id!, 0, 0);
          print('CPU usage: ${cpuUsage.samples}');
        } catch (e) {
          print('Error retrieving metrics: $e');
        }
      });
    } catch (e) {
      print('Error connecting to VM service: $e');
    }
  }

  void stopMonitoring() {
    _timer?.cancel();
  }
}