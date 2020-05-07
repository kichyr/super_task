#include <binary_rep.hpp>

#include <gtest/gtest.h>

TEST(Print, InFileStream)
{
  unsigned number = 5;
  std::string expect_binary_rep = "101";
  auto binary = toBinaryRepresentation(number);

  EXPECT_EQ(binary, expect_binary_rep);
}