Date: Sun, 16 Nov 2014 10:47:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141116094734.GQ4656@sisyphus.hd.free.fr>
References: <20141116062956.GO4656@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141116062956.GO4656@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] Pull requests.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Sun, Nov 16, 2014 at 07:29:56AM +0100, Gilles Chanteperdrix wrote:
> Hi Philippe,
> 
> please pull from ipipe-gch.git the branches:
> for-ipipe-3.10
> for-ipipe-3.14.17
> for-raw-ipipe-3.16
> 
> The latest commits necessary to run RTnet over xenomai-forge.
> 
> And from xenomai-gch.git branch for-forge
> 
> The commits related to the integration of RTnet.

The corresponding commit lists:

for-ipipe-3.10:
      arm/ipipe: rework AT91 timer support
      ipipe: use chip irq_startup when needed

 arch/arm/Kconfig                           |    1 +
 arch/arm/mach-at91/Kconfig                 |    1 +
 arch/arm/mach-at91/at91_ipipe.c            |  206 +++++++++++++------------------
 arch/arm/mach-at91/at91_ipipe.h            |    4 +-
 arch/arm/mach-at91/at91rm9200.c            |   14 ---
 arch/arm/mach-at91/at91rm9200_time.c       |    2 +-
 arch/arm/mach-at91/at91sam9260.c           |   15 ---
 arch/arm/mach-at91/at91sam9261.c           |   14 ---
 arch/arm/mach-at91/at91sam9263.c           |   14 ---
 arch/arm/mach-at91/at91sam926x_time.c      |    2 +-
 arch/arm/mach-at91/at91sam9g45.c           |   14 ---
 arch/arm/mach-at91/at91sam9rl.c            |   14 ---
 arch/arm/mach-at91/include/mach/hardware.h |   21 ----
 include/linux/ipipe.h                      |   20 +--
 kernel/irq/chip.c                          |   50 +++++++-
 kernel/irq/internals.h                     |    3 +
 kernel/irq/irqdesc.c                       |    3 +
 17 files changed, 143 insertions(+), 255 deletions(-)

for-ipipe-3.14.17:
      cortexa9/ipipe: use arm_global_timer
      modules/ipipe: allow calling try_module_get/module_put from real-time context
      ipipe: use chip irq_startup when needed

 arch/arm/boot/dts/imx6qdl.dtsi         |    6 +++
 arch/arm/boot/dts/omap4.dtsi           |    6 +++
 arch/arm/kernel/smp_twd.c              |   54 +------------------------
 arch/arm/mach-imx/Kconfig              |    1 +
 arch/arm/mach-omap2/Kconfig            |    1 +
 drivers/clocksource/arm_global_timer.c |   76 +++++++++++++++++++++++------------
 include/linux/ipipe.h                  |   20 +--------
 kernel/irq/chip.c                      |   50 +++++++++++++++++++++--
 kernel/irq/internals.h                 |    3 ++
 kernel/irq/irqdesc.c                   |    3 ++
 kernel/module.c                        |   20 ++++-----
 11 files changed, 129 insertions(+), 111 deletions(-)

for-raw-ipipe-3.16:
      arm/ipipe: disable stack unwinding in perf interrupt
      modules: allow calling try_module_get/module_put from real-time context
      cortexa9: use arm_global_timer
      arm/ipipe: at91 fixup
      ipipe: use chip irq_startup when needed

 arch/arm/boot/dts/imx6qdl.dtsi         |    6 +
 arch/arm/boot/dts/omap4.dtsi           |    6 +
 arch/arm/kernel/perf_event.c           |  765 +++++++++++------------
 arch/arm/kernel/smp_twd.c              |   54 +-
 arch/arm/mach-at91/at91_ipipe.c        |    1 +
 arch/arm/mach-imx/Kconfig              | 1163 ++++++++++++++++++-----------------
 arch/arm/mach-omap2/Kconfig            |    1 +
 drivers/clocksource/arm_global_timer.c |   76 ++-
 include/linux/ipipe.h                  |   20 +-
 kernel/irq/chip.c                      |   50 +-
 kernel/irq/internals.h                 |    3 +
 kernel/irq/irqdesc.c                   |    3 +
 kernel/module.c                        |   20 +-
 13 files changed, 1095 insertions(+), 1073 deletions(-)


for-forge:
      cobalt/arm: fixup for kernel 3.16
      cobalt/intr: fix first enable
      cobalt/autotune: add options to ease autotuning at boot
      cobalt/rtdm: rebase rtdm_nrtsig on ipipe_post_work_root
      cobalt/rtdm: add rtdm_schedule_nrt_work service
      rtnet: import
      rtnet: Adapt to RTDM API changes
      rtpacket_type: use callbacks for locking
      rtnet: rtskb_pool changes
      rtnet: EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL
      rtnet: rtskb_pool changes (2)
      rtnet: remove now useless macros
      rtnet: convert /proc output to vfile
      rtnet: sanitize CONFIG_ symbols
      rtnet: reduce the compat cruft
      rtnet: Kconfig fixes
      rtnet: compile and install tools
      rtnet/arp: do not answer ARP requests only when rtnetproxy is loaded
      rtnet: update r8169 driver
      rtnet: update 8139too driver
      rtnet: add more netdev compatibility functions
      rtnet: update macb driver
      rtnet: update at91_ether driver

 configure.ac                                         |    9 +-
 doc/rtnet/README.drvporting                          |  251 +
 doc/rtnet/README.eth1394                             |   65 +
 doc/rtnet/README.ipfragmentation                     |   49 +
 doc/rtnet/README.pools                               |  117 +
 doc/rtnet/README.routing                             |  117 +
 doc/rtnet/README.rtcap                               |   39 +
 doc/rtnet/README.rtcfg                               |  135 +
 doc/rtnet/README.rtmac                               |  341 +
 doc/rtnet/README.rtnetproxy                          |   74 +
 doc/rtnet/README.tcp                                 |   52 +
 doc/rtnet/RTcfg.spec                                 |  469 ++
 doc/rtnet/RTmac.spec                                 |   44 +
 doc/rtnet/RTnet.oxy                                  | 1150 +++
 doc/rtnet/TDMA.spec                                  |  597 ++
 include/cobalt/kernel/rtdm/driver.h                  |   44 +-
 kernel/cobalt/arch/arm/include/asm/xenomai/machine.h |    7 +-
 kernel/cobalt/intr.c                                 |    2 +-
 kernel/cobalt/rtdm/drvlib.c                          |   70 +-
 kernel/cobalt/udev/00-rtnet.rules                    |    5 +
 kernel/drivers/Kconfig                               |    3 +-
 kernel/drivers/Makefile                              |    3 +-
 kernel/drivers/analogy/rtdm_helpers.c                |    4 +-
 kernel/drivers/autotune/autotune.c                   |    7 +-
 kernel/drivers/net/Kconfig                           |   11 +
 kernel/drivers/net/Makefile                          |    1 +
 kernel/drivers/net/addons/Kconfig                    |   44 +
 kernel/drivers/net/addons/Makefile                   |   10 +
 kernel/drivers/net/addons/cap.c                      |  516 ++
 kernel/drivers/net/addons/proxy.c                    |  442 +
 kernel/drivers/net/drivers/8139too.c                 | 1726 ++++
 kernel/drivers/net/drivers/Kconfig                   |  136 +
 kernel/drivers/net/drivers/Makefile                  |   70 +
 kernel/drivers/net/drivers/README.r8169              |   42 +
 kernel/drivers/net/drivers/at91_ether.c              |  452 +
 kernel/drivers/net/drivers/e1000/Makefile            |    9 +
 kernel/drivers/net/drivers/e1000/e1000.h             |  390 +
 kernel/drivers/net/drivers/e1000/e1000_hw.c          | 9092 +++++++++++++++++++++
 kernel/drivers/net/drivers/e1000/e1000_hw.h          | 3454 ++++++++
 kernel/drivers/net/drivers/e1000/e1000_main.c        | 3168 +++++++
 kernel/drivers/net/drivers/e1000/e1000_osdep.h       |  148 +
 kernel/drivers/net/drivers/e1000/e1000_param.c       |  906 ++
 kernel/drivers/net/drivers/e1000/kcompat.h           |  446 +
 kernel/drivers/net/drivers/e1000e/80003es2lan.c      | 1515 ++++
 kernel/drivers/net/drivers/e1000e/82571.c            | 2112 +++++
 kernel/drivers/net/drivers/e1000e/Makefile           |   13 +
 kernel/drivers/net/drivers/e1000e/defines.h          |  844 ++
 kernel/drivers/net/drivers/e1000e/e1000.h            |  752 ++
 kernel/drivers/net/drivers/e1000e/hw.h               |  984 +++
 kernel/drivers/net/drivers/e1000e/ich8lan.c          | 4157 ++++++++++
 kernel/drivers/net/drivers/e1000e/lib.c              | 2693 ++++++
 kernel/drivers/net/drivers/e1000e/netdev.c           | 4392 ++++++++++
 kernel/drivers/net/drivers/e1000e/param.c            |  484 ++
 kernel/drivers/net/drivers/e1000e/phy.c              | 3377 ++++++++
 kernel/drivers/net/drivers/eepro100.c                | 1843 +++++
 kernel/drivers/net/drivers/eth1394.c                 | 1535 ++++
 kernel/drivers/net/drivers/experimental/3c59x.c      | 2749 +++++++
 kernel/drivers/net/drivers/experimental/Kconfig      |   17 +
 kernel/drivers/net/drivers/experimental/Makefile     |   10 +
 .../drivers/net/drivers/experimental/e1000/Makefile  |   20 +
 .../drivers/net/drivers/experimental/e1000/e1000.h   |  426 +
 .../drivers/experimental/e1000/e1000_80003es2lan.c   | 1401 ++++
 .../drivers/experimental/e1000/e1000_80003es2lan.h   |   95 +
 .../net/drivers/experimental/e1000/e1000_82540.c     |  680 ++
 .../net/drivers/experimental/e1000/e1000_82541.c     | 1328 +++
 .../net/drivers/experimental/e1000/e1000_82541.h     |   84 +
 .../net/drivers/experimental/e1000/e1000_82542.c     |  543 ++
 .../net/drivers/experimental/e1000/e1000_82543.c     | 1654 ++++
 .../net/drivers/experimental/e1000/e1000_82543.h     |   44 +
 .../net/drivers/experimental/e1000/e1000_82571.c     | 1430 ++++
 .../net/drivers/experimental/e1000/e1000_82571.h     |   40 +
 .../net/drivers/experimental/e1000/e1000_api.c       | 1164 +++
 .../net/drivers/experimental/e1000/e1000_api.h       |  166 +
 .../net/drivers/experimental/e1000/e1000_defines.h   | 1397 ++++
 .../net/drivers/experimental/e1000/e1000_ethtool.c   | 2205 +++++
 .../net/drivers/experimental/e1000/e1000_hw.h        |  711 ++
 .../net/drivers/experimental/e1000/e1000_ich8lan.c   | 2582 ++++++
 .../net/drivers/experimental/e1000/e1000_ich8lan.h   |  110 +
 .../net/drivers/experimental/e1000/e1000_mac.c       | 2039 +++++
 .../net/drivers/experimental/e1000/e1000_mac.h       |   86 +
 .../net/drivers/experimental/e1000/e1000_main.c      | 5990 ++++++++++++++
 .../net/drivers/experimental/e1000/e1000_manage.c    |  384 +
 .../net/drivers/experimental/e1000/e1000_manage.h    |   81 +
 .../net/drivers/experimental/e1000/e1000_nvm.c       |  893 ++
 .../net/drivers/experimental/e1000/e1000_nvm.h       |   61 +
 .../net/drivers/experimental/e1000/e1000_osdep.h     |  124 +
 .../net/drivers/experimental/e1000/e1000_param.c     |  894 ++
 .../net/drivers/experimental/e1000/e1000_phy.c       | 2106 +++++
 .../net/drivers/experimental/e1000/e1000_phy.h       |  168 +
 .../net/drivers/experimental/e1000/e1000_regs.h      |  307 +
 .../drivers/net/drivers/experimental/e1000/kcompat.h |  609 ++
 .../drivers/net/drivers/experimental/rt2500/Kconfig  |    4 +
 .../drivers/net/drivers/experimental/rt2500/Makefile |    7 +
 .../drivers/net/drivers/experimental/rt2500/README   |   58 +
 .../net/drivers/experimental/rt2500/rt2500pci.c      | 1250 +++
 .../net/drivers/experimental/rt2500/rt2500pci.h      | 1332 +++
 .../drivers/net/drivers/experimental/rt2500/rt2x00.h |  630 ++
 .../net/drivers/experimental/rt2500/rt2x00core.c     |  439 +
 kernel/drivers/net/drivers/fec.c                     | 1856 +++++
 kernel/drivers/net/drivers/igb/Makefile              |   11 +
 kernel/drivers/net/drivers/igb/e1000_82575.c         | 1462 ++++
 kernel/drivers/net/drivers/igb/e1000_82575.h         |  174 +
 kernel/drivers/net/drivers/igb/e1000_defines.h       |  767 ++
 kernel/drivers/net/drivers/igb/e1000_hw.h            |  602 ++
 kernel/drivers/net/drivers/igb/e1000_mac.c           | 1409 ++++
 kernel/drivers/net/drivers/igb/e1000_mac.h           |   97 +
 kernel/drivers/net/drivers/igb/e1000_nvm.c           |  606 ++
 kernel/drivers/net/drivers/igb/e1000_nvm.h           |   41 +
 kernel/drivers/net/drivers/igb/e1000_phy.c           | 1806 ++++
 kernel/drivers/net/drivers/igb/e1000_phy.h           |  101 +
 kernel/drivers/net/drivers/igb/e1000_regs.h          |  279 +
 kernel/drivers/net/drivers/igb/igb.h                 |  377 +
 kernel/drivers/net/drivers/igb/igb_ethtool.c         | 2033 +++++
 kernel/drivers/net/drivers/igb/igb_main.c            | 4174 ++++++++++
 kernel/drivers/net/drivers/loopback.c                |  141 +
 kernel/drivers/net/drivers/macb.c                    | 1804 ++++
 kernel/drivers/net/drivers/mpc52xx_fec/Makefile      |    6 +
 kernel/drivers/net/drivers/mpc52xx_fec/README        |   67 +
 .../drivers/mpc52xx_fec/linuxppc_2_4_devel-fec.patch |   61 +
 kernel/drivers/net/drivers/mpc52xx_fec/mpc52xx_fec.c | 1985 +++++
 .../drivers/net/drivers/mpc52xx_fec/rt_mpc52xx_fec.h |  428 +
 kernel/drivers/net/drivers/mpc8260_fcc_enet.c        | 2235 +++++
 kernel/drivers/net/drivers/mpc8xx_enet.c             | 1073 +++
 kernel/drivers/net/drivers/mpc8xx_fec.c              | 2341 ++++++
 kernel/drivers/net/drivers/natsemi.c                 | 2092 +++++
 kernel/drivers/net/drivers/pcnet32.c                 | 1531 ++++
 kernel/drivers/net/drivers/r8169.c                   | 2044 +++++
 kernel/drivers/net/drivers/rt_at91_ether.h           |  109 +
 kernel/drivers/net/drivers/rt_eth1394.h              |  240 +
 kernel/drivers/net/drivers/rt_fec.h                  |  153 +
 kernel/drivers/net/drivers/rt_macb.h                 |  622 ++
 kernel/drivers/net/drivers/rt_smc91111.h             |  566 ++
 kernel/drivers/net/drivers/smc91111.c                | 3531 ++++++++
 kernel/drivers/net/drivers/tulip/21142.c             |   51 +
 kernel/drivers/net/drivers/tulip/Makefile            |   13 +
 kernel/drivers/net/drivers/tulip/eeprom.c            |  321 +
 kernel/drivers/net/drivers/tulip/interrupt.c         |  391 +
 kernel/drivers/net/drivers/tulip/media.c             |  567 ++
 kernel/drivers/net/drivers/tulip/pnic.c              |   53 +
 kernel/drivers/net/drivers/tulip/pnic2.c             |  158 +
 kernel/drivers/net/drivers/tulip/tulip.h             |  490 ++
 kernel/drivers/net/drivers/tulip/tulip_core.c        | 1401 ++++
 kernel/drivers/net/drivers/via-rhine.c               | 1816 ++++
 kernel/drivers/net/stack/Kconfig                     |   41 +
 kernel/drivers/net/stack/Makefile                    |   26 +
 kernel/drivers/net/stack/eth.c                       |  141 +
 kernel/drivers/net/stack/include/INCLUDE.policy      |   15 +
 kernel/drivers/net/stack/include/ethernet/eth.h      |   32 +
 kernel/drivers/net/stack/include/ipv4/af_inet.h      |   36 +
 kernel/drivers/net/stack/include/ipv4/arp.h          |   54 +
 kernel/drivers/net/stack/include/ipv4/icmp.h         |   56 +
 kernel/drivers/net/stack/include/ipv4/ip_fragment.h  |   39 +
 kernel/drivers/net/stack/include/ipv4/ip_input.h     |   47 +
 kernel/drivers/net/stack/include/ipv4/ip_output.h    |   42 +
 kernel/drivers/net/stack/include/ipv4/ip_sock.h      |   32 +
 kernel/drivers/net/stack/include/ipv4/protocol.h     |   56 +
 kernel/drivers/net/stack/include/ipv4/route.h        |   62 +
 kernel/drivers/net/stack/include/ipv4/tcp.h          |   50 +
 kernel/drivers/net/stack/include/ipv4/udp.h          |   33 +
 kernel/drivers/net/stack/include/ipv4_chrdev.h       |  104 +
 kernel/drivers/net/stack/include/nomac_chrdev.h      |   41 +
 kernel/drivers/net/stack/include/rtcfg/rtcfg.h       |   49 +
 .../net/stack/include/rtcfg/rtcfg_client_event.h     |   46 +
 .../net/stack/include/rtcfg/rtcfg_conn_event.h       |   71 +
 kernel/drivers/net/stack/include/rtcfg/rtcfg_event.h |  120 +
 kernel/drivers/net/stack/include/rtcfg/rtcfg_file.h  |   45 +
 kernel/drivers/net/stack/include/rtcfg/rtcfg_frame.h |  139 +
 kernel/drivers/net/stack/include/rtcfg/rtcfg_ioctl.h |   34 +
 kernel/drivers/net/stack/include/rtcfg/rtcfg_proc.h  |   61 +
 kernel/drivers/net/stack/include/rtcfg/rtcfg_timer.h |   31 +
 kernel/drivers/net/stack/include/rtcfg_chrdev.h      |  179 +
 kernel/drivers/net/stack/include/rtdev.h             |  266 +
 kernel/drivers/net/stack/include/rtdev_mgr.h         |   41 +
 kernel/drivers/net/stack/include/rtmac.h             |   98 +
 kernel/drivers/net/stack/include/rtmac/nomac/nomac.h |   54 +
 .../net/stack/include/rtmac/nomac/nomac_dev.h        |   39 +
 .../net/stack/include/rtmac/nomac/nomac_ioctl.h      |   32 +
 .../net/stack/include/rtmac/nomac/nomac_proto.h      |   39 +
 kernel/drivers/net/stack/include/rtmac/rtmac_disc.h  |   99 +
 kernel/drivers/net/stack/include/rtmac/rtmac_proc.h  |   36 +
 kernel/drivers/net/stack/include/rtmac/rtmac_proto.h |   87 +
 kernel/drivers/net/stack/include/rtmac/rtmac_vnic.h  |   61 +
 kernel/drivers/net/stack/include/rtmac/tdma/tdma.h   |  169 +
 .../drivers/net/stack/include/rtmac/tdma/tdma_dev.h  |   39 +
 .../net/stack/include/rtmac/tdma/tdma_ioctl.h        |   36 +
 .../net/stack/include/rtmac/tdma/tdma_proto.h        |   87 +
 .../net/stack/include/rtmac/tdma/tdma_worker.h       |   35 +
 kernel/drivers/net/stack/include/rtnet.h             |  121 +
 kernel/drivers/net/stack/include/rtnet_chrdev.h      |  123 +
 kernel/drivers/net/stack/include/rtnet_internal.h    |   81 +
 kernel/drivers/net/stack/include/rtnet_iovec.h       |   50 +
 kernel/drivers/net/stack/include/rtnet_port.h        |  116 +
 kernel/drivers/net/stack/include/rtnet_rtpc.h        |   77 +
 kernel/drivers/net/stack/include/rtnet_socket.h      |  111 +
 kernel/drivers/net/stack/include/rtskb.h             |  799 ++
 kernel/drivers/net/stack/include/rtskb_fifo.h        |  147 +
 kernel/drivers/net/stack/include/rtwlan.h            |  256 +
 kernel/drivers/net/stack/include/rtwlan_io.h         |  120 +
 kernel/drivers/net/stack/include/stack_mgr.h         |   94 +
 kernel/drivers/net/stack/include/tdma_chrdev.h       |   88 +
 kernel/drivers/net/stack/iovec.c                     |   77 +
 kernel/drivers/net/stack/ipv4/Kconfig                |   66 +
 kernel/drivers/net/stack/ipv4/Makefile               |   20 +
 kernel/drivers/net/stack/ipv4/af_inet.c              |  366 +
 kernel/drivers/net/stack/ipv4/arp.c                  |  224 +
 kernel/drivers/net/stack/ipv4/icmp.c                 |  552 ++
 kernel/drivers/net/stack/ipv4/ip_fragment.c          |  343 +
 kernel/drivers/net/stack/ipv4/ip_input.c             |  161 +
 kernel/drivers/net/stack/ipv4/ip_output.c            |  284 +
 kernel/drivers/net/stack/ipv4/ip_sock.c              |  154 +
 kernel/drivers/net/stack/ipv4/protocol.c             |   95 +
 kernel/drivers/net/stack/ipv4/route.c                | 1059 +++
 kernel/drivers/net/stack/ipv4/tcp/Kconfig            |   18 +
 kernel/drivers/net/stack/ipv4/tcp/Makefile           |    8 +
 kernel/drivers/net/stack/ipv4/tcp/tcp.c              | 2326 ++++++
 kernel/drivers/net/stack/ipv4/tcp/timerwheel.c       |  217 +
 kernel/drivers/net/stack/ipv4/tcp/timerwheel.h       |   63 +
 kernel/drivers/net/stack/ipv4/udp/Kconfig            |    6 +
 kernel/drivers/net/stack/ipv4/udp/Makefile           |    6 +
 kernel/drivers/net/stack/ipv4/udp/udp.c              |  763 ++
 kernel/drivers/net/stack/packet/Kconfig              |   14 +
 kernel/drivers/net/stack/packet/Makefile             |    6 +
 kernel/drivers/net/stack/packet/af_packet.c          |  602 ++
 kernel/drivers/net/stack/rtcfg/Kconfig               |   23 +
 kernel/drivers/net/stack/rtcfg/Makefile              |   15 +
 kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c  | 1175 +++
 kernel/drivers/net/stack/rtcfg/rtcfg_conn_event.c    |  396 +
 kernel/drivers/net/stack/rtcfg/rtcfg_event.c         |  779 ++
 kernel/drivers/net/stack/rtcfg/rtcfg_file.c          |   86 +
 kernel/drivers/net/stack/rtcfg/rtcfg_frame.c         |  589 ++
 kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c         |  456 ++
 kernel/drivers/net/stack/rtcfg/rtcfg_module.c        |   89 +
 kernel/drivers/net/stack/rtcfg/rtcfg_proc.c          |  350 +
 kernel/drivers/net/stack/rtcfg/rtcfg_timer.c         |   88 +
 kernel/drivers/net/stack/rtdev.c                     |  788 ++
 kernel/drivers/net/stack/rtdev_mgr.c                 |  128 +
 kernel/drivers/net/stack/rtmac/Kconfig               |   16 +
 kernel/drivers/net/stack/rtmac/Makefile              |   16 +
 kernel/drivers/net/stack/rtmac/nomac/Kconfig         |    9 +
 kernel/drivers/net/stack/rtmac/nomac/Makefile        |   10 +
 kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c     |   87 +
 kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c   |  107 +
 kernel/drivers/net/stack/rtmac/nomac/nomac_module.c  |  178 +
 kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c   |  139 +
 kernel/drivers/net/stack/rtmac/rtmac_disc.c          |  286 +
 kernel/drivers/net/stack/rtmac/rtmac_module.c        |   86 +
 kernel/drivers/net/stack/rtmac/rtmac_proc.c          |  137 +
 kernel/drivers/net/stack/rtmac/rtmac_proto.c         |   81 +
 kernel/drivers/net/stack/rtmac/rtmac_syms.c          |   37 +
 kernel/drivers/net/stack/rtmac/rtmac_vnic.c          |  377 +
 kernel/drivers/net/stack/rtmac/tdma/Kconfig          |   21 +
 kernel/drivers/net/stack/rtmac/tdma/Makefile         |   11 +
 kernel/drivers/net/stack/rtmac/tdma/tdma_dev.c       |  192 +
 kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c     |  683 ++
 kernel/drivers/net/stack/rtmac/tdma/tdma_module.c    |  329 +
 kernel/drivers/net/stack/rtmac/tdma/tdma_proto.c     |  412 +
 kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c    |  225 +
 kernel/drivers/net/stack/rtnet_chrdev.c              |  337 +
 kernel/drivers/net/stack/rtnet_module.c              |  399 +
 kernel/drivers/net/stack/rtnet_rtpc.c                |  282 +
 kernel/drivers/net/stack/rtskb.c                     |  556 ++
 kernel/drivers/net/stack/rtwlan.c                    |  212 +
 kernel/drivers/net/stack/socket.c                    |  333 +
 kernel/drivers/net/stack/stack_mgr.c                 |  271 +
 kernel/drivers/testing/switchtest.c                  |    7 +-
 utils/Makefile.am                                    |    2 +-
 utils/autotune/autotune.c                            |   25 +-
 utils/net/Makefile.am                                |   16 +
 utils/net/nomaccfg.c                                 |  109 +
 utils/net/rtcfg.c                                    |  562 ++
 utils/net/rtifconfig.c                               |  440 +
 utils/net/rtiwconfig.c                               |  236 +
 utils/net/rtnet.conf.in                              |   79 +
 utils/net/rtnet.in                                   |  371 +
 utils/net/rtping.c                                   |  183 +
 utils/net/rtroute.c                                  |  393 +
 utils/net/tdma.conf                                  |   39 +
 utils/net/tdmacfg.c                                  |  332 +
 278 files changed, 153869 insertions(+), 50 deletions(-)
 create mode 100644 doc/rtnet/README.drvporting
 create mode 100644 doc/rtnet/README.eth1394
 create mode 100644 doc/rtnet/README.ipfragmentation
 create mode 100644 doc/rtnet/README.pools
 create mode 100644 doc/rtnet/README.routing
 create mode 100644 doc/rtnet/README.rtcap
 create mode 100644 doc/rtnet/README.rtcfg
 create mode 100644 doc/rtnet/README.rtmac
 create mode 100644 doc/rtnet/README.rtnetproxy
 create mode 100644 doc/rtnet/README.tcp
 create mode 100644 doc/rtnet/RTcfg.spec
 create mode 100644 doc/rtnet/RTmac.spec
 create mode 100644 doc/rtnet/RTnet.oxy
 create mode 100644 doc/rtnet/TDMA.spec
 create mode 100644 kernel/cobalt/udev/00-rtnet.rules
 create mode 100644 kernel/drivers/net/Kconfig
 create mode 100644 kernel/drivers/net/Makefile
 create mode 100644 kernel/drivers/net/addons/Kconfig
 create mode 100644 kernel/drivers/net/addons/Makefile
 create mode 100644 kernel/drivers/net/addons/cap.c
 create mode 100644 kernel/drivers/net/addons/proxy.c
 create mode 100644 kernel/drivers/net/drivers/8139too.c
 create mode 100644 kernel/drivers/net/drivers/Kconfig
 create mode 100644 kernel/drivers/net/drivers/Makefile
 create mode 100644 kernel/drivers/net/drivers/README.r8169
 create mode 100644 kernel/drivers/net/drivers/at91_ether.c
 create mode 100644 kernel/drivers/net/drivers/e1000/Makefile
 create mode 100644 kernel/drivers/net/drivers/e1000/e1000.h
 create mode 100644 kernel/drivers/net/drivers/e1000/e1000_hw.c
 create mode 100644 kernel/drivers/net/drivers/e1000/e1000_hw.h
 create mode 100644 kernel/drivers/net/drivers/e1000/e1000_main.c
 create mode 100644 kernel/drivers/net/drivers/e1000/e1000_osdep.h
 create mode 100644 kernel/drivers/net/drivers/e1000/e1000_param.c
 create mode 100644 kernel/drivers/net/drivers/e1000/kcompat.h
 create mode 100644 kernel/drivers/net/drivers/e1000e/80003es2lan.c
 create mode 100644 kernel/drivers/net/drivers/e1000e/82571.c
 create mode 100644 kernel/drivers/net/drivers/e1000e/Makefile
 create mode 100644 kernel/drivers/net/drivers/e1000e/defines.h
 create mode 100644 kernel/drivers/net/drivers/e1000e/e1000.h
 create mode 100644 kernel/drivers/net/drivers/e1000e/hw.h
 create mode 100644 kernel/drivers/net/drivers/e1000e/ich8lan.c
 create mode 100644 kernel/drivers/net/drivers/e1000e/lib.c
 create mode 100644 kernel/drivers/net/drivers/e1000e/netdev.c
 create mode 100644 kernel/drivers/net/drivers/e1000e/param.c
 create mode 100644 kernel/drivers/net/drivers/e1000e/phy.c
 create mode 100644 kernel/drivers/net/drivers/eepro100.c
 create mode 100644 kernel/drivers/net/drivers/eth1394.c
 create mode 100644 kernel/drivers/net/drivers/experimental/3c59x.c
 create mode 100644 kernel/drivers/net/drivers/experimental/Kconfig
 create mode 100644 kernel/drivers/net/drivers/experimental/Makefile
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/Makefile
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_80003es2lan.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_80003es2lan.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_82540.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_82541.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_82541.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_82542.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_82543.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_82543.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_82571.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_82571.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_api.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_api.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_defines.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_hw.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_ich8lan.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_ich8lan.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_mac.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_mac.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_manage.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_manage.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_nvm.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_nvm.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_osdep.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_param.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_phy.c
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_phy.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/e1000_regs.h
 create mode 100644 kernel/drivers/net/drivers/experimental/e1000/kcompat.h
 create mode 100644 kernel/drivers/net/drivers/experimental/rt2500/Kconfig
 create mode 100644 kernel/drivers/net/drivers/experimental/rt2500/Makefile
 create mode 100644 kernel/drivers/net/drivers/experimental/rt2500/README
 create mode 100644 kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c
 create mode 100644 kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.h
 create mode 100644 kernel/drivers/net/drivers/experimental/rt2500/rt2x00.h
 create mode 100644 kernel/drivers/net/drivers/experimental/rt2500/rt2x00core.c
 create mode 100644 kernel/drivers/net/drivers/fec.c
 create mode 100644 kernel/drivers/net/drivers/igb/Makefile
 create mode 100644 kernel/drivers/net/drivers/igb/e1000_82575.c
 create mode 100644 kernel/drivers/net/drivers/igb/e1000_82575.h
 create mode 100644 kernel/drivers/net/drivers/igb/e1000_defines.h
 create mode 100644 kernel/drivers/net/drivers/igb/e1000_hw.h
 create mode 100644 kernel/drivers/net/drivers/igb/e1000_mac.c
 create mode 100644 kernel/drivers/net/drivers/igb/e1000_mac.h
 create mode 100644 kernel/drivers/net/drivers/igb/e1000_nvm.c
 create mode 100644 kernel/drivers/net/drivers/igb/e1000_nvm.h
 create mode 100644 kernel/drivers/net/drivers/igb/e1000_phy.c
 create mode 100644 kernel/drivers/net/drivers/igb/e1000_phy.h
 create mode 100644 kernel/drivers/net/drivers/igb/e1000_regs.h
 create mode 100644 kernel/drivers/net/drivers/igb/igb.h
 create mode 100644 kernel/drivers/net/drivers/igb/igb_ethtool.c
 create mode 100644 kernel/drivers/net/drivers/igb/igb_main.c
 create mode 100644 kernel/drivers/net/drivers/loopback.c
 create mode 100644 kernel/drivers/net/drivers/macb.c
 create mode 100644 kernel/drivers/net/drivers/mpc52xx_fec/Makefile
 create mode 100644 kernel/drivers/net/drivers/mpc52xx_fec/README
 create mode 100644 kernel/drivers/net/drivers/mpc52xx_fec/linuxppc_2_4_devel-fec.patch
 create mode 100644 kernel/drivers/net/drivers/mpc52xx_fec/mpc52xx_fec.c
 create mode 100644 kernel/drivers/net/drivers/mpc52xx_fec/rt_mpc52xx_fec.h
 create mode 100644 kernel/drivers/net/drivers/mpc8260_fcc_enet.c
 create mode 100644 kernel/drivers/net/drivers/mpc8xx_enet.c
 create mode 100644 kernel/drivers/net/drivers/mpc8xx_fec.c
 create mode 100644 kernel/drivers/net/drivers/natsemi.c
 create mode 100644 kernel/drivers/net/drivers/pcnet32.c
 create mode 100644 kernel/drivers/net/drivers/r8169.c
 create mode 100644 kernel/drivers/net/drivers/rt_at91_ether.h
 create mode 100644 kernel/drivers/net/drivers/rt_eth1394.h
 create mode 100644 kernel/drivers/net/drivers/rt_fec.h
 create mode 100644 kernel/drivers/net/drivers/rt_macb.h
 create mode 100644 kernel/drivers/net/drivers/rt_smc91111.h
 create mode 100644 kernel/drivers/net/drivers/smc91111.c
 create mode 100644 kernel/drivers/net/drivers/tulip/21142.c
 create mode 100644 kernel/drivers/net/drivers/tulip/Makefile
 create mode 100644 kernel/drivers/net/drivers/tulip/eeprom.c
 create mode 100644 kernel/drivers/net/drivers/tulip/interrupt.c
 create mode 100644 kernel/drivers/net/drivers/tulip/media.c
 create mode 100644 kernel/drivers/net/drivers/tulip/pnic.c
 create mode 100644 kernel/drivers/net/drivers/tulip/pnic2.c
 create mode 100644 kernel/drivers/net/drivers/tulip/tulip.h
 create mode 100644 kernel/drivers/net/drivers/tulip/tulip_core.c
 create mode 100644 kernel/drivers/net/drivers/via-rhine.c
 create mode 100644 kernel/drivers/net/stack/Kconfig
 create mode 100644 kernel/drivers/net/stack/Makefile
 create mode 100644 kernel/drivers/net/stack/eth.c
 create mode 100644 kernel/drivers/net/stack/include/INCLUDE.policy
 create mode 100644 kernel/drivers/net/stack/include/ethernet/eth.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4/af_inet.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4/arp.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4/icmp.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4/ip_fragment.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4/ip_input.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4/ip_output.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4/ip_sock.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4/protocol.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4/route.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4/tcp.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4/udp.h
 create mode 100644 kernel/drivers/net/stack/include/ipv4_chrdev.h
 create mode 100644 kernel/drivers/net/stack/include/nomac_chrdev.h
 create mode 100644 kernel/drivers/net/stack/include/rtcfg/rtcfg.h
 create mode 100644 kernel/drivers/net/stack/include/rtcfg/rtcfg_client_event.h
 create mode 100644 kernel/drivers/net/stack/include/rtcfg/rtcfg_conn_event.h
 create mode 100644 kernel/drivers/net/stack/include/rtcfg/rtcfg_event.h
 create mode 100644 kernel/drivers/net/stack/include/rtcfg/rtcfg_file.h
 create mode 100644 kernel/drivers/net/stack/include/rtcfg/rtcfg_frame.h
 create mode 100644 kernel/drivers/net/stack/include/rtcfg/rtcfg_ioctl.h
 create mode 100644 kernel/drivers/net/stack/include/rtcfg/rtcfg_proc.h
 create mode 100644 kernel/drivers/net/stack/include/rtcfg/rtcfg_timer.h
 create mode 100644 kernel/drivers/net/stack/include/rtcfg_chrdev.h
 create mode 100644 kernel/drivers/net/stack/include/rtdev.h
 create mode 100644 kernel/drivers/net/stack/include/rtdev_mgr.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/nomac/nomac.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/nomac/nomac_dev.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/nomac/nomac_ioctl.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/nomac/nomac_proto.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/rtmac_disc.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/rtmac_proc.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/rtmac_proto.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/rtmac_vnic.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/tdma/tdma.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/tdma/tdma_dev.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/tdma/tdma_ioctl.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/tdma/tdma_proto.h
 create mode 100644 kernel/drivers/net/stack/include/rtmac/tdma/tdma_worker.h
 create mode 100644 kernel/drivers/net/stack/include/rtnet.h
 create mode 100644 kernel/drivers/net/stack/include/rtnet_chrdev.h
 create mode 100644 kernel/drivers/net/stack/include/rtnet_internal.h
 create mode 100644 kernel/drivers/net/stack/include/rtnet_iovec.h
 create mode 100644 kernel/drivers/net/stack/include/rtnet_port.h
 create mode 100644 kernel/drivers/net/stack/include/rtnet_rtpc.h
 create mode 100644 kernel/drivers/net/stack/include/rtnet_socket.h
 create mode 100644 kernel/drivers/net/stack/include/rtskb.h
 create mode 100644 kernel/drivers/net/stack/include/rtskb_fifo.h
 create mode 100644 kernel/drivers/net/stack/include/rtwlan.h
 create mode 100644 kernel/drivers/net/stack/include/rtwlan_io.h
 create mode 100644 kernel/drivers/net/stack/include/stack_mgr.h
 create mode 100644 kernel/drivers/net/stack/include/tdma_chrdev.h
 create mode 100644 kernel/drivers/net/stack/iovec.c
 create mode 100644 kernel/drivers/net/stack/ipv4/Kconfig
 create mode 100644 kernel/drivers/net/stack/ipv4/Makefile
 create mode 100644 kernel/drivers/net/stack/ipv4/af_inet.c
 create mode 100644 kernel/drivers/net/stack/ipv4/arp.c
 create mode 100644 kernel/drivers/net/stack/ipv4/icmp.c
 create mode 100644 kernel/drivers/net/stack/ipv4/ip_fragment.c
 create mode 100644 kernel/drivers/net/stack/ipv4/ip_input.c
 create mode 100644 kernel/drivers/net/stack/ipv4/ip_output.c
 create mode 100644 kernel/drivers/net/stack/ipv4/ip_sock.c
 create mode 100644 kernel/drivers/net/stack/ipv4/protocol.c
 create mode 100644 kernel/drivers/net/stack/ipv4/route.c
 create mode 100644 kernel/drivers/net/stack/ipv4/tcp/Kconfig
 create mode 100644 kernel/drivers/net/stack/ipv4/tcp/Makefile
 create mode 100644 kernel/drivers/net/stack/ipv4/tcp/tcp.c
 create mode 100644 kernel/drivers/net/stack/ipv4/tcp/timerwheel.c
 create mode 100644 kernel/drivers/net/stack/ipv4/tcp/timerwheel.h
 create mode 100644 kernel/drivers/net/stack/ipv4/udp/Kconfig
 create mode 100644 kernel/drivers/net/stack/ipv4/udp/Makefile
 create mode 100644 kernel/drivers/net/stack/ipv4/udp/udp.c
 create mode 100644 kernel/drivers/net/stack/packet/Kconfig
 create mode 100644 kernel/drivers/net/stack/packet/Makefile
 create mode 100644 kernel/drivers/net/stack/packet/af_packet.c
 create mode 100644 kernel/drivers/net/stack/rtcfg/Kconfig
 create mode 100644 kernel/drivers/net/stack/rtcfg/Makefile
 create mode 100644 kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c
 create mode 100644 kernel/drivers/net/stack/rtcfg/rtcfg_conn_event.c
 create mode 100644 kernel/drivers/net/stack/rtcfg/rtcfg_event.c
 create mode 100644 kernel/drivers/net/stack/rtcfg/rtcfg_file.c
 create mode 100644 kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
 create mode 100644 kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
 create mode 100644 kernel/drivers/net/stack/rtcfg/rtcfg_module.c
 create mode 100644 kernel/drivers/net/stack/rtcfg/rtcfg_proc.c
 create mode 100644 kernel/drivers/net/stack/rtcfg/rtcfg_timer.c
 create mode 100644 kernel/drivers/net/stack/rtdev.c
 create mode 100644 kernel/drivers/net/stack/rtdev_mgr.c
 create mode 100644 kernel/drivers/net/stack/rtmac/Kconfig
 create mode 100644 kernel/drivers/net/stack/rtmac/Makefile
 create mode 100644 kernel/drivers/net/stack/rtmac/nomac/Kconfig
 create mode 100644 kernel/drivers/net/stack/rtmac/nomac/Makefile
 create mode 100644 kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c
 create mode 100644 kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c
 create mode 100644 kernel/drivers/net/stack/rtmac/nomac/nomac_module.c
 create mode 100644 kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
 create mode 100644 kernel/drivers/net/stack/rtmac/rtmac_disc.c
 create mode 100644 kernel/drivers/net/stack/rtmac/rtmac_module.c
 create mode 100644 kernel/drivers/net/stack/rtmac/rtmac_proc.c
 create mode 100644 kernel/drivers/net/stack/rtmac/rtmac_proto.c
 create mode 100644 kernel/drivers/net/stack/rtmac/rtmac_syms.c
 create mode 100644 kernel/drivers/net/stack/rtmac/rtmac_vnic.c
 create mode 100644 kernel/drivers/net/stack/rtmac/tdma/Kconfig
 create mode 100644 kernel/drivers/net/stack/rtmac/tdma/Makefile
 create mode 100644 kernel/drivers/net/stack/rtmac/tdma/tdma_dev.c
 create mode 100644 kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
 create mode 100644 kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
 create mode 100644 kernel/drivers/net/stack/rtmac/tdma/tdma_proto.c
 create mode 100644 kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c
 create mode 100644 kernel/drivers/net/stack/rtnet_chrdev.c
 create mode 100644 kernel/drivers/net/stack/rtnet_module.c
 create mode 100644 kernel/drivers/net/stack/rtnet_rtpc.c
 create mode 100644 kernel/drivers/net/stack/rtskb.c
 create mode 100644 kernel/drivers/net/stack/rtwlan.c
 create mode 100644 kernel/drivers/net/stack/socket.c
 create mode 100644 kernel/drivers/net/stack/stack_mgr.c
 create mode 100644 utils/net/Makefile.am
 create mode 100644 utils/net/nomaccfg.c
 create mode 100644 utils/net/rtcfg.c
 create mode 100644 utils/net/rtifconfig.c
 create mode 100644 utils/net/rtiwconfig.c
 create mode 100644 utils/net/rtnet.conf.in
 create mode 100755 utils/net/rtnet.in
 create mode 100644 utils/net/rtping.c
 create mode 100644 utils/net/rtroute.c
 create mode 100644 utils/net/tdma.conf
 create mode 100644 utils/net/tdmacfg.c

-- 
					    Gilles.

