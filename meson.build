project('com.github.padjis.gcron','vala','c', version: '1.0.1')

config_data = configuration_data()
config_data.set('EXEC_NAME', meson.project_name())

i18n = import('i18n')

# Src build
message('Src build')

conf_data = configuration_data()
conf_data.set_quoted('PROJECT_NAME', meson.project_name())
conf_data.set_quoted('GETTEXT_PACKAGE', meson.project_name())
conf_data.set_quoted('VERSION', meson.project_version())
conf_data.set_quoted('PREFIX', get_option('prefix'))

gnome = import('gnome')

# Include GResource
asresources = gnome.compile_resources(
    'as-resources', join_paths('data', 'com.github.padjis.gcron.gresource.xml'),
    source_dir: 'data',
    c_name: 'as'
)

message('Configuring desktop entry: ' + meson.project_name() + '.desktop')

executable(
    meson.project_name(),
    'src/Main.vala',
    'src/Application.vala',
    'src/window/Window.vala',
    'src/component/Grid.vala',
    'src/component/ListBox.vala',
    'src/component/ReadOnlyEntry.vala',
    'src/component/button/DisplayButton.vala',
    'src/component/button/FullExplainButton.vala',
    'src/component/button/EmptyLineButton.vala',
    'src/component/button/DeleteButton.vala',
    'src/util/Descriptor.vala',
    'src/util/Cron.vala',
    asresources,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('gio-2.0')
    ],
    install:true
)

subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')