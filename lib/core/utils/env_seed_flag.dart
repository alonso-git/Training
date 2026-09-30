import 'env_seed_flag_stub.dart'
    if (dart.library.io) 'env_seed_flag_io.dart';

/// Returns true when the process was launched with NUTHY_SEED_SPLIT=1.
bool get seedSplitRequested => implSeedSplitRequested;
