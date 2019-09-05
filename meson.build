project('com.github.padjis.gcron','vala','c',version:'0.0.1')

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

message('Configuring desktop entry: ' + meson.project_name() + '.desktop')

## Translate and install our .desktop file
#desktop_file = i18n.merge_file(
#    input: join_paths(meson.source_root(), 'data', meson.project_name() + '.desktop.in'),
#    output: meson.project_name() + '.desktop',
#    po_dir: join_paths(meson.source_root(), 'po'),
#    type: 'desktop',
#    install: true,
#    install_dir: join_paths(get_option('datadir'), 'applications')
#)

## Translate and install our .appdata file
#appstream_file = i18n.merge_file(
#    input: join_paths(meson.source_root(), 'data', meson.project_name() + '.appdata.xml.in'),
#    output: '@BASENAME@',
#    po_dir: join_paths(meson.source_root(), 'po'),
#    install: true,
#    install_dir: join_paths(get_option('datadir'), 'metainfo')
#)

executable(
    meson.project_name(),
    'src/Main.vala',
    'src/Application.vala',
    'src/window/Window.vala',
    'src/grid/Grid.vala',
    dependencies: [
        dependency('gtk+-3.0')
    ],
    install:true
)

subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')