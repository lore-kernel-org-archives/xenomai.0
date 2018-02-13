MIME-Version: 1.0
In-Reply-To: <CALLqZ8R8W7XuOprQ6cxjXU2GWy8+1iw6FV-CfhLr5U1rhkmHig@mail.gmail.com>
References: <CAOuPNLjAKofnxqE3F-CAKzPrkNak=-ZQP35L-ZE2aTvYz5ORGw@mail.gmail.com>
 <CALLqZ8R8W7XuOprQ6cxjXU2GWy8+1iw6FV-CfhLr5U1rhkmHig@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Tue, 13 Feb 2018 21:55:44 +0530
Message-ID: <CAOuPNLi8m_xtxG0cMWJXZHK0Y533fKKmOd1gbA9t-b7CHm3rUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [rtnet] - help required with rtnet interface bring up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, jan.kiszka@web.de, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Feb 13, 2018 at 8:09 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
> Have you confirmed that the rtnet drivers for your system are loaded?
> Are they built into the kernel or built as modules?
>

Yes, I have enabled RTDM and RTNET in kernel confirm as loadable
module (M), and rent drivers are loaded successfully.
As I said before, all the rtnet modules are visible from lsmod.

Also, as I said rtnet loopback (rtlo) is working fine.
But rteth0 does not come up using rent script.

I even tried forcefully reserving the interface name to (eth0, eth1)
by passing kernel command line argument.
Now the interface name is shown as : eth0, eth1 (instead of enp0*)

But still I am not able to get rteth0, rteth1 interface.

Is there any thing I am missing?

Thanks,
Pintu


> -Greg
>
> On Tue, Feb 13, 2018 at 8:26 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>> Hi,
>>
>> I am expecting some reply again with rtnet setup on ubuntu (virtual
>> box) using version: 4.9.62-pintu-xeno-3.0.6+
>> Note: I am using virtual box for experimental purpose before moving it
>> to the actual hardware
>>
>> I haven't got any reply with my previous query so I am top posting again.
>>
>> I am trying to verify UDP client/server socket communication using
>> rtnet interface.
>> Using loopback (rtlo with local address 127.0.0.1) it is working fine.
>>
>> But, I have no success using the rteth0/1 (actual ip address) interface.
>>
>> In my machine the network interface names are shown like below:
>> 1) enp0s3
>>                  inet addr:10.0.2.15
>> 2) enp0s8
>>                  inet addr:192.168.56.101
>>
>> When I try to start rtnet, I get these errors:
>>
>> $ sudo /usr/xenomai/sbin/rtnet start
>> rteth0: ERROR while getting interface flags: No such device
>> rteth0-mac: ERROR while getting interface flags: No such device
>> ioctl: No such device
>> ioctl: No such device
>> ioctl: No such device
>> ioctl: No such device
>> ioctl (add): No such device
>> ioctl (add): No such device
>> ioctl (add): No such device
>> vnic0: ERROR while getting interface flags: No such device
>> SIOCSIFADDR: No such device
>> vnic0: ERROR while getting interface flags: No such device
>> Waiting for all slaves...ioctl: No such device
>> ioctl: No such device
>>
>> After this I see only rtlo is up, and I could not find rteth* device.
>>
>> 3) rtlo
>>
>> 4) $ sudo /usr/xenomai/sbin/rtifconfig
>>           rtlo      Medium: Local Loopback
>>                      IP address: 127.0.0.1
>>                      UP LOOPBACK RUNNING  MTU: 1500
>>
>>
>> 5) In the rtnet script I tried replacing the eth0 interface with my
>> system interface name, but that also did not help.
>>
>> So, please let me know how to bring up rteth0 interface on my system ?
>>
>>
>> Hope I will get some help this time to proceed.
>> Please help!
>>
>>
>> Thanks,
>> Pintu
>>
>>
>> On Tue, Jan 16, 2018 at 7:06 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>> Ok, I think I found the problem.
>>>
>>>> modprobe: FATAL: Module rttcp not found in directory
>>>
>>> 1)
>>> I think the rttcp module is disabled in the kernel.
>>>
>>> drivers/xenomai/net/stack/ipv4/Kconfig:
>>> # source "drivers/xenomai/net/stack/ipv4/tcp/Kconfig"
>>>
>>> But I wonder, why the rttcp is commented out in the kernel source.
>>> Is there any problem using tcp on xenomai ?
>>>
>>>
>>> 2)  If I remove "tcp" from rtnet.conf and also make RTCAP as "no", I
>>> am able to run the rtnet script.
>>> But, I still get the following errors:
>>>
>>> # sudo /usr/xenomai/sbin/rtnet start
>>> ioctl: No such device
>>> ioctl: No such device
>>> ioctl: No such device
>>> ioctl: No such device
>>> ioctl (add): No such device
>>> ioctl (add): No such device
>>> ioctl (add): No such device
>>> vnic0: ERROR while getting interface flags: No such device
>>> SIOCSIFADDR: No such device
>>> vnic0: ERROR while getting interface flags: No such device
>>> SIOCSIFNETMASK: No such device
>>> Waiting for all slaves...ioctl: No such device
>>> ioctl: No such device
>>>
>>>
>>> However, the rt_ modules are getting installed.
>>>
>>> # lsmod | grep rt
>>> rtmac                   7879  1 tdma
>>> rtcfg                  32455  0
>>> rt_loopback             1143  1
>>> rtpacket                5768  0
>>> rtudp                   9262  0
>>> rt_eepro100            14398  0
>>> rtipv4                 21568  2 rtudp,rtcfg
>>> rtnet                  46929  8
>>> rtipv4,rt_loopback,rtmac,rt_eepro100,rtpacket,rtudp,rtcfg,tdma
>>>
>>>
>>> 3) Another problem is, if I do : ifconfig, I could not find any rtnet0 node.
>>>     Also, if I run: "/usr/xenomai/sbin/rtping 10.0.2.15", I get this:
>>> # sudo /usr/xenomai/sbin/rtping 10.0.2.15
>>> Real-time PING 10.0.2.15 56(84) bytes of data.
>>> ioctl: No route to host
>>>
>>>     So, how can I make sure that rtnet is working ?
>>>
>>>
>>> Thanks,
>>> Pintu
>>>
>>>
>>> On Tue, Jan 16, 2018 at 5:42 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> I have brought up Xenomai 3.0.6 (dual kernel, cobalt) on a
>>>> Ubuntu-32-bit machine with Linux Kernel version 4.9.62.
>>>> # cat /proc/xenomai/version
>>>> 3.0.6
>>>>
>>>> # uname -a
>>>> Linux osboxes 4.9.62-pintu-xeno-3.0.6+ #4 SMP Wed Jan 3 18:54:46 IST
>>>> 2018 i686 i686 i686 GNU/Linux
>>>>
>>>> My Xenomai libraries are installed under:
>>>> # ls /usr/xenomai/
>>>> bin/     demo/    etc/     include/ lib/     sbin/
>>>>
>>>>
>>>> I have verified with sample posix and native application and the
>>>> xenomai is working fine.
>>>>
>>>> -------------------------
>>>> Next, I wanted to check rtdm driver such as RTnet.
>>>> So, I noticed that RTNET module needs to be enabled in my patched kernel 4.9.62.
>>>> So, I enabled it and installed the modules successfully.
>>>>
>>>> I also see that the modules are installed under:
>>>> # ls /lib/modules/4.9.62-pintu-xeno-3.0.6+/kernel/drivers/xenomai/net/drivers/
>>>> e1000/          rt_8139too.ko   rt_eepro100.ko  rt_loopback.ko
>>>>
>>>> # ls /lib/modules/4.9.62-pintu-xeno-3.0.6+/kernel/drivers/xenomai/net/stack/
>>>> ipv4/     packet/   rtcfg/    rtmac/    rtnet.ko
>>>>
>>>>
>>>> So, after that, when I try to install the rtnet driver, I get the
>>>> following error:
>>>> # sudo /usr/xenomai/sbin/rtnet -v start
>>>> Turning on verbose mode
>>>> modprobe: FATAL: Module rttcp not found in directory
>>>> /lib/modules/4.9.62-pintu-xeno-3.0.6+
>>>>
>>>>
>>>> When, I check the config file, the RTNET module path is listed as:
>>>> RTNET_MOD="/lib/modules/`uname -r`/kernel/drivers/xenomai/net"
>>>>
>>>>
>>>> I tried changing it to the correct path by adding xenomai/net/drivers
>>>> or xenomai/net/stack, but still I get the same error.
>>>>
>>>>
>>>> Please let me know how to correctly install the RTNET driver using the
>>>> /usr/xenomai/sbin/rtnet scripts.
>>>>
>>>>
>>>>
>>>> Thanks,
>>>> Pintu
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

