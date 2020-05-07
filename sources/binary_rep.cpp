 
#include <binary_rep.hpp>

std::string toBinaryRepresentation(unsigned x)
{
    std::string s;
    do
    {
        s.push_back('0' + (x & 1));
    } while (x >>= 1);
    std::reverse(s.begin(), s.end());
    return s;
}