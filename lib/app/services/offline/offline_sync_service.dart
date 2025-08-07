import 'package:on_cloc_mobile/main.dart';

class OnClocOfflineSyncService {
  Future<bool> sync() async {
    onClocDbService.deleteWorkTracking();

    var trackingList = await onClocDbService.getAllWorkTrackingsList();

    for (var tracking in trackingList) {
      var result = await onClocApiService.syncTrackingFromMobile(tracking.toJson());
      if(result) {
        await onClocDbService.confirmWorkTrackingSync(tracking);
      }
    }
    return true;
  }

  Future<int> getSyncCount() async {
    return await onClocDbService.syncWorkTrackingCount();
  }
}