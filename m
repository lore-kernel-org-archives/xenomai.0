Date: Thu, 15 Oct 2020 17:49:28 +0200 (CEST)
From: g.strobbe@telenet.be
Message-ID: <1302180645.84383163.1602776968365.JavaMail.zimbra@telenet.be>
In-Reply-To: <CAMjL99+4AOH=5e6eUh3SUqiLC-ukKtV-rbjadGRV0EbjcZH1zQ@mail.gmail.com>
References: <CAMjL99+4AOH=5e6eUh3SUqiLC-ukKtV-rbjadGRV0EbjcZH1zQ@mail.gmail.com>
Subject: Re: rtnet not locating ethercat slaves
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



----- On Oct 15, 2020, at 4:36 PM, xenomai xenomai@xenomai.org wrote:

> Hi all, thank you so much for the help so far with the setting up of
> xenomai, however I am still stuck with rtnet. Am i missing something to
> find the 6 different slaves on the robot?
> I thought that by modifying the tdma.conf, i will at least be able to get a
> response from the ip of the slave but till now i have no success.
> I have also tried changing the ipaddress, but decided to revert back to
> default to see if i am making a mistake there.
> And my computer have a tendency to freeze after i start rtnet and check the
> rtroute.
> 
> Will appreciate any help i can get with regards to this matter.
> 
> Please do correct me if i am making a mistake.
> 
> after loading into xenomai kernel, I do the following commands :
> 
> sudo ifconfig eth0 down
> 
> sudo rmmod e1000e
> 
> cd /usr/xenomai
> 
> sudo ./rtnet start
> 
> waiting for slaves.
> 
> sudo ./rtifconfig
> 
> rteth0    Medium: Ethernet  Hardware address: 1C:69:7A:0F:04:42
>          IP address: 10.0.0.1  Broadcast address: 10.255.255.255
>          UP BROADCAST  MTU: 1500
> 
> rtlo      Medium: Local Loopback
>          IP address: 127.0.0.1
>          UP LOOPBACK RUNNING  MTU: 1500
> 
> sudo ./rtroute
> 
> Host Routing Table
> Hash Destination HW Address Device
> 00 0.0.0.0   00:00:00:00:00:00 rtlo
> 01 10.0.0.1   00:00:00:00:00:00 rtlo
> 01 127.0.0.1   00:00:00:00:00:00 rtlo
> 3F 10.255.255.255 FF:FF:FF:FF:FF:FF rteth0
> 
> dmesg
> [  566.798184] TDMA: Failed to transmit sync frame!
> 
> cat rtnet.conf
> 
> # This file is usually located in <PREFIX>/etc/rtnet.conf
> # Please adapt it to your system.
> # This configuration file is used with the rtnet script.
> 
> # RTnet installation path
> prefix="/usr/xenomai"
> exec_prefix="${prefix}"
> RTNET_MOD="/lib/modules/`uname -r`/kernel/drivers/xenomai/net"
> RTIFCONFIG="${exec_prefix}/sbin/rtifconfig"
> RTCFG="${exec_prefix}/sbin/rtcfg"
> TDMACFG="${exec_prefix}/sbin/tdmacfg"
> 
> # Module suffix: ".o" for 2.4 kernels, ".ko" for later versions
> MODULE_EXT=".ko"
> 
> 
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
> IPADDR="10.0.0.1"
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
> # TDMA mode of the station ("master" or "slave")
> #   Start backup masters in slave mode, it will then be switched to master
> #   mode automatically during startup.
> TDMA_MODE="master"
> 
> # Master parameters
> 
> # Simple setup: List of TDMA slaves
> #TDMA_SLAVES="10.0.0.2"
> 
> # Simple setup: Cycle time in microsecond
> #TDMA_CYCLE="5000"
> 
> # Simple setup: Offset in microsecond between TDMA slots
> #TDMA_OFFSET="200"
> 
> # Advanced setup: Config file containing all TDMA station parameters
> #   To use this mode, uncomment the following line and disable the
> #   three master parameters above (SLAVES, CYCLE, and OFFSET).
> TDMA_CONFIG="${prefix}/etc/tdma.conf"
> 
> 
> cat tdma.conf
> 
> #
> # Examplary TDMA configuration file
> #
> 
> # Primary master
> 
> master:
> ip 10.0.0.1
> cycle 5000
> slot 0 0
> slot 1 1000
> 
> 
> # Backup master
> #  Cycle is defined by the primary master
> 
> backup-master:
> ip 10.0.0.2
> backup-offset 200
> slot 0 400
> 
> 
> # Slave A
> #  MAC is unknown, slave will be pre-configured to the given IP
> 
> slave:
> ip 10.0.0.3
> slot 0 2000
> slot 1 2200 1/2
> 
> 
> # Slave B
> #  IP is assigned to the slave via its known MAC address
> 
> slave:
> ip 10.0.0.4
> mac 00:12:34:56:AA:FF
> slot 0 2400
> slot 1 2200 2/2

Hi John,

I would start with running soem/test/linux/simple_test/simple_test.c 
after you booted in your regular kernel, not the xenomai patched one,
and recompiled soem for that setup.
Do you see any slaves then?

Best regards,

Gino

