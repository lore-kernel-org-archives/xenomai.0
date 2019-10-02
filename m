Subject: Re: [PATCH] Re: Kernel crash at startup when enabling RTNet + RTIPv4
References: <b80-5d948c00-11d-62bca880@213400888>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b207a751-021b-a80d-605b-d6ee2db7daef@siemens.com>
Date: Wed, 2 Oct 2019 14:34:41 +0200
MIME-Version: 1.0
In-Reply-To: <b80-5d948c00-11d-62bca880@213400888>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
Cc: xenomai@xenomai.org

On 02.10.19 13:38, François Legal wrote:
> This is the good one.
> 
>  From 19a61adb4ce04889c1fe772b16bbdc32abfb8c22 Mon Sep 17 00:00:00 2001
> From: dev <dev@DevCoreProcessing.assystem>
> Date: Wed, 2 Oct 2019 11:56:00 +0200
> Subject: [PATCH] Allow RTNet to be builtin kernel
> 

Missing signed-off at least. Some word on why you changed the Makefile would be 
good (for the record, I know this still).

Could you also summarize how you tested the result?

> ---
>   kernel/drivers/net/Kconfig        |   1 -
>   kernel/drivers/net/addons/Kconfig |   4 +-
>   kernel/drivers/net/stack/Makefile |  16 ++---
>   utils/net/rtnet.in                | 148 +++++++++++++++++++++++---------------
>   4 files changed, 101 insertions(+), 68 deletions(-)
> 
> diff --git a/kernel/drivers/net/Kconfig b/kernel/drivers/net/Kconfig
> index ac3bced..49d2402 100644
> --- a/kernel/drivers/net/Kconfig
> +++ b/kernel/drivers/net/Kconfig
> @@ -1,7 +1,6 @@
>   menu "RTnet"
>   
>   config XENO_DRIVERS_NET
> -    depends on m
>       select NET
>       tristate "RTnet, TCP/IP socket interface"
>   
> diff --git a/kernel/drivers/net/addons/Kconfig b/kernel/drivers/net/addons/Kconfig
> index baa6cbc..616ed40 100644
> --- a/kernel/drivers/net/addons/Kconfig
> +++ b/kernel/drivers/net/addons/Kconfig
> @@ -2,7 +2,7 @@ menu "Add-Ons"
>       depends on XENO_DRIVERS_NET
>   
>   config XENO_DRIVERS_NET_ADDON_RTCAP
> -    depends on XENO_DRIVERS_NET && m
> +    depends on XENO_DRIVERS_NET
>       select ETHERNET
>       tristate "Real-Time Capturing Support"
>       default n
> @@ -18,7 +18,7 @@ config XENO_DRIVERS_NET_ADDON_RTCAP
>       For further information see Documentation/README.rtcap.
>   
>   config XENO_DRIVERS_NET_ADDON_PROXY
> -    depends on XENO_DRIVERS_NET_RTIPV4 && m
> +    depends on XENO_DRIVERS_NET_RTIPV4
>       select ETHERNET
>       tristate "IP protocol proxy for Linux"
>       default n
> diff --git a/kernel/drivers/net/stack/Makefile b/kernel/drivers/net/stack/Makefile
> index d055dc2..f8db6fa 100644
> --- a/kernel/drivers/net/stack/Makefile
> +++ b/kernel/drivers/net/stack/Makefile
> @@ -1,13 +1,5 @@
>   ccflags-y += -Idrivers/xenomai/net/stack/include -Ikernel/
>   
> -obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4) += ipv4/
> -
> -obj-$(CONFIG_XENO_DRIVERS_NET_RTPACKET) += packet/
> -
> -obj-$(CONFIG_XENO_DRIVERS_NET_RTMAC) += rtmac/
> -
> -obj-$(CONFIG_XENO_DRIVERS_NET_RTCFG) += rtcfg/
> -
>   obj-$(CONFIG_XENO_DRIVERS_NET) += rtnet.o
>   
>   rtnet-y :=  \
> @@ -23,4 +15,12 @@ rtnet-y :=  \
>   	stack_mgr.o \
>   	eth.o
>   
> +obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4) += ipv4/
> +
> +obj-$(CONFIG_XENO_DRIVERS_NET_RTPACKET) += packet/
> +
> +obj-$(CONFIG_XENO_DRIVERS_NET_RTMAC) += rtmac/
> +
> +obj-$(CONFIG_XENO_DRIVERS_NET_RTCFG) += rtcfg/
> +
>   rtnet-$(CONFIG_XENO_DRIVERS_NET_RTWLAN) += rtwlan.o
> diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
> index f81a7bb..3c3cab9 100644
> --- a/utils/net/rtnet.in
> +++ b/utils/net/rtnet.in
> @@ -31,44 +31,62 @@ EOF
>   }
>   
>   init_rtnet() {
> -    modprobe rtnet >/dev/null || exit 1
> -    modprobe rtipv4 >/dev/null || exit 1
> -    modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
> +    if [ ! -d /proc/rtnet ]; then
> +        modprobe rtnet >/dev/null || exit 1

Maybe we should add "set -x" to the script so that every unhandled failure 
becomes visible. Can be done separately, though.

> +    fi
>   
> -    for dev in $REBIND_RT_NICS; do
> -	if [ -d /sys/bus/pci/devices/$dev/driver ]; then
> -	    echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
> -	fi
> -	echo $dev > /sys/bus/pci/drivers/$RT_DRIVER/bind
> -    done
> +    if [ ! -d /proc/rtnet/ipv4 ]; then
> +        modprobe rtipv4 >/dev/null || exit 1
> +        for PROTOCOL in $RT_PROTOCOLS; do
> +            modprobe rt$PROTOCOL >/dev/null || exit 1
> +        done

rtpacket does not depend on rtipv4.

> +    fi
>   
> -    for PROTOCOL in $RT_PROTOCOLS; do
> -	modprobe rt$PROTOCOL >/dev/null || exit 1
> -    done
> +    $(cat /proc/rtnet/devices | grep -q rteth0)
> +    if [ $? -eq 1 ]; then
> +        modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
> +
> +        for dev in $REBIND_RT_NICS; do
> +            if [ -d /sys/bus/pci/devices/$dev/driver ]; then
> +                echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
> +            fi
> +            echo $dev > /sys/bus/pci/drivers/$RT_DRIVER/bind
> +        done
> +    fi
>   
>       if [ $RT_LOOPBACK = "yes" ]; then
> -	modprobe rt_loopback >/dev/null || exit 1
> +        $(cat /proc/rtnet/devices | grep -q rtlo)
> +        if [ $? -eq 1 ]; then
> +
> +            modprobe rt_loopback >/dev/null || exit 1
> +        fi
>       fi
>   
> -    if [ $RTCAP = "yes" ]; then
> -	modprobe rtcap >/dev/null || exit 1
> +    if [ $RTCAP = "yes" -a ! -d /sys/modules/rtcap ]; then
> +        modprobe rtcap >/dev/null || exit 1
>       fi
>   
>       if [ $RT_LOOPBACK = "yes" ]; then
> -	$RTIFCONFIG rtlo up 127.0.0.1
> +        $RTIFCONFIG rtlo up 127.0.0.1
>       fi
>   
>       if [ $RTCAP = "yes" ]; then
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

Reformatting is appreciated, but this is better done separately, to ease my 
review. :)

>       fi
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
>   }
>   
>   submit_cfg() {
> @@ -329,43 +347,59 @@ case "$1" in
>   	;;
>   
>       master)
> -	shift
> -	init_rtnet
> -	TDMA_SLAVES=$*
> -	start_master
> -	;;
> +        shift
> +        init_rtnet
> +        TDMA_SLAVES=$*
> +        start_master
> +        ;;
>   
>       capture)
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
> +        $(cat /proc/rtnet/devices | grep -q rteth0)
> +        if [ $? -eq 1 ]; then
> +            modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
> +        fi
> +        if [ ! -d /sys/modules/rtcap ]; then
> +            modprobe rtcap >/dev/null || exit 1
> +        fi
> +        $RTIFCONFIG rteth0 up promisc
> +        ifconfig rteth0 up
> +        ifconfig rteth0-mac up
> +        ;;
>   
>       loopback)
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
> +            for PROTOCOL in $RT_PROTOCOLS; do
> +                modprobe rt$PROTOCOL >/dev/null || exit 1
> +            done
> +        fi
> +
> +        if [ $RT_LOOPBACK = "yes" ]; then
> +            $(cat /proc/rtnet/devices | grep -q rtlo)
> +            if [ $? -eq 1 ]; then
> +
> +                modprobe rt_loopback >/dev/null || exit 1
> +            fi
> +        fi
> +
> +        if [ $RTCAP = "yes" -a ! -d /sys/modules/rtcap ]; then
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
>       *)
> -	usage
> -	exit 1
> +        usage
> +        exit 1
>   esac
> 

I think you are missing the rmmod in the "stop" path.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

