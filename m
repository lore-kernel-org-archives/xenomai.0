Subject: Re: [PATCH] Allow RTNet to be builtin kernel
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <b7f-5d95ad00-59-344a2840@235462221>
 <5d66ea9f-6d24-db4a-0512-bd09721d1074@siemens.com>
Message-ID: <6cd14e32-78ca-58ac-17f7-b0239b1b2ddf@siemens.com>
Date: Fri, 4 Oct 2019 15:36:41 +0200
MIME-Version: 1.0
In-Reply-To: <5d66ea9f-6d24-db4a-0512-bd09721d1074@siemens.com>
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, Xenomai <xenomai@xenomai.org>

On 04.10.19 13:10, Jan Kiszka wrote:
> On 03.10.19 10:10, François Legal via Xenomai wrote:
>> Subject: [PATCH] Allow RTNet to be builtin kernel
>>
>> Makefile is changed because when builtin, the modules
>> get loaded in the link order. In the previous version
>> protocols would get loaded before stackmgr which
>> obviously fails.
>>
>> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
>>
>> ---
>>
>> This has been tested on Zynq 7000 Hardware (microzed
>> board) with MACB/GEM RTNet driver, with linux 4.4.189
>> vanilla. Kernel boots up correctly, and the following
>> messages get printed on the console during the boot :
>>
>> [   13.875451] sdhci-pltfm: SDHCI platform and OF driver helper
>> [   13.881627] sdhci-arasan e0100000.sdhci: No vmmc regulator found
>> [   13.887581] sdhci-arasan e0100000.sdhci: No vqmmc regulator found
>> [   13.927585] mmc0: SDHCI controller on e0100000.sdhci [e0100000.sdhci] using ADMA
>> [   13.945085] fpga_manager fpga0: Xilinx Zynq FPGA Manager registered
>> [   13.951896]
>> [   13.951896] *** RTnet for Xenomai v3.0.9 ***
>> [   13.951896]
>> [   13.959156] RTnet: initialising real-time networking
>> [   13.964928] RTmac/TDMA: init time division multiple access control mechanism
>> [   13.972074] RTmac: init realtime media access control
>> [   13.977064] RTcfg: init real-time configuration distribution protocol
>> [   13.983752] initializing loopback...
>> [   13.987295] RTnet: registered rtlo
>> [   13.993238] RTnet: registered rteth0
>> [   13.996832] libphy: MACB_mii_bus: probed
>> [   14.001140] rt_macb: rteth0: Cadence GEM at 0xe000b000 irq 26 (00:0a:35:00:01:22)
>> [   14.008630] rt_macb: rteth0: attached PHY driver [Marvell 88E1510] (mii_bus:phy_addr=e000b000.ethernet-ffffffff:00, irq=-1)
>> [   14.019845] RTcap: real-time capturing interface
>> [   14.026562] RTproxy attached to rteth0
>> [   14.031129] rtnetproxy installed as "rtproxy"
>> [   14.035693] NET: Registered protocol family 26
>> [   14.040309] NET: Registered protocol family 17
>> [   14.044686] can: controller area network core (rev 20120528 abi 9)
>> [   14.050957] NET: Registered protocol family 29
>> [   14.055329] can: raw protocol (rev 20120528)
>> [   14.059683] can: broadcast manager protocol (rev 20120528 t)
>>
>>    kernel/drivers/net/Kconfig        |  1 -
>>    kernel/drivers/net/addons/Kconfig |  4 ++--
>>    kernel/drivers/net/stack/Makefile | 16 ++++++++--------
>>    utils/net/rtnet.in | 144 +++++++++++++++++++++++++++++++++++------------------
>>    4 files changed, 105 insertions(+), 60 deletions(-)
>>
>> diff --git a/kernel/drivers/net/Kconfig b/kernel/drivers/net/Kconfig
>> index ac3bced..49d2402 100644
>> --- a/kernel/drivers/net/Kconfig
>> +++ b/kernel/drivers/net/Kconfig
>> @@ -1,7 +1,6 @@
>>    menu "RTnet"
>>    
>>    config XENO_DRIVERS_NET
>> -    depends on m
>>        select NET
>>        tristate "RTnet, TCP/IP socket interface"
>>    
>> diff --git a/kernel/drivers/net/addons/Kconfig b/kernel/drivers/net/addons/Kconfig
>> index baa6cbc..616ed40 100644
>> --- a/kernel/drivers/net/addons/Kconfig
>> +++ b/kernel/drivers/net/addons/Kconfig
>> @@ -2,7 +2,7 @@ menu "Add-Ons"
>>        depends on XENO_DRIVERS_NET
>>    
>>    config XENO_DRIVERS_NET_ADDON_RTCAP
>> -    depends on XENO_DRIVERS_NET && m
>> +    depends on XENO_DRIVERS_NET
>>        select ETHERNET
>>        tristate "Real-Time Capturing Support"
>>        default n
>> @@ -18,7 +18,7 @@ config XENO_DRIVERS_NET_ADDON_RTCAP
>>        For further information see Documentation/README.rtcap.
>>    
>>    config XENO_DRIVERS_NET_ADDON_PROXY
>> -    depends on XENO_DRIVERS_NET_RTIPV4 && m
>> +    depends on XENO_DRIVERS_NET_RTIPV4
>>        select ETHERNET
>>        tristate "IP protocol proxy for Linux"
>>        default n
>> diff --git a/kernel/drivers/net/stack/Makefile b/kernel/drivers/net/stack/Makefile
>> index d055dc2..f8db6fa 100644
>> --- a/kernel/drivers/net/stack/Makefile
>> +++ b/kernel/drivers/net/stack/Makefile
>> @@ -1,13 +1,5 @@
>>    ccflags-y += -Idrivers/xenomai/net/stack/include -Ikernel/
>>    
>> -obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4) += ipv4/
>> -
>> -obj-$(CONFIG_XENO_DRIVERS_NET_RTPACKET) += packet/
>> -
>> -obj-$(CONFIG_XENO_DRIVERS_NET_RTMAC) += rtmac/
>> -
>> -obj-$(CONFIG_XENO_DRIVERS_NET_RTCFG) += rtcfg/
>> -
>>    obj-$(CONFIG_XENO_DRIVERS_NET) += rtnet.o
>>    
>>    rtnet-y :=  \
>> @@ -23,4 +15,12 @@ rtnet-y :=  \
>>    	stack_mgr.o \
>>    	eth.o
>>    
>> +obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4) += ipv4/
>> +
>> +obj-$(CONFIG_XENO_DRIVERS_NET_RTPACKET) += packet/
>> +
>> +obj-$(CONFIG_XENO_DRIVERS_NET_RTMAC) += rtmac/
>> +
>> +obj-$(CONFIG_XENO_DRIVERS_NET_RTCFG) += rtcfg/
>> +
>>    rtnet-$(CONFIG_XENO_DRIVERS_NET_RTWLAN) += rtwlan.o
>> diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
>> index f81a7bb..fa12a03 100644
>> --- a/utils/net/rtnet.in
>> +++ b/utils/net/rtnet.in
>> @@ -31,44 +31,68 @@ EOF
>>    }
>>    
>>    init_rtnet() {
>> -    modprobe rtnet >/dev/null || exit 1
>> -    modprobe rtipv4 >/dev/null || exit 1
>> -    modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
>> -
>> -    for dev in $REBIND_RT_NICS; do
>> -	if [ -d /sys/bus/pci/devices/$dev/driver ]; then
>> -	    echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
>> -	fi
>> -	echo $dev > /sys/bus/pci/drivers/$RT_DRIVER/bind
>> -    done
>> +    if [ ! -d /proc/rtnet ]; then
>> +        modprobe rtnet >/dev/null || exit 1
>> +    fi
>>    
>> +    if [ ! -d /proc/rtnet/ipv4 ]; then
>> +        modprobe rtipv4 >/dev/null || exit 1
>> +    fi
>>        for PROTOCOL in $RT_PROTOCOLS; do
>> -	modprobe rt$PROTOCOL >/dev/null || exit 1
>> +        if [ ! -d /sys/modules/rt$PROTOCOL ]; then
>> +            if [ "$PROTOCOL" = "packet" ]; then
>> +                modprobe rt$PROTOCOL >/dev/null
>> +            else
>> +                modprobe rt$PROTOCOL >/dev/null || exit 1
>> +            fi
>> +        fi
>>        done
>>    
>> +    $(cat /proc/rtnet/devices | grep -q rteth0)
>> +    if [ $? -eq 1 ]; then
>> +        modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
>> +
>> +        for dev in $REBIND_RT_NICS; do
>> +            if [ -d /sys/bus/pci/devices/$dev/driver ]; then
>> +                echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
>> +            fi
>> +            echo $dev > /sys/bus/pci/drivers/$RT_DRIVER/bind
>> +        done
>> +    fi
>> +
>>        if [ $RT_LOOPBACK = "yes" ]; then
>> -	modprobe rt_loopback >/dev/null || exit 1
>> +        $(cat /proc/rtnet/devices | grep -q rtlo)
>> +        if [ $? -eq 1 ]; then
>> +
>> +            modprobe rt_loopback >/dev/null || exit 1
>> +        fi
>>        fi
>>    
>> -    if [ $RTCAP = "yes" ]; then
>> -	modprobe rtcap >/dev/null || exit 1
>> +    if [ $RTCAP = "yes" -a ! -d /sys/modules/rtcap ]; then
>> +        modprobe rtcap >/dev/null || exit 1
>>        fi
>>    
>>        if [ $RT_LOOPBACK = "yes" ]; then
>> -	$RTIFCONFIG rtlo up 127.0.0.1
>> +        $RTIFCONFIG rtlo up 127.0.0.1
>>        fi
>>    
>>        if [ $RTCAP = "yes" ]; then
>> -	ifconfig rteth0 up
>> -	ifconfig rteth0-mac up
>> -	if [ $RT_LOOPBACK = "yes" ]; then
>> -	    ifconfig rtlo up
>> -	fi
>> +        ifconfig rteth0 up
>> +        ifconfig rteth0-mac up
>> +        if [ $RT_LOOPBACK = "yes" ]; then
>> +            ifconfig rtlo up
>> +        fi
>>        fi
>>    
>> -    modprobe rtcfg >/dev/null
>> -    modprobe rtmac >/dev/null
>> -    modprobe tdma >/dev/null
>> +    if [ ! -d /proc/rtnet/rtcfg ]; then
>> +        modprobe rtcfg >/dev/null
>> +    fi
>> +    if [ ! -d /proc/rtnet/rtmac ]; then
>> +        modprobe rtmac >/dev/null
>> +    fi
>> +    if [ ! -f /proc/tdma ]; then
>> +        modprobe tdma >/dev/null
>> +    fi
>>    }
>>    
>>    submit_cfg() {
>> @@ -336,34 +360,56 @@ case "$1" in
>>    	;;
>>    
>>        capture)
>> -	modprobe rtnet >/dev/null || exit 1
>> -	modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
>> -	modprobe rtcap >/dev/null || exit 1
>> -	$RTIFCONFIG rteth0 up promisc
>> -	ifconfig rteth0 up
>> -	ifconfig rteth0-mac up
>> -	;;
>> +        if [ ! -d /proc/rtnet ]; then
>> +            modprobe rtnet >/dev/null || exit 1
>> +        fi
>> +        $(cat /proc/rtnet/devices | grep -q rteth0)
>> +        if [ $? -eq 1 ]; then
>> +            modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
>> +        fi
>> +        if [ ! -d /sys/modules/rtcap ]; then
>> +            modprobe rtcap >/dev/null || exit 1
>> +        fi
>> +        $RTIFCONFIG rteth0 up promisc
>> +        ifconfig rteth0 up
>> +        ifconfig rteth0-mac up
>> +        ;;
>>    
>>        loopback)
>> -	modprobe rtnet >/dev/null || exit 1
>> -	modprobe rtipv4 >/dev/null || exit 1
>> -
>> -	for PROTOCOL in $RT_PROTOCOLS; do
>> -	    modprobe rt$PROTOCOL >/dev/null || exit 1
>> -	done
>> -
>> -	modprobe rt_loopback >/dev/null || exit 1
>> -
>> -	if [ $RTCAP = "yes" ]; then
>> -	    modprobe rtcap >/dev/null || exit 1
>> -	fi
>> -
>> -	$RTIFCONFIG rtlo up 127.0.0.1
>> -
>> -	if [ $RTCAP = "yes" ]; then
>> -	    ifconfig rtlo up
>> -	fi
>> -	;;
>> +        if [ ! -d /proc/rtnet ]; then
>> +            modprobe rtnet >/dev/null || exit 1
>> +        fi
>> +        if [ ! -d /proc/rtnet/ipv4 ]; then
>> +            modprobe rtipv4 >/dev/null || exit 1
>> +        fi
>> +        for PROTOCOL in $RT_PROTOCOLS; do
>> +            if [ ! -d /sys/modules/rt$PROTOCOL ]; then
>> +                if [ "$PROTOCOL" = "packet" ]; then
>> +                    modprobe rt$PROTOCOL >/dev/null
>> +                else
>> +                    modprobe rt$PROTOCOL >/dev/null || exit 1
>> +                fi
>> +            fi
>> +        done
>> +
>> +        if [ $RT_LOOPBACK = "yes" ]; then
>> +            $(cat /proc/rtnet/devices | grep -q rtlo)
>> +            if [ $? -eq 1 ]; then
>> +
>> +                modprobe rt_loopback >/dev/null || exit 1
>> +            fi
>> +        fi
>> +
>> +        if [ $RTCAP = "yes" -a ! -d /sys/modules/rtcap ]; then
>> +            modprobe rtcap >/dev/null || exit 1
>> +        fi
>> +
>> +        $RTIFCONFIG rtlo up 127.0.0.1
>> +
>> +        if [ $RTCAP = "yes" ]; then
>> +            ifconfig rtlo up
>> +        fi
>> +        ;;
>>    
>>        *)
>>    	usage
>>
> 
> Could you check if this delta on top works as well?
> 
> diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
> index fa12a0378a..84f7eed00d 100644
> --- a/utils/net/rtnet.in
> +++ b/utils/net/rtnet.in
> @@ -48,8 +48,7 @@ init_rtnet() {
>           fi
>       done
>   
> -    $(cat /proc/rtnet/devices | grep -q rteth0)
> -    if [ $? -eq 1 ]; then
> +    if grep -vq rteth0 /proc/rtnet/devices; then
>           modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
>   
>           for dev in $REBIND_RT_NICS; do
> @@ -61,9 +60,7 @@ init_rtnet() {
>       fi
>   
>       if [ $RT_LOOPBACK = "yes" ]; then
> -        $(cat /proc/rtnet/devices | grep -q rtlo)
> -        if [ $? -eq 1 ]; then
> -
> +        if grep -vq rtlo /proc/rtnet/devices; then
>               modprobe rt_loopback >/dev/null || exit 1
>           fi
>       fi
> @@ -363,8 +360,7 @@ case "$1" in
>           if [ ! -d /proc/rtnet ]; then
>               modprobe rtnet >/dev/null || exit 1
>           fi
> -        $(cat /proc/rtnet/devices | grep -q rteth0)
> -        if [ $? -eq 1 ]; then
> +        if grep -vq rteth0 /proc/rtnet/devices; then
>               modprobe $RT_DRIVER $RT_DRIVER_OPTIONS >/dev/null || exit 1
>           fi
>           if [ ! -d /sys/modules/rtcap ]; then
> @@ -393,9 +389,7 @@ case "$1" in
>           done
>   
>           if [ $RT_LOOPBACK = "yes" ]; then
> -            $(cat /proc/rtnet/devices | grep -q rtlo)
> -            if [ $? -eq 1 ]; then
> -
> +            if grep -vq rtlo /proc/rtnet/devices; then
>                   modprobe rt_loopback >/dev/null || exit 1
>               fi
>           fi
> 
> Then I would prefer it and would merge the combination to next. It looks
> safe and orthogonal enough for -rc2.

Nah, not yet. We need to check the drivers first. At least the e1000 have 
non-static symbols that collide with the in-tree version.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

