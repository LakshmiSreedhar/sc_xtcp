// Copyright (c) 2011, XMOS Ltd, All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

#include <platform.h>
#include "pipServer.h"

#define PORT_ETH_FAKE    XS1_PORT_8C

#define PORT_ETH_RST_N_MDIO  XS1_PORT_1P

on stdcore[1]: mii_interface_t mii =
  {
    XS1_CLKBLK_1,
    XS1_CLKBLK_2,

    PORT_ETH_RXCLK,
    PORT_ETH_RXER,
    PORT_ETH_RXD,
    PORT_ETH_RXDV,

    PORT_ETH_TXCLK,
    PORT_ETH_TXEN,
    PORT_ETH_TXD,

    PORT_ETH_FAKE,
  };

#ifdef PORT_ETH_RST_N
on stdcore[1]: out port p_mii_resetn = PORT_ETH_RST_N;
on stdcore[1]: smi_interface_t smi = { PORT_ETH_MDIO, PORT_ETH_MDC, 0 };
#else
on stdcore[1]: smi_interface_t smi = { PORT_ETH_RST_N_MDIO, PORT_ETH_MDC, 1 };
#endif

on stdcore[1]: clock clk_smi = XS1_CLKBLK_5;


main() {
    par {
        on stdcore[1]: pipServer();
    }
}
