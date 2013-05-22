!include( ../config.pri ) {
    error( "Couldn't find the config.pri file!" )
}

TEMPLATE = app

DESTDIR = $$CHART_BUILD_BIN_DIR
OBJECTS_DIR = $$CHART_BUILD_DIR/tests/$$TARGET
MOC_DIR = $$CHART_BUILD_DIR/tests/$$TARGET
UI_DIR = $$CHART_BUILD_DIR/tests/$$TARGET
RCC_DIR = $$CHART_BUILD_DIR/tests/$$TARGET

# staticlib config causes problems when building executables
staticlib: CONFIG-=staticlib

android {
    # Workaround to fix android deployment, which seems to always look for target in
    # OUT_PWD instead of DESTDIR.
    QMAKE_POST_LINK += $$QMAKE_COPY $$CHART_BUILD_BIN_DIR/lib$${TARGET}.so $$OUT_PWD/lib$${TARGET}.so

    contains(TARGET, qml.*) {
        charts_qmldir.files = $$CHART_BUILD_QML_PLUGIN_DIR/qmldir
        charts_qmldir.path = /assets/imports/QtCommercial/Chart
        charts_qmlplugin.files = $$CHART_BUILD_QML_PLUGIN_DIR/libqtcommercialchartqml.so
        charts_qmlplugin.path = /libs/$$ANDROID_TARGET_ARCH
        INSTALLS += charts_qmldir charts_qmlplugin
    } else:contains(TARGET, quick2.*) {
        charts_qmldir.files = $$CHART_BUILD_QML2_PLUGIN_DIR/qmldir
        charts_qmldir.path = /assets/qml/QtCommercial/Chart
        charts_qmlplugin.files = $$CHART_BUILD_QML2_PLUGIN_DIR/libqtcommercialchartqml2.so
        charts_qmlplugin.path = /libs/$$ANDROID_TARGET_ARCH
        INSTALLS += charts_qmldir charts_qmlplugin
    }
}
