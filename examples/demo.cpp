#include <binary_rep.hpp>
#include <iostream>

int main(int argc, char* argv[])
{
    unsigned number;
    std::cin >> number;
    std::cout << toBinaryRepresentation(number);
}