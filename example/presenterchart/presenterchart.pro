!include( ../example.pri ) {
 error( "Couldn't find the example.pri file!" )
}
TARGET = presenterchart
HEADERS += chartview.h
SOURCES += main.cpp chartview.cpp