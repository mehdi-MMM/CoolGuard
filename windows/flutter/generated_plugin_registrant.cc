//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <screen_retriever_windows/screen_retriever_windows_plugin_c_api.h>
#include <simple_animation_progress_bar/simple_animation_progress_bar_plugin_c_api.h>
#include <window_manager/window_manager_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  ScreenRetrieverWindowsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ScreenRetrieverWindowsPluginCApi"));
  SimpleAnimationProgressBarPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("SimpleAnimationProgressBarPluginCApi"));
  WindowManagerPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowManagerPlugin"));
}
