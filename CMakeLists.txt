cmake_minimum_required(VERSION 3.16)

project(apptristsmallgui VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_GENERATE_QMLLS_INI ON)

# Set rpath for Qt frameworks on macOS (for development/build directory)
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH "@executable_path/../Frameworks")
set(CMAKE_INSTALL_RPATH_USE_LINK_ORIGIN TRUE)
set(CMAKE_BUILD_RPATH "your qt lib")

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES qt version)

qt_add_executable(apptristsmallgui
    main.cpp
)

qt_add_qml_module(apptristsmallgui
    URI apptristsmallgui
    QML_FILES
        Main.qml
        qml/components/ActivityBar.qml
        qml/components/ActivityBarItem.qml
        qml/components/Sidebar.qml
        qml/components/SidebarPanel.qml
        qml/components/MainContent.qml
        qml/components/RightPanel.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(apptristsmallgui PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.apptristsmallgui
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(apptristsmallgui
    PRIVATE Qt6::Quick Qt6::QuickControls2
)

install(TARGETS apptristsmallgui
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
