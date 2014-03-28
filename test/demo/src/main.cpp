
#include "fun.h"
#include "geodemo.h"
int main()
{
  fun_print();
  std::cout<< "main"<<std::endl;
  int s = add_lib(10,3);
  std::cout<< "add:"<< s<<std::endl;
  print_lib1();
}