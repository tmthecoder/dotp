//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dotp_native/dotp_native_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dotp_native_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DotpNativePlugin");
  dotp_native_plugin_register_with_registrar(dotp_native_registrar);
}
