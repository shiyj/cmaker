#ifdef DLL_EXPORT
#define GEO_DLL __declspec( dllexport )
# else
#define GEO_DLL
#endif


GEO_DLL int add_lib(int a,int b);
GEO_DLL void print_lib1();

