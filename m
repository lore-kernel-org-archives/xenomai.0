Date: Sat, 10 Oct 2020 13:32:00 +0200 (CEST)
From: g.strobbe@telenet.be
Message-ID: <1402891899.63309095.1602329520316.JavaMail.zimbra@telenet.be>
In-Reply-To: <CAMjL99+gwR9SBwa82_+ohd+TixVBqK5wEJBgxQzkrKHkeBmarw@mail.gmail.com>
References: <CAMjL99+gwR9SBwa82_+ohd+TixVBqK5wEJBgxQzkrKHkeBmarw@mail.gmail.com>
Subject: Re: Unable to connect rt e1000e driver to Intel Ethernet Connection
 I219-V
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Ho <johnho26@gmail.com>
Cc: xenomai <xenomai@xenomai.org>



----- On Oct 10, 2020, at 12:32 PM, xenomai xenomai@xenomai.org wrote:

> Hi there I am currently trying to run xenomai 3 with rtnet, however i am
> encountering an issue when i start rtnet. the error is listed below. I am
> unsure if it is something that i have installed wrongly or that something
> is broken with my pci driver.
> I will appreciate any help I can get to resolve this issue
> 
> 
> ./rtnet start
> 
> sh: echo: I/O error
> rteth0: ERROR while getting interface flags: No such device
> rteth0-mac: ERROR while getting interface flags: No such device
> ioctl: No such device
> ioctl: No such device
> ioctl: No such device
> ioctl: No such device
> ioctl (add): No such device
> vnic0: ERROR while getting interface flags: No such device
> SIOCSIFADDR: No such device
> vnic0: ERROR while getting interface flags: No such device
> SIOCSIFNETMASK: No such device
> Waiting for all slaves...ioctl: No such device
> ioctl: No such device
> 
> 
> 
> 
> 
> rtnet.conf:
> 
> # RT-NIC driver
> RT_DRIVER="rt_e1000e"
> RT_DRIVER_OPTIONS=""
> 
> # PCI addresses of RT-NICs to claim (format: 0000:00:00.0)
> #   If both Linux and RTnet drivers for the same hardware are loaded, this
> #   list instructs the start script to rebind the given PCI devices,
> detaching
> #   from their Linux driver, attaching it to the RT driver above. Example:
> #   REBIND_RT_NICS="0000:00:19.0 0000:01:1d.1"
> REBIND_RT_NICS="0000:00:1f.6"
> 
> # IP address and netmask of this station
> #   The TDMA_CONFIG file overrides these parameters for masters and backup
> #   masters. Leave blank if you do not use IP addresses or if this station
> is
> #   intended to retrieve its IP from the master based on its MAC address.
> IPADDR="192.168.2.10"
> NETMASK="255.255.255.0"
> 
> # Start realtime loopback device ("yes" or "no")
> RT_LOOPBACK="yes"
> 
> # Use the following RTnet protocol drivers
> RT_PROTOCOLS="udp packet"
> 
> # Start capturing interface ("yes" or "no")
> RTCAP="yes"
> 
> 
> 
> # Common RTcfg stage 2 config data (master mode only)
> #   The TDMA_CONFIG file overrides this parameter.
> STAGE_2_SRC=""
> 
> # Stage 2 config data destination file (slave mode only)
> STAGE_2_DST=""
> 
> # Command to be executed after stage 2 phase (slave mode only)
> STAGE_2_CMDS=""
> 
> 
> 
> # TDMA mode of the station ("master" or "slave")
> #   Start backup masters in slave mode, it will then be switched to master
> #   mode automatically during startup.
> TDMA_MODE="master"
> 
> 
> # Master parameters
> 
> # Simple setup: List of TDMA slaves
> TDMA_SLAVES="127.0.0.1"
> 
> # Simple setup: Cycle time in microsecond
> TDMA_CYCLE="450"
> 
> # Simple setup: Offset in microsecond between TDMA slots
> TDMA_OFFSET="50"
> 
> # Advanced setup: Config file containing all TDMA station parameters
> #   To use this mode, uncomment the following line and disable the
> #   three master parameters above (SLAVES, CYCLE, and OFFSET).
> #TDMA_CONFIG="${prefix}/etc/tdma.conf"
> 
> 
> 
> DMESG | more
> 
> 
> 
> 
> [    4.165120] e1000e: Intel(R) PRO/1000 Network Driver - 3.8.4-NAPI
> [    4.165123] e1000e: Copyright(c) 1999 - 2020 Intel Corporation.
> [    4.165849] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec)
> set to dynamic conservative mode
> [    4.174609] intel_rapl: Found RAPL domain package
> [    4.174611] intel_rapl: Found RAPL domain core
> [    4.174614] intel_rapl: Found RAPL domain uncore
> [    4.174618] intel_rapl: Found RAPL domain dram
> [    4.194121] iwlwifi 0000:00:14.3: base HW address: 4c:1d:96:ca:87:b7
> [    4.235819] usb-storage 4-1.3:1.0: USB Mass Storage device detected
> [    4.235949] scsi host3: usb-storage 4-1.3:1.0
> [    4.236113] usbcore: registered new interface driver usb-storage
> [    4.237969] usbcore: registered new interface driver uas
> [    4.265890] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
> [    4.266332] thermal thermal_zone1: failed to read out thermal zone (-61)
> [    4.379264] random: crng init done
> [    4.440978] audit: type=1400 audit(1602324907.951:2): apparmor="STATUS"
> operation="profile_load" name="/usr/sbin/ippusbxd" pid=599
> comm="apparmor_parser"
> [    4.494494] audit: type=1400 audit(1602324908.004:3): apparmor="STATUS"
> operation="profile_load" name="/usr/bin/man" pid=594 comm="apparmor_parser"
> [    4.494767] audit: type=1400 audit(1602324908.004:4): apparmor="STATUS"
> operation="profile_load" name="man_filter" pid=594 comm="apparmor_parser"
> [    4.495177] audit: type=1400 audit(1602324908.005:5): apparmor="STATUS"
> operation="profile_load" name="man_groff" pid=594 comm="apparmor_parser"
> [    4.526716] audit: type=1400 audit(1602324908.036:6): apparmor="STATUS"
> operation="profile_load" name="/usr/sbin/cups-browsed" pid=597
> comm="apparmor_parser"
> [    4.543488] audit: type=1400 audit(1602324908.053:7): apparmor="STATUS"
> operation="profile_load" name="/usr/lib/snapd/snap-confine" pid=596
> comm="apparmor_parser"
> [    4.543716] audit: type=1400 audit(1602324908.053:8): apparmor="STATUS"
> operation="profile_load"
> name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=596
> comm="apparmor_parser"
> [    4.555301] audit: type=1400 audit(1602324908.065:9): apparmor="STATUS"
> operation="profile_load" name="/usr/sbin/tcpdump" pid=604
> comm="apparmor_parser"
> [    4.571697] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered
> PHC clock
> [    4.574161] audit: type=1400 audit(1602324908.084:10): apparmor="STATUS"
> operation="profile_load" name="/sbin/dhclient" pid=593
> comm="apparmor_parser"
> [    4.639535] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1)
> 1c:69:7a:0f:04:42
> [    4.639544] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network
> Connection
> [    4.639666] e1000e 0000:00:1f.6 eth0: MAC: 13, PHY: 12, PBA No:
> FFFFFF-0FF
> [    5.297326] scsi 3:0:0:0: Direct-Access     Generic- SD/MMC
> 1.00 PQ: 0 ANSI: 6
> [    5.297714] scsi 3:0:0:1: Direct-Access     Generic- Micro SD/M2
> 1.08 PQ: 0 ANSI: 6
> [    5.298147] sd 3:0:0:0: Attached scsi generic sg0 type 0
> [    5.298408] sd 3:0:0:1: Attached scsi generic sg1 type 0
> [    5.299579] sd 3:0:0:1: [sdb] Attached SCSI removable disk
> [    5.299968] sd 3:0:0:0: [sda] Attached SCSI removable disk
> [    6.949111] audit_printk_skb: 18 callbacks suppressed
> [    6.949114] audit: type=1400 audit(1602324910.459:17): apparmor="STATUS"
> operation="profile_load" name="/usr/bin/evince" pid=595
> comm="apparmor_parser"
> [    6.949672] audit: type=1400 audit(1602324910.459:18): apparmor="STATUS"
> operation="profile_load" name="/usr/bin/evince//sanitized_helper" pid=595
> comm="apparmor_parser"
> [    6.950381] audit: type=1400 audit(1602324910.460:19): apparmor="STATUS"
> operation="profile_load" name="/usr/bin/evince-previewer" pid=595
> comm="apparmor_parser"
> [    6.950648] audit: type=1400 audit(1602324910.460:20): apparmor="STATUS"
> operation="profile_load" name="/usr/bin/evince-previewer//sanitized_helper"
> pid=595 comm="apparmor_parser"
> [    6.951062] audit: type=1400 audit(1602324910.461:21): apparmor="STATUS"
> operation="profile_load" name="/usr/bin/evince-thumbnailer" pid=595
> comm="apparmor_parser"
> [    6.980324] audit: type=1400 audit(1602324910.490:22): apparmor="STATUS"
> operation="profile_load" name="snap-update-ns.core" pid=674
> comm="apparmor_parser"
> [    7.028888] audit: type=1400 audit(1602324910.538:23): apparmor="STATUS"
> operation="profile_load" name="snap-update-ns.gnome-calculator" pid=675
> comm="apparmor_parser"
> [    7.047830] audit: type=1400 audit(1602324910.558:24): apparmor="STATUS"
> operation="profile_load" name="snap-update-ns.gnome-characters" pid=677
> comm="apparmor_parser"
> [    7.099305] audit: type=1400 audit(1602324910.609:25): apparmor="STATUS"
> operation="profile_load" name="snap-update-ns.gnome-logs" pid=679
> comm="apparmor_parser"
> [    7.116489] audit: type=1400 audit(1602324910.626:26): apparmor="STATUS"
> operation="profile_load" name="snap-update-ns.gnome-system-monitor" pid=681
> comm="apparmor_parser"
> [    7.926021] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [    8.113042] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [    8.116619] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> [    8.123187] iwlwifi 0000:00:14.3: Applying debug destination
> EXTERNAL_DRAM
> [    8.234697] iwlwifi 0000:00:14.3: Applying debug destination
> EXTERNAL_DRAM
> [    8.299586] iwlwifi 0000:00:14.3: FW already configured (0) -
> re-configuring
> [    8.312764] iwlwifi 0000:00:14.3: BIOS contains WGDS but no WRDS
> [    8.313403] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> [    8.370531] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> [    9.355509] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    9.355511] Bluetooth: BNEP filters: protocol multicast
> [    9.355515] Bluetooth: BNEP socket layer initialized
> [   11.716215] wlan0: authenticate with 18:e8:29:6a:ac:0e
> [   11.719131] wlan0: send auth to 18:e8:29:6a:ac:0e (try 1/3)
> [   11.864812] wlan0: send auth to 18:e8:29:6a:ac:0e (try 2/3)
> [   11.973056] wlan0: send auth to 18:e8:29:6a:ac:0e (try 3/3)
> [   12.080803] wlan0: authentication with 18:e8:29:6a:ac:0e timed out
> [   12.172572] e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full
> Duplex, Flow Control: Rx/Tx
> [   12.172663] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [   12.208061] wlan0: authenticate with 18:e8:29:6b:ac:0e
> [   12.210895] wlan0: send auth to 18:e8:29:6b:ac:0e (try 1/3)
> [   12.253483] wlan0: authenticated
> [   12.253803] wlan0: associate with 18:e8:29:6b:ac:0e (try 1/3)
> [   12.258336] wlan0: RX AssocResp from 18:e8:29:6b:ac:0e (capab=0x411
> status=0 aid=3)
> [   12.260336] wlan0: associated
> [   12.260353] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [   22.485826] rfkill: input handler disabled
> [   24.065300] mm/pgtable-generic.c:21: bad pgd
> ffff9328aee67148(0000000000000004)
> [   25.106027] mm/pgtable-generic.c:21: bad pgd
> ffff93289abf5140(6c89f06700000000)
> [   26.174073] mm/pgtable-generic.c:21: bad pgd
> ffff932888d77140(6c89f06700000000)
> [  253.086789]
>               *** RTnet for Xenomai v3.0.5 ***
> 
> [  253.086791] RTnet: initialising real-time networking
> [  253.096452] rt_e1000e: unknown parameter '0' ignored
> [  253.096521] rt_e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k-rt
> [  253.096522] rt_e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
> [  253.096854] e1000e 0000:00:1f.6 eth0: removed PHC
> [  253.174565] e1000e 0000:00:1f.6 eth0: NIC Link is Down
> [  253.211584] initializing loopback...
> [  253.211596] RTnet: registered rtlo
> [  253.214844] RTcap: real-time capturing interface
> [  253.233639] RTcfg: init real-time configuration distribution protocol
> [  253.237698] RTmac: init realtime media access control
> [  253.241226] RTmac/TDMA: init time division multiple access control
> mechanism

Hey John,

The rt_e1000e: Intel(R) PRO/1000 Network Driver - 1.5.1-k-rt driver does not support your I219-V device.

Your problem is the same as in the following link:
https://www.mail-archive.com/xenomai@xenomai.org/msg17197.html

You can find the patches you need to upgrade the rt_e1000e: Intel(R) PRO/1000 Network Driver driver to version 3.2.6-k-rt at:
https://www.mail-archive.com/xenomai@xenomai.org/msg16000.html

I checked my /xenomai/kernel/drivers/net/drivers/e1000e/hw.h and your device seems to be 
in as well so it should be supported once you applied the patches.

#define E1000_DEV_ID_PCH_SPT_I219_LM		0x156F	/* SPT PCH */
#define E1000_DEV_ID_PCH_SPT_I219_V		0x1570	/* SPT PCH */
#define E1000_DEV_ID_PCH_SPT_I219_LM2		0x15B7	/* SPT-H PCH */
#define E1000_DEV_ID_PCH_SPT_I219_V2		0x15B8	/* SPT-H PCH */
#define E1000_DEV_ID_PCH_LBG_I219_LM3		0x15B9	/* LBG PCH */
#define E1000_DEV_ID_PCH_SPT_I219_LM4		0x15D7
#define E1000_DEV_ID_PCH_SPT_I219_V4		0x15D8
#define E1000_DEV_ID_PCH_SPT_I219_LM5		0x15E3
#define E1000_DEV_ID_PCH_SPT_I219_V5		0x15D6
#define E1000_DEV_ID_PCH_CNP_I219_LM6		0x15BD
#define E1000_DEV_ID_PCH_CNP_I219_V6		0x15BE
#define E1000_DEV_ID_PCH_CNP_I219_LM7		0x15BB
#define E1000_DEV_ID_PCH_CNP_I219_V7		0x15BC
#define E1000_DEV_ID_PCH_ICP_I219_LM8		0x15DF
#define E1000_DEV_ID_PCH_ICP_I219_V8		0x15E0
#define E1000_DEV_ID_PCH_ICP_I219_LM9		0x15E1
#define E1000_DEV_ID_PCH_ICP_I219_V9		0x15E2

Best regards,

Gino


