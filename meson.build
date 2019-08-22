project('com.github.padjis.gcron','vala','c')

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
    'src/util/Descriptor.vala',
    'src/util/Cron.vala',
    dependencies: [
        dependency('gtk+-3.0')
    ],
    install:true
)
