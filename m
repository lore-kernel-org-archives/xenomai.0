From: Umair Ali <ali.umair@tut.fi>
Date: Thu, 5 Nov 2015 15:17:45 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A705E86@mb2010-3.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A705D34@mb2010-3.intra.tut.fi>
 <20151103114717.GA26720@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A705DA6@mb2010-3.intra.tut.fi>,
 <20151103144651.GC26720@hermes.click-hack.org>
In-Reply-To: <20151103144651.GC26720@hermes.click-hack.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Pcap replay tool for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hello Gilles, 

I have managed to install the xenomai on Ubuntu 13.04 (kernel 3.08). The version of the xenomai is 3.0.1 and kernel version is 3.10.32. The following is the output after the reboot

"root@cpc:/usr/src/linux-3.10.32# uname -a
Linux cpc 3.10.32-xenomai-3.0.1 #2 SMP PREEMPT Thu Nov 5 11:07:39 EET 2015 i686 i686 i686 GNU/Linux
root@cpc:/usr/src/linux-3.10.32# dmesg | grep -i xenomai
[    0.000000] Linux version 3.10.32-xenomai-3.0.1 (root@cpc) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-1ubuntu1) ) #2 SMP PREEMPT Thu Nov 5 11:07:39 EET 2015
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.10.32-xenomai-3.0.1 root=UUID=b1b34a08-de22-4aee-a956-10b378d690b9 ro crashkernel=384M-2G:64M,2G-:128M quiet splash vt.handoff=7
[    0.743556] [Xenomai] scheduling class idle registered.
[    0.743561] [Xenomai] scheduling class rt registered.
[    0.743608] [Xenomai] SMI-enabled chipset found, but SMI workaround disabled
[    0.743608]           (see xenomai.smi parameter). You might encounter
[    0.743753] I-pipe: head domain Xenomai registered.
[    0.744329] [Xenomai] Cobalt v3.0.1 (Exact Zero) [DEBUG]
[    1.300135] usb usb1: Manufacturer: Linux 3.10.32-xenomai-3.0.1 ehci_hcd
[    1.300942] usb usb2: Manufacturer: Linux 3.10.32-xenomai-3.0.1 uhci_hcd
[    1.301539] usb usb3: Manufacturer: Linux 3.10.32-xenomai-3.0.1 uhci_hcd
[    1.302135] usb usb4: Manufacturer: Linux 3.10.32-xenomai-3.0.1 uhci_hcd
[    1.302734] usb usb5: Manufacturer: Linux 3.10.32-xenomai-3.0.1 uhci_hcd
root@cpc:/usr/src/linux-3.10.32#""

The latency test of the xenomai is as follows
"root@cpc:/usr/xenomai/bin# ./latency 
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      2.637|      3.474|     20.177|       0|     0|      2.637|     20.177
RTD|      2.424|      3.451|     12.743|       0|     0|      2.424|     20.177
RTD|      2.404|      3.412|     13.037|       0|     0|      2.404|     20.177
RTD|      2.584|      3.447|     25.031|       0|     0|      2.404|     25.031
RTD|      2.079|      3.435|     12.987|       0|     0|      2.079|     25.031
RTD|      2.348|      3.444|     12.823|       0|     0|      2.079|     25.031
RTD|      2.564|      3.433|     13.177|       0|     0|      2.079|     25.031
RTD|      2.400|      3.424|     12.928|       0|     0|      2.079|     25.031
RTD|      2.342|      3.424|     12.750|       0|     0|      2.079|     25.031
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|      2.079|      3.438|     25.031|       0|     0|    00:00:09/00:00:09
root@cpc:/usr/xenomai/bin# "

I ran it for more that 5 secs also

Further i have checked if the real time driver module for the RTnet is installed so

"root@cpc:/usr/src/linux-3.10.32# modinfo rt_8139too
filename:       /lib/modules/3.10.32-xenomai-3.0.1/kernel/drivers/xenomai/net/drivers/rt_8139too.ko
license:        GPL
description:    RealTek RTL-8139 Fast Ethernet driver
author:         Jeff Garzik <jgarzik@mandrakesoft.com>
srcversion:     8917430E2BB14CA4186EE54
alias:          pci:v*d00008139sv000013D1sd0000AB06bc*sc*i*
alias:          pci:v*d00008139sv00001186sd00001300bc*sc*i*
alias:          pci:v*d00008139sv000010ECsd00008139bc*sc*i*
alias:          pci:v000010ECd00008129sv*sd*bc*sc*i*
alias:          pci:v0000021Bd00008139sv*sd*bc*sc*i*
alias:          pci:v00001743d00008139sv*sd*bc*sc*i*
alias:          pci:v0000126Cd00001211sv*sd*bc*sc*i*
alias:          pci:v0000018Ad00000106sv*sd*bc*sc*i*
alias:          pci:v000002ACd00001012sv*sd*bc*sc*i*
alias:          pci:v00001432d00009130sv*sd*bc*sc*i*
alias:          pci:v000011DBd00001234sv*sd*bc*sc*i*
alias:          pci:v000014EAd0000AB07sv*sd*bc*sc*i*
alias:          pci:v000014EAd0000AB06sv*sd*bc*sc*i*
alias:          pci:v00001259d0000A11Esv*sd*bc*sc*i*
alias:          pci:v00001259d0000A117sv*sd*bc*sc*i*
alias:          pci:v000013D1d0000AB06sv*sd*bc*sc*i*
alias:          pci:v00001186d00001340sv*sd*bc*sc*i*
alias:          pci:v00001186d00001300sv*sd*bc*sc*i*
alias:          pci:v00004033d00001360sv*sd*bc*sc*i*
alias:          pci:v00001500d00001360sv*sd*bc*sc*i*
alias:          pci:v00001113d00001211sv*sd*bc*sc*i*
alias:          pci:v000010ECd00008138sv*sd*bc*sc*i*
alias:          pci:v000010ECd00008139sv*sd*bc*sc*i*
depends:        rtnet
intree:         Y
vermagic:       3.10.32-xenomai-3.0.1 SMP preempt mod_unload modversions PENTIUM4 
parm:           cards:array of cards to be supported (e.g. 1,0,1) (array of int)
parm:           media:8139too: Bits 4+9: force full duplex, bit 5: 100Mbps (array of int)
parm:           rx_pool_size:number of receive buffers (uint)
root@cpc:/usr/src/linux-3.10.32# "

I have also observed that module 8139too is also running. 
As i am new to the linux so i want to make sure if i have installed the xenomai with rtnet correctly. Can you tell me is there a way i stop the 8139too module and make rt_8139too module as default driver for NIC. And then use TCPreplay command such as 
"tcpreplayy --pps=4000 --intf1=eth0 stream.pcap"
to play back the pcap file as we can do in the non real kernel.

Please guide me and find the attach xenomai config file with the email. I shall be thankful to you

Regards
Ali Umair
________________________________________
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Sent: Tuesday, November 03, 2015 4:46 PM
To: Umair Ali
Cc: Xenomai
Subject: Re: [Xenomai] Pcap replay tool for xenomai

On Tue, Nov 03, 2015 at 02:31:34PM +0000, Umair Ali wrote:
> [    0.489562] Xenomai: real-time nucleus v2.6.0 (Movin' On)
> loaded.

Xenomai 2.6.0 is seriously outdated (released in 2011).

> I have run the latency tests on the xenomai and it works fine. The results of the latency are as follows
-----
> RTS|      0.545|      1.328|     12.077|       0|     0|    00:00:06/00:00:06

I hope you have run the test for more than 6 seconds before
concluding that xenomai runs fine.

> root@cpc:/usr/xenomai/bin# "
>
> Now i follow the following links to install the RTnet on xenomai:
> 1) https://xenomai.org/rtnet-installation/ 2)
> http://rtnet.org/doc.html

> And used the guide also for the initial
> test of the RTnet drivers. When i type the command "sudo ./rtnet
> start" my pc froze and i need to do the brutal restart. But some
> time it works and i am able to do ping by "sudo ./rtping <loop
> back IP>". But after the "sudo ./rtnet stop" it never ping again.
> The config.log and rtnet.conf files for the configuration of the
> Rtnet are attached with the email. Also I did not observe any
> error while installation. Therefore i am not sure if RTnet will
> work for me. Please guide me how i can go from here to achieve my
> goal. Thanks in advance for your time and advice

That version of RTnet is not maintained by the Xenomai project. We
merged RTnet in Xenomai 3, but in order to benefit from it, you
would have to install Xenomai 3.0.1 (and note that the above
installation instructions do not apply, since RTnet is now merged,
it means the kernel-space support has to be enabled in the kernel
configuration, and the user-space support is compiled
unconditionally). Also note that the loopback interface is broken in
Xenomai 3.0.1, it will be fixed in 3.0.2, however 8139too should
work.

Please keep the conversation on the mailing list.

--
                                            Gilles.
https://click-hack.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.log
Type: text/x-log
Size: 49532 bytes
Desc: config.log
URL: <http://xenomai.org/pipermail/xenomai/attachments/20151105/57111a1d/attachment.bin>
