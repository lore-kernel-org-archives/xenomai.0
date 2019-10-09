Subject: Re: [PATCH] Allow RTNet to be builtin kernel
References: <30dd-5d9d8a80-29-21e4bb80@177086950>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <db2e1d20-8c65-1b58-b006-f1d7ab059bbf@siemens.com>
Date: Wed, 9 Oct 2019 09:24:14 +0200
MIME-Version: 1.0
In-Reply-To: <30dd-5d9d8a80-29-21e4bb80@177086950>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>
Cc: Xenomai <xenomai@xenomai.org>

On 09.10.19 09:21, François Legal via Xenomai wrote:
> From: François LEGAL <devel@thom.fr.eu.org>
> 
> Subject: [PATCH] Allow RTNet to be builtin kernel
> 
> Makefile is changed because when builtin, the modules get loaded in the link order. In the previous version protocols would get loaded before stackmgr which obviously fails.
> 
> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> 
> ---
> 
> This has been tested on Zynq 7000 Hardware (microzed board) with MACB/GEM RTNet driver, with linux 4.4.189 vanilla. Kernel boots up correctly, and the following messages get printed on the console during the boot :
> 
> [   13.875451] sdhci-pltfm: SDHCI platform and OF driver helper
> [   13.881627] sdhci-arasan e0100000.sdhci: No vmmc regulator found
> [   13.887581] sdhci-arasan e0100000.sdhci: No vqmmc regulator found
> [   13.927585] mmc0: SDHCI controller on e0100000.sdhci [e0100000.sdhci] using ADMA
> [   13.945085] fpga_manager fpga0: Xilinx Zynq FPGA Manager registered
> [   13.951896]
> [   13.951896] *** RTnet for Xenomai v3.0.9 ***
> [   13.951896]
> [   13.959156] RTnet: initialising real-time networking
> [   13.964928] RTmac/TDMA: init time division multiple access control mechanism
> [   13.972074] RTmac: init realtime media access control
> [   13.977064] RTcfg: init real-time configuration distribution protocol
> [   13.983752] initializing loopback...
> [   13.987295] RTnet: registered rtlo
> [   13.993238] RTnet: registered rteth0
> [   13.996832] libphy: MACB_mii_bus: probed
> [   14.001140] rt_macb: rteth0: Cadence GEM at 0xe000b000 irq 26 (00:0a:35:00:01:22)
> [   14.008630] rt_macb: rteth0: attached PHY driver [Marvell 88E1510] (mii_bus:phy_addr=e000b000.ethernet-ffffffff:00, irq=-1)
> [   14.019845] RTcap: real-time capturing interface
> [   14.026562] RTproxy attached to rteth0
> [   14.031129] rtnetproxy installed as "rtproxy"
> [   14.035693] NET: Registered protocol family 26
> [   14.040309] NET: Registered protocol family 17
> [   14.044686] can: controller area network core (rev 20120528 abi 9)
> [   14.050957] NET: Registered protocol family 29
> [   14.055329] can: raw protocol (rev 20120528)
> [   14.059683] can: broadcast manager protocol (rev 20120528 t)
> 
>  kernel/drivers/net/Kconfig         |   1 -
>  kernel/drivers/net/addons/Kconfig  |   4 +-
>  kernel/drivers/net/drivers/Kconfig |  22 +++---
>  kernel/drivers/net/stack/Makefile  |  16 ++---
>  utils/net/rtnet.in                 | 138 ++++++++++++++++++++++++-------------
>  5 files changed, 110 insertions(+), 71 deletions(-)
> 
> diff --git a/kernel/drivers/net/Kconfig b/kernel/drivers/net/Kconfig
> index ac3bced..49d2402 100644
> --- a/kernel/drivers/net/Kconfig
> +++ b/kernel/drivers/net/Kconfig
> @@ -1,7 +1,6 @@
>  menu "RTnet"
>  
>  config XENO_DRIVERS_NET
> -    depends on m
>      select NET
>      tristate "RTnet, TCP/IP socket interface"
>  
> diff --git a/kernel/drivers/net/addons/Kconfig b/kernel/drivers/net/addons/Kconfig
> index baa6cbc..616ed40 100644
> --- a/kernel/drivers/net/addons/Kconfig
> +++ b/kernel/drivers/net/addons/Kconfig
> @@ -2,7 +2,7 @@ menu "Add-Ons"
>      depends on XENO_DRIVERS_NET
>  
>  config XENO_DRIVERS_NET_ADDON_RTCAP
> -    depends on XENO_DRIVERS_NET && m
> +    depends on XENO_DRIVERS_NET
>      select ETHERNET
>      tristate "Real-Time Capturing Support"
>      default n
> @@ -18,7 +18,7 @@ config XENO_DRIVERS_NET_ADDON_RTCAP
>      For further information see Documentation/README.rtcap.
>  
>  config XENO_DRIVERS_NET_ADDON_PROXY
> -    depends on XENO_DRIVERS_NET_RTIPV4 && m
> +    depends on XENO_DRIVERS_NET_RTIPV4
>      select ETHERNET
>      tristate "IP protocol proxy for Linux"
>      default n
> diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
> index 65f0855..6140f94 100644
> --- a/kernel/drivers/net/drivers/Kconfig
> +++ b/kernel/drivers/net/drivers/Kconfig
> @@ -10,7 +10,7 @@ config XENO_DRIVERS_NET_DRV_PCNET32
>  
>  
>  config XENO_DRIVERS_NET_DRV_TULIP
> -    depends on XENO_DRIVERS_NET && PCI
> +    depends on XENO_DRIVERS_NET && PCI && m
>      tristate "DEC Tulip"
>  
>  
> @@ -40,12 +40,12 @@ config XENO_DRIVERS_NET_DRV_EEPRO100_DBG
>  
>  
>  config XENO_DRIVERS_NET_DRV_E1000
> -    depends on XENO_DRIVERS_NET && PCI
> +    depends on XENO_DRIVERS_NET && PCI && m
>      tristate "Intel(R) PRO/1000 (Gigabit)"
>      default y
>  
>  config XENO_DRIVERS_NET_DRV_E1000E
> -    depends on XENO_DRIVERS_NET && PCI
> +    depends on XENO_DRIVERS_NET && PCI && m
>      tristate "New Intel(R) PRO/1000 PCIe (Gigabit)"
>  
>  
> @@ -68,7 +68,7 @@ config XENO_DRIVERS_NET_DRV_VIA_RHINE
>  config XENO_DRIVERS_NET_DRV_IGB
>      select I2C
>      select I2C_ALGOBIT
> -    depends on XENO_DRIVERS_NET && PCI
> +    depends on XENO_DRIVERS_NET && PCI && m
>      tristate "Intel(R) 82575 (Gigabit)"
>  
>  
> @@ -83,22 +83,22 @@ comment "Embedded MPC Drivers"
>      depends on XENO_DRIVERS_NET
>  
>  config XENO_DRIVERS_NET_DRV_FCC_ENET
> -    depends on XENO_DRIVERS_NET
> +    depends on XENO_DRIVERS_NET && m
>      tristate "MPC8260 FCC Ethernet"
>  
>  
>  config XENO_DRIVERS_NET_DRV_FEC_ENET
> -    depends on XENO_DRIVERS_NET
> +    depends on XENO_DRIVERS_NET && m
>      tristate "MPC8xx FEC Ethernet"
>  
>  
>  config XENO_DRIVERS_NET_DRV_SCC_ENET
> -    depends on XENO_DRIVERS_NET
> +    depends on XENO_DRIVERS_NET && m
>      tristate "MPC8xx SCC Ethernet"
>  
>  
>  config XENO_DRIVERS_NET_DRV_MPC52XX_FEC
> -    depends on XENO_DRIVERS_NET
> +    depends on XENO_DRIVERS_NET && m
>      tristate "MPC52xx FEC Ethernet"
>  
>  endif
> @@ -124,9 +124,9 @@ config XENO_DRIVERS_NET_DRV_AT91_ETHER
>      tristate "AT91RM9200 Board Ethernet Driver"
>  
>  config XENO_DRIVERS_NET_DRV_MACB
> -    depends on XENO_DRIVERS_NET && ARCH_AT91
> -    select AT91_PROGRAMMABLE_CLOCKS
> -    tristate "MACB AT91SAM926x devices"
> +    depends on XENO_DRIVERS_NET
> +    select AT91_PROGRAMMABLE_CLOCKS if ARCH_AT91
> +    tristate "Cadence MACB/GEM devices"
>      ---help---
>      Driver for internal MAC-controller on AT91SAM926x microcontrollers.
>      Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
> diff --git a/kernel/drivers/net/stack/Makefile b/kernel/drivers/net/stack/Makefile
> index d055dc2..f8db6fa 100644
> --- a/kernel/drivers/net/stack/Makefile
> +++ b/kernel/drivers/net/stack/Makefile
> @@ -1,13 +1,5 @@
>  ccflags-y += -Idrivers/xenomai/net/stack/include -Ikernel/
>  
> -obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4) += ipv4/
> -
> -obj-$(CONFIG_XENO_DRIVERS_NET_RTPACKET) += packet/
> -
> -obj-$(CONFIG_XENO_DRIVERS_NET_RTMAC) += rtmac/
> -
> -obj-$(CONFIG_XENO_DRIVERS_NET_RTCFG) += rtcfg/
> -
>  obj-$(CONFIG_XENO_DRIVERS_NET) += rtnet.o
>  
>  rtnet-y :=  \
> @@ -23,4 +15,12 @@ rtnet-y :=  \
>  	stack_mgr.o \
>  	eth.o
>  
> +obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4) += ipv4/
> +
> +obj-$(CONFIG_XENO_DRIVERS_NET_RTPACKET) += packet/
> +
> +obj-$(CONFIG_XENO_DRIVERS_NET_RTMAC) += rtmac/
> +
> +obj-$(CONFIG_XENO_DRIVERS_NET_RTCFG) += rtcfg/
> +
>  rtnet-$(CONFIG_XENO_DRIVERS_NET_RTWLAN) += rtwlan.o
> diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
> index f81a7bb..7e6264c 100644
> --- a/utils/net/rtnet.in
> +++ b/utils/net/rtnet.in
> @@ -31,44 +31,65 @@ EOF
>  }
>  
>  init_rtnet() {
> -    modprobe rtnet >/dev/null || exit 1
> -    modprobe rtipv4 >/dev/null || exit 1
> -    modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
> -
> -    for dev in $REBIND_RT_NICS; do
> -	if [ -d /sys/bus/pci/devices/$dev/driver ]; then
> -	    echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
> -	fi
> -	echo $dev > /sys/bus/pci/drivers/$RT_DRIVER/bind
> -    done
> +    if [ ! -d /proc/rtnet ]; then
> +        modprobe rtnet >/dev/null || exit 1
> +    fi
>  
> +    if [ ! -d /proc/rtnet/ipv4 ]; then
> +        modprobe rtipv4 >/dev/null || exit 1
> +    fi
>      for PROTOCOL in $RT_PROTOCOLS; do
> -	modprobe rt$PROTOCOL >/dev/null || exit 1
> +        if [ ! -d /sys/module/rt$PROTOCOL ]; then
> +            if [ "$PROTOCOL" = "packet" ]; then
> +                modprobe rt$PROTOCOL >/dev/null 2>&1
> +            else
> +                modprobe rt$PROTOCOL >/dev/null || exit 1
> +            fi
> +        fi
>      done
>  
> +    if ! grep q rteth0 /proc/rtnet/devices; then
> +        modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
> +
> +        for dev in $REBIND_RT_NICS; do
> +            if [ -d /sys/bus/pci/devices/$dev/driver ]; then
> +                echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
> +            fi
> +            echo $dev > /sys/bus/pci/drivers/$RT_DRIVER/bind
> +        done
> +    fi
> +
>      if [ $RT_LOOPBACK = "yes" ]; then
> -	modprobe rt_loopback >/dev/null || exit 1
> +        if ! grep q rtlo /proc/rtnet/devices; then
> +            modprobe rt_loopback >/dev/null || exit 1
> +        fi
>      fi
>  
> -    if [ $RTCAP = "yes" ]; then
> -	modprobe rtcap >/dev/null || exit 1
> +    if [ $RTCAP = "yes" -a ! -d /sys/module/rtcap ]; then
> +        modprobe rtcap >/dev/null || exit 1
>      fi
>  
>      if [ $RT_LOOPBACK = "yes" ]; then
> -	$RTIFCONFIG rtlo up 127.0.0.1
> +        $RTIFCONFIG rtlo up 127.0.0.1
>      fi
>  
>      if [ $RTCAP = "yes" ]; then
> -	ifconfig rteth0 up
> -	ifconfig rteth0-mac up
> -	if [ $RT_LOOPBACK = "yes" ]; then
> -	    ifconfig rtlo up
> -	fi
> +        ifconfig rteth0 up
> +        ifconfig rteth0-mac up
> +        if [ $RT_LOOPBACK = "yes" ]; then
> +            ifconfig rtlo up
> +        fi
>      fi
>  
> -    modprobe rtcfg >/dev/null
> -    modprobe rtmac >/dev/null
> -    modprobe tdma >/dev/null
> +    if [ ! -d /proc/rtnet/rtcfg ]; then
> +        modprobe rtcfg >/dev/null
> +    fi
> +    if [ ! -d /proc/rtnet/rtmac ]; then
> +        modprobe rtmac >/dev/null
> +    fi
> +    if [ ! -f /proc/tdma ]; then
> +        modprobe tdma >/dev/null
> +    fi
>  }
>  
>  submit_cfg() {
> @@ -336,34 +357,53 @@ case "$1" in
>  	;;
>  
>      capture)
> -	modprobe rtnet >/dev/null || exit 1
> -	modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
> -	modprobe rtcap >/dev/null || exit 1
> -	$RTIFCONFIG rteth0 up promisc
> -	ifconfig rteth0 up
> -	ifconfig rteth0-mac up
> -	;;
> +        if [ ! -d /proc/rtnet ]; then
> +            modprobe rtnet >/dev/null || exit 1
> +        fi
> +        if ! grep q rteth0 /proc/rtnet/devices; then
> +            modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
> +        fi
> +        if [ ! -d /sys/module/rtcap ]; then
> +            modprobe rtcap >/dev/null || exit 1
> +        fi
> +        $RTIFCONFIG rteth0 up promisc
> +        ifconfig rteth0 up
> +        ifconfig rteth0-mac up
> +        ;;
>  
>      loopback)
> -	modprobe rtnet >/dev/null || exit 1
> -	modprobe rtipv4 >/dev/null || exit 1
> -
> -	for PROTOCOL in $RT_PROTOCOLS; do
> -	    modprobe rt$PROTOCOL >/dev/null || exit 1
> -	done
> -
> -	modprobe rt_loopback >/dev/null || exit 1
> -
> -	if [ $RTCAP = "yes" ]; then
> -	    modprobe rtcap >/dev/null || exit 1
> -	fi
> -
> -	$RTIFCONFIG rtlo up 127.0.0.1
> -
> -	if [ $RTCAP = "yes" ]; then
> -	    ifconfig rtlo up
> -	fi
> -	;;
> +        if [ ! -d /proc/rtnet ]; then
> +            modprobe rtnet >/dev/null || exit 1
> +        fi
> +        if [ ! -d /proc/rtnet/ipv4 ]; then
> +            modprobe rtipv4 >/dev/null || exit 1
> +        fi
> +        for PROTOCOL in $RT_PROTOCOLS; do
> +            if [ ! -d /sys/module/rt$PROTOCOL ]; then
> +                if [ "$PROTOCOL" = "packet" ]; then
> +                    modprobe rt$PROTOCOL >/dev/null 2>&1
> +                else
> +                    modprobe rt$PROTOCOL >/dev/null || exit 1
> +                fi
> +            fi
> +        done
> +
> +        if [ $RT_LOOPBACK = "yes" ]; then
> +            if ! grep q rtlo /proc/rtnet/devices; then
> +                modprobe rt_loopback >/dev/null || exit 1
> +            fi
> +        fi
> +
> +        if [ $RTCAP = "yes" -a ! -d /sys/module/rtcap ]; then
> +            modprobe rtcap >/dev/null || exit 1
> +        fi
> +
> +        $RTIFCONFIG rtlo up 127.0.0.1
> +
> +        if [ $RTCAP = "yes" ]; then
> +            ifconfig rtlo up
> +        fi
> +        ;;
>  
>      *)
>  	usage
> 

I got this three times - which one is valid?

Also, for future clarity, please version your patches
("[PATCH v3] ...").

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

