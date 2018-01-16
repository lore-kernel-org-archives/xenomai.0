MIME-Version: 1.0
In-Reply-To: <CAOuPNLgu+U_TkT8XgCLF70JVQmrEqug380LqY3FX=yqPCC_X2w@mail.gmail.com>
References: <CAOuPNLgu+U_TkT8XgCLF70JVQmrEqug380LqY3FX=yqPCC_X2w@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 16 Jan 2018 19:06:13 +0530
Message-ID: <CAOuPNLi8DVVpon8GWmMn_fVC_=J2083ur6EVa5CuZO_zW8Q24w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [RTnet] - rtnet module installation issue using
	rtnet.conf
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@web.de, Pintu Kumar <pintu.ping@gmail.com>

Ok, I think I found the problem.

> modprobe: FATAL: Module rttcp not found in directory

1)
I think the rttcp module is disabled in the kernel.

drivers/xenomai/net/stack/ipv4/Kconfig:
# source "drivers/xenomai/net/stack/ipv4/tcp/Kconfig"

But I wonder, why the rttcp is commented out in the kernel source.
Is there any problem using tcp on xenomai ?


2)  If I remove "tcp" from rtnet.conf and also make RTCAP as "no", I
am able to run the rtnet script.
But, I still get the following errors:

# sudo /usr/xenomai/sbin/rtnet start
ioctl: No such device
ioctl: No such device
ioctl: No such device
ioctl: No such device
ioctl (add): No such device
ioctl (add): No such device
ioctl (add): No such device
vnic0: ERROR while getting interface flags: No such device
SIOCSIFADDR: No such device
vnic0: ERROR while getting interface flags: No such device
SIOCSIFNETMASK: No such device
Waiting for all slaves...ioctl: No such device
ioctl: No such device


However, the rt_ modules are getting installed.

# lsmod | grep rt
rtmac                   7879  1 tdma
rtcfg                  32455  0
rt_loopback             1143  1
rtpacket                5768  0
rtudp                   9262  0
rt_eepro100            14398  0
rtipv4                 21568  2 rtudp,rtcfg
rtnet                  46929  8
rtipv4,rt_loopback,rtmac,rt_eepro100,rtpacket,rtudp,rtcfg,tdma


3) Another problem is, if I do : ifconfig, I could not find any rtnet0 node.
    Also, if I run: "/usr/xenomai/sbin/rtping 10.0.2.15", I get this:
# sudo /usr/xenomai/sbin/rtping 10.0.2.15
Real-time PING 10.0.2.15 56(84) bytes of data.
ioctl: No route to host

    So, how can I make sure that rtnet is working ?


Thanks,
Pintu


On Tue, Jan 16, 2018 at 5:42 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> Hi,
>
> I have brought up Xenomai 3.0.6 (dual kernel, cobalt) on a
> Ubuntu-32-bit machine with Linux Kernel version 4.9.62.
> # cat /proc/xenomai/version
> 3.0.6
>
> # uname -a
> Linux osboxes 4.9.62-pintu-xeno-3.0.6+ #4 SMP Wed Jan 3 18:54:46 IST
> 2018 i686 i686 i686 GNU/Linux
>
> My Xenomai libraries are installed under:
> # ls /usr/xenomai/
> bin/     demo/    etc/     include/ lib/     sbin/
>
>
> I have verified with sample posix and native application and the
> xenomai is working fine.
>
> -------------------------
> Next, I wanted to check rtdm driver such as RTnet.
> So, I noticed that RTNET module needs to be enabled in my patched kernel 4.9.62.
> So, I enabled it and installed the modules successfully.
>
> I also see that the modules are installed under:
> # ls /lib/modules/4.9.62-pintu-xeno-3.0.6+/kernel/drivers/xenomai/net/drivers/
> e1000/          rt_8139too.ko   rt_eepro100.ko  rt_loopback.ko
>
> # ls /lib/modules/4.9.62-pintu-xeno-3.0.6+/kernel/drivers/xenomai/net/stack/
> ipv4/     packet/   rtcfg/    rtmac/    rtnet.ko
>
>
> So, after that, when I try to install the rtnet driver, I get the
> following error:
> # sudo /usr/xenomai/sbin/rtnet -v start
> Turning on verbose mode
> modprobe: FATAL: Module rttcp not found in directory
> /lib/modules/4.9.62-pintu-xeno-3.0.6+
>
>
> When, I check the config file, the RTNET module path is listed as:
> RTNET_MOD="/lib/modules/`uname -r`/kernel/drivers/xenomai/net"
>
>
> I tried changing it to the correct path by adding xenomai/net/drivers
> or xenomai/net/stack, but still I get the same error.
>
>
> Please let me know how to correctly install the RTNET driver using the
> /usr/xenomai/sbin/rtnet scripts.
>
>
>
> Thanks,
> Pintu

