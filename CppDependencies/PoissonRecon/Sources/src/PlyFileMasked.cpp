// PlyFileMasked.cpp
// Wraps PlyFile.cpp with the file-scope PLY data tables renamed to avoid
// duplicate symbol conflicts with the app's ply_io implementation, which
// defines the same type_names and ply_type_size arrays from the same
// original Greg Turk PLY library.
#define type_names    _poissonrecon_type_names
#define ply_type_size _poissonrecon_ply_type_size
#include "PlyFile.cpp"
