MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 10 Apr 2018 18:52:11 +0530
Message-ID: <CAOuPNLgfpzTWgeBZcsntHDP07cOPyvhPEZM6WsQ453s=6id3tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] [RTNET]: Which rtnet driver to use with beagle bone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>

Hi,

I am using:
Beagle Bone Kernel: 4.9.51
Xenomai: 3.0.6
Board: Beagle Bone White

When I enable RTNET, the following ethernet drivers are build.
$ ls drivers/xenomai/net/drivers/*.ko
drivers/xenomai/net/drivers/rt_8139too.ko
drivers/xenomai/net/drivers/rt_eepro100.ko
drivers/xenomai/net/drivers/rt_loopback.ko

But I think beagle bone using different ethernet driver.
ti_cpsw
CONFIG_TI_CPSW=y
Also this is by default in-built into the kernel. So I cannot remove the module.

When I try installing the available once it did install but network
did not work.
rtnet                  52594  10
rt_8139too,rtipv4,rt_loopback,rtmac,rt_eepro100,rtpacket,rtudp,rt_e1000,rtcfg,tdma

# /usr/xenomai/sbin/rtifconfig rteth0 up
ioctl: No such device


So, I wanted to know is there any rtnet ethernet driver available
which works with beagle bone ?


Thanks,
Pintu

