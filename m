From: duanwujie <wjduan@linx-info.com>
Subject: e1000 realtime driver send the the TDMA sync frame failed! [Makedown
 format]
Message-ID: <da661287-381d-ac47-4d3b-8ae1db02a71c@linx-info.com>
Date: Wed, 31 Oct 2018 11:32:03 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: =?UTF-8?B?5b2t5b+X6Iiq?= <zhpeng@linx-info.com>, yuening <ynliu@linx-info.com>

# Test result show below:

```

[   59.778342] RTcfg: rtcfg_do_main_event() rtdev=1, 
event=RTCFG_CMD_ADD, stateG
Waiting for all slaves...[   59.868079] RTcfg: rtcfg_do_main_event() 
rtdev=1, eG
[   60.377777] RTcfg: error -11 while sending stage 1 frame

```

We change the e1000_main.c line with :

```

netdev = rt_alloc_etherdev(sizeof(struct e1000_adapter), 48);

````
to

```

netdev = rt_alloc_etherdev(sizeof(struct e1000_adapter), 1024);

```

This problem was fixed, but the number of rtskb pool size should be a 
meaningful

value, not a magic. Plea check it. The test process and env show as bellow.

--------------------------------------------------------------------------------


# Test envirnment:


* System version:


     Distributor ID:    Debian
     Description:    Debian GNU/Linux 9.5 (stretch)
     Release:    9.5
     Codename:    stretch

* QEMU version:

     /usr/bin/qemu-system-x86_64 --version
     QEMU emulator version 2.12.0 (Debian 1:2.12+dfsg-3)
     Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

* Used VM Script: qemu-x86.sh

     /usr/bin/qemu-system-x86_64 \
         -m 1G \
         -kernel bzImage \
         -append "root=/dev/sda rdinit=/sbin/init console=ttyS0 115200 
nokaslr" \
         -hda ./rootfs6.ext2 \
         -nographic \
         -device e1000,netdev=dev0,mac='00:00:00:01:00:01' \
         -netdev tap,ifname=tap0,id=dev0,script=no,downscript=no,vhost=on

* Xenomai version: xenomai-3.0.7.tar.bz2
* I-Pipe patch version: ipipe-core-4.9.51-x86-5.patch
* Kernel version: linux-4.9.51


The rtnet master config  file [rtnet.conf] was used as following :


```

     # This file is usually located in <PREFIX>/etc/rtnet.conf
     # Please adapt it to your sdriverystem.
     # This configuration file is used with the rtnet script.

     # RTnet installation path
     prefix="/usr/"
     exec_prefix="${prefix}"
     RTNET_MOD="/root"
     RTIFCONFIG="${exec_prefix}/sbin/rtifconfig"
     RTCFG="${exec_prefix}/sbin/rtcfg"
     TDMACFG="${exec_prefix}/sbin/tdmacfg"

     # Module suffix: ".o" for 2.4 kernels, ".ko" for later versions
     MODULE_EXT=".ko"



     # RT-NIC driver
     #RT_DRIVER="rt_e1000"
     RT_DRIVER="rt_8139too"
     RT_DRIVER_OPTIONS=""

     # PCI addresses of RT-NICs to claim (format: 0000:00:00.0)
     #   If both Linux and RTnet drivers for the same hardware are 
loaded, this
     #   list instructs the start script to rebind the given PCI 
devices, detaching
     #   from their Linux driver, attaching it to the RT driver above. 
Example:
     #   REBIND_RT_NICS="0000:00:19.0 0000:01:1d.1"
     REBIND_RT_NICS=""

     # IP address and netmask of this station
     #   The TDMA_CONFIG file overrides these parameters for masters and 
backup
     #   masters. Leave blank if you do not use IP addresses or if this 
station is
     #   intended to retrieve its IP from the master based on its MAC 
address.
     IPADDR="10.0.0.3"
     NETMASK=""

     # Start realtime loopback device ("yes" or "no")
     RT_LOOPBACK="yes"

     # Use the following RTnet protocol drivers
     RT_PROTOCOLS="udp packet"

     # Start capturing interface ("yes" or "no")
     RTCAP="no"



     # Common RTcfg stage 2 config data (master mode only)
     #   The TDMA_CONFIG file overrides this parameter.
     STAGE_2_SRC=""

     # Stage 2 config data destination file (slave mode only)
     STAGE_2_DST=""

     # Command to be executed after stage 2 phase (slave mode only)
     STAGE_2_CMDS=""



     # TDMA mode of the station ("master" or "slave")
     #   Start backup masters in slave mode, it will then be switched to 
master
     #   mode automatically during startup.
     TDMA_MODE="master"


     # Master parameters

     # Simple setup: List of TDMA slaves
     TDMA_SLAVES="10.0.0.4"

     # Simple setup: Cycle time in microsecond
     TDMA_CYCLE="5000"

     # Simple setup: Offset in microsecond between TDMA slots
     TDMA_OFFSET="200"

     # Advanced setup: Config file containing all TDMA station parameters
     #   To use this mode, uncomment the following line and disable the
     #   three master parameters above (SLAVES, CYCLE, and OFFSET).
     TDMA_CONFIG="./tdma.conf"

```




