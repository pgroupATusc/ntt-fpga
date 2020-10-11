#include "node.h"


NODE::NODE(void)
{
  value = 0;
  upper = 0;
  lower = 0;
  side = 0;
  idx_location = 0;
}

void NODE::setvalue(int val)
{
   value = val;
   return;
}


int NODE::readvalue(void)
{
  return value;
}


NODE::NODE(const NODE &cp)
{
  value = cp.value;
  upper = cp.upper;
  lower = cp.lower;
  side = cp.side;
  idx_location = cp.idx_location;
}