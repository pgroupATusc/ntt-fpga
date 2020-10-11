#include "map.h"


NODEMAP::NODEMAP(void)
{
  //data_parallelsim = 0;
  decomp_stage = 0;	
  map_size = 0;
  idx_file = 0;
}

NODEMAP::NODEMAP(const NODEMAP &cp)
{
  //data_parallelsim = 0;
  switch_ctrl = cp.switch_ctrl;	
  addr_up = cp.addr_up;	
  addr_down = cp.addr_down;	
  decomp_stage = cp.decomp_stage;	
  map_size = cp.map_size;
  idx_file = cp.idx_file;
}

NODEMAP::~NODEMAP()
{
}

SPNCTRL::SPNCTRL(void)
{
	
}


BENES::BENES(void)
{

}


CLOS::CLOS(void)
{
  s1 = 0;
  s2 = 0;
}

