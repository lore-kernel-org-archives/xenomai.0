MIME-Version: 1.0
In-Reply-To: <198d3b6e-f486-51c1-ef0d-c82461e24a4f@web.de>
References: <CAOuPNLjAKofnxqE3F-CAKzPrkNak=-ZQP35L-ZE2aTvYz5ORGw@mail.gmail.com>
 <CALLqZ8R8W7XuOprQ6cxjXU2GWy8+1iw6FV-CfhLr5U1rhkmHig@mail.gmail.com>
 <CAOuPNLi8m_xtxG0cMWJXZHK0Y533fKKmOd1gbA9t-b7CHm3rUQ@mail.gmail.com>
 <CALLqZ8SQp0b6rXxecDaJRqmsCcegUyjzsWjiX28COUrwHY0f1g@mail.gmail.com>
 <CAOuPNLha-XLmhdnp3vcUktrgXOmehMOZNxF72scaiv37xV7-5g@mail.gmail.com>
 <CALLqZ8Tvs8k_356Vcy=FCFBjzu6u3_FfbGEtf_thPKeh_qVMGQ@mail.gmail.com>
 <CAOuPNLhR_na2Kk2U=poywxjAZegR2ahjjQL5HnujEqdq3Z1=kA@mail.gmail.com>
 <486ddc38-4890-0515-0f17-de8d31bbe9fa@web.de>
 <CAOuPNLhqbD=8agrNMPDWFaXKm2RniD_G6FLyNUtC4K9mhPhHRA@mail.gmail.com>
 <198d3b6e-f486-51c1-ef0d-c82461e24a4f@web.de>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 15 Feb 2018 19:28:27 +0530
Message-ID: <CAOuPNLhvY_-_ZDxBXJ2GBdiEB1FtKm6i1jDRK4hhsAEx5kLLLA@mail.gmail.com>
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
To: Jan Kiszka <jan.kiszka@web.de>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Feb 15, 2018 at 12:36 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
> On 2018-02-14 14:52, Pintu Kumar wrote:
>> On Wed, Feb 14, 2018 at 12:15 PM, Jan Kiszka <jan.kiszka@web.de> wrote:
>>> On 2018-02-14 07:42, Pintu Kumar wrote:
>>>> On Tue, Feb 13, 2018 at 11:56 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>> Did you get the output of lspci -knn as Jan suggested?
>>>>>
>>>>
>>>> Here, is the output of lspci:
>>>>
>>>> $ lspci -knn
>>>> 00:00.0 Host bridge [0600]: Intel Corporation 440FX - 82441FX PMC
>>>> [Natoma] [8086:1237] (rev 02)
>>>> 00:01.0 ISA bridge [0601]: Intel Corporation 82371SB PIIX3 ISA
>>>> [Natoma/Triton II] [8086:7000]
>>>> 00:01.1 IDE interface [0101]: Intel Corporation 82371AB/EB/MB PIIX4
>>>> IDE [8086:7111] (rev 01)
>>>>         Kernel driver in use: ata_piix
>>>>         Kernel modules: pata_acpi
>>>> 00:02.0 VGA compatible controller [0300]: InnoTek Systemberatung GmbH
>>>> VirtualBox Graphics Adapter [80ee:beef]
>>>>         Kernel driver in use: vboxvideo
>>>>         Kernel modules: vboxvideo
>>>> 00:03.0 Ethernet controller [0200]: Intel Corporation 82540EM Gigabit
>>>> Ethernet Controller [8086:100e] (rev 02)
>>>>         Subsystem: Intel Corporation PRO/1000 MT Desktop Adapter [8086:001e]
>>>>         Kernel driver in use: e1000
>>>>         Kernel modules: e1000, rt_e1000
>>>> 00:04.0 System peripheral [0880]: InnoTek Systemberatung GmbH
>>>> VirtualBox Guest Service [80ee:cafe]
>>>>         Kernel driver in use: vboxguest
>>>>         Kernel modules: vboxguest
>>>> 00:05.0 Multimedia audio controller [0401]: Intel Corporation 82801AA
>>>> AC'97 Audio Controller [8086:2415] (rev 01)
>>>>         Subsystem: Dell 82801AA AC'97 Audio Controller [1028:0177]
>>>>         Kernel driver in use: snd_intel8x0
>>>>         Kernel modules: snd_intel8x0
>>>> 00:06.0 USB controller [0c03]: Apple Inc. KeyLargo/Intrepid USB [106b:003f]
>>>>         Kernel driver in use: ohci-pci
>>>> 00:07.0 Bridge [0680]: Intel Corporation 82371AB/EB/MB PIIX4 ACPI
>>>> [8086:7113] (rev 08)
>>>>         Kernel driver in use: piix4_smbus
>>>>         Kernel modules: i2c_piix4
>>>> 00:08.0 Ethernet controller [0200]: Intel Corporation 82540EM Gigabit
>>>> Ethernet Controller [8086:100e] (rev 02)
>>>>         Subsystem: Intel Corporation PRO/1000 MT Desktop Adapter [8086:001e]
>>>>         Kernel driver in use: e1000
>>>>         Kernel modules: e1000, rt_e1000
>>>
>>> Perfect. So, rt_e1000 is your driver. Now open /etc/rtnet.conf, read the
>>> comments in there, and adjust it to your system.
>>>
>>
>> Ok thank you so much. I got a clue and something is working now. But
>> still not perfect.
>>
>> I followed the following steps:
>> 1) sudo ifconfig [eth0/eth1] down
>> 2) Remove the existing ethernet driver (e1000) => modprobe -r e1000
>> 3) Changed the rtnet.conf:
>>     RT_DRIVER="rt_e1000"
>> 4) Blank ip address as per comments there => IPADDR=""
>> 5) sudo /usr/xenomai/sbin/rtnet start
>> 6) Got this:
>>     Waiting for all slaves...
>> 7) Pressed ^C to stop
>>
>> 8) Now when I check : ifconfig, I got this:
>>
>> $ ifconfig
>>
>> rteth0    Link encap:Ethernet  HWaddr 08:00:27:52:ba:f1
>>           inet6 addr: fe80::a00:27ff:fe52:baf1/64 Scope:Link
>>           UP BROADCAST RUNNING  MTU:1500  Metric:1
>>           RX packets:1465 errors:0 dropped:1465 overruns:0 frame:0
>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:1000
>>           RX bytes:41332 (41.3 KB)  TX bytes:0 (0.0 B)
>>
>> rteth0-mac Link encap:Ethernet  HWaddr 08:00:27:52:ba:f1
>>           inet6 addr: fe80::a00:27ff:fe52:baf1/64 Scope:Link
>>           UP BROADCAST RUNNING  MTU:1500  Metric:1
>>           RX packets:1465 errors:0 dropped:7 overruns:0 frame:0
>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:1000
>>           RX bytes:41332 (41.3 KB)  TX bytes:0 (0.0 B)
>>
>> rtlo      Link encap:Ethernet  HWaddr 00:00:00:00:00:00
>>           inet6 addr: fe80::200:ff:fe00:0/64 Scope:Link
>>           UP BROADCAST RUNNING  MTU:1500  Metric:1
>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:1000
>>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>>
>> vnic0     Link encap:Ethernet  HWaddr 08:00:27:52:ba:f1
>>           inet6 addr: fe80::a00:27ff:fe52:baf1/64 Scope:Link
>>           UP BROADCAST RUNNING  MTU:1496  Metric:1
>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:7 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:1000
>>           RX bytes:0 (0.0 B)  TX bytes:578 (578.0 B)
>>
>>
>> $ sudo /usr/xenomai/sbin/rtifconfig
>> rteth0    Medium: Ethernet  Hardware address: 08:00:27:52:BA:F1
>>           UP BROADCAST RUNNING  MTU: 1500
>>
>> rtlo      Medium: Local Loopback
>>           IP address: 127.0.0.1
>>           UP LOOPBACK RUNNING  MTU: 1500
>>
>>
>> ----------------------------------------------------------------------------
>> So, I still have the following queries:
>> 1) Why only rteth0 is up, and not eth1 (earlier I have both eth0 and eth1) ?
>>
>
> The startup script only supports one interface. Think of it as a
> template for more complex custom setups. The question you need to answer
> for yourself is then also which of the RTnet features (RTcfg, RTmac,
> TDMA,...) you want and how you'd like to set up the overall network.
>

Ok, I manually enabled rteth1 : # rtifconfig rteth1 up
But still rteth1 is not up.

But the kernel logs says, both eth0 and eth1 is up
[ 2718.418361] e1000: 0000:00:03.0: e1000_probe: (PCI:33MHz:32-bit)
[ 2718.462851] e1000: rteth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[ 2718.787156] e1000: 0000:00:08.0: e1000_probe: (PCI:33MHz:32-bit)
[ 2718.834465] e1000: rteth1: e1000_probe: Intel(R) PRO/1000 Network Connection
[ 2721.212519] e1000: rteth0: e1000_watchdog: NIC Link is Up 1000 Mbps
Full Duplex

>> 2) Why IP address is not shown under rteth0 ?
>>      Earlier, the network was associated with :
>>            eth0 => inet addr:10.0.2.15
>>            eth1 => inet addr:192.168.56.101
>
> Because you didn't set one, as you stated above, and you didn't set up a
> RTcfg master that could hand one out.
>

Ok, I set the ip address of eth0 (10.0.2.15) in the script, but still
IP address is not visible.

$ ifconfig

rteth0    Link encap:Ethernet  HWaddr 08:00:27:52:ba:f1
          inet6 addr: fe80::a00:27ff:fe52:baf1/64 Scope:Link
          UP BROADCAST RUNNING  MTU:1500  Metric:1
          RX packets:96526 errors:0 dropped:96526 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2707980 (2.7 MB)  TX bytes:0 (0.0 B)

vnic0     Link encap:Ethernet  HWaddr 08:00:27:52:ba:f1
          inet addr:10.0.2.15  Bcast:10.255.255.255  Mask:255.0.0.0
          inet6 addr: fe80::a00:27ff:fe52:baf1/64 Scope:Link
          UP BROADCAST RUNNING  MTU:1496  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:57 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:7418 (7.4 KB)

Instead, it showing under vnic0.
But still I could ping: 10.0.2.15
Is this correct behavior ?

However, it is shown under: rtifconfig

$ sudo /usr/xenomai/sbin/rtifconfig
rteth0    Medium: Ethernet  Hardware address: 08:00:27:52:BA:F1
          IP address: 10.0.2.15  Broadcast address: 10.255.255.255
          UP BROADCAST RUNNING  MTU: 1500

rtlo      Medium: Local Loopback
          IP address: 127.0.0.1
          UP LOOPBACK RUNNING  MTU: 1500


>>
>> ---------------------------------------------------------------------------
>>
>> These are the kernel logs during rtnet installation:
>>
>>                *** RTnet for Xenomai v3.0.6 ***
>>
>> [84221.150295] RTnet: initialising real-time networking
>> [84221.202520] Intel(R) PRO/1000 Network Driver - version 7.1.9
>> [84221.202523] Copyright (c) 1999-2006 Intel Corporation.
>> [84221.526522] e1000: 0000:00:03.0: e1000_probe: (PCI:33MHz:32-bit)
>> [84221.526525] 08:
>> [84221.526526] 00:
>> [84221.526528] 27:
>> [84221.526529] 52:
>> [84221.526531] ba:
>> [84221.526533] f1
>> [84221.575234] RTnet: registered rteth0
>> [84221.575237] e1000: rteth0: e1000_probe: Intel(R) PRO/1000 Network Connection
>> [84221.900806] e1000: 0000:00:08.0: e1000_probe: (PCI:33MHz:32-bit)
>> [84221.900810] 08:
>> [84221.900812] 00:
>> [84221.900814] 27:
>> [84221.900816] 19:
>> [84221.900818] 5b:
>> [84221.900819] dc
>> [84221.946479] RTnet: registered rteth1
>> [84221.946482] e1000: rteth1: e1000_probe: Intel(R) PRO/1000 Network Connection
>> [84221.976448] initializing loopback...
>> [84221.976458] RTnet: registered rtlo
>> [84221.982513] RTcap: real-time capturing interface
>> [84222.039892] ModemManager[10059]: segfault at 0 ip 0806f964 sp
>> bfb7bd80 error 4 in ModemManager[8048000+121000]
>> [84222.089678] RTcfg: init real-time configuration distribution protocol
>> [84222.149775] RTmac: init realtime media access control
>> [84222.177704] RTmac/TDMA: init time division multiple access control mechanism
>> [84222.179821] RTcfg: rtcfg_do_main_event() rtdev=1,
>> event=RTCFG_CMD_SERVER, state=RTCFG_MAIN_OFF
>> [84222.179824] RTcfg: next main state=RTCFG_MAIN_SERVER_RUNNING
>> [84224.194058] e1000: rteth0: e1000_watchdog: NIC Link is Up 1000 Mbps
>> Full Duplex
>> [84225.422825] ModemManager[10435]: segfault at 0 ip 0806f964 sp
>> bfb85f40 error 4 in ModemManager[8048000+121000]
>> [84225.434788] RTcfg: rtcfg_do_main_event() rtdev=1,
>> event=RTCFG_CMD_ADD, state=RTCFG_MAIN_SERVER_RUNNING
>> [84225.435376] RTcfg: rtcfg_do_main_event() rtdev=1,
>> event=RTCFG_CMD_ADD, state=RTCFG_MAIN_SERVER_RUNNING
>> [84225.435939] RTcfg: rtcfg_do_main_event() rtdev=1,
>> event=RTCFG_CMD_ADD, state=RTCFG_MAIN_SERVER_RUNNING
>> [84225.438018] RTcfg: rtcfg_do_main_event() rtdev=1,
>> event=RTCFG_CMD_WAIT, state=RTCFG_MAIN_SERVER_RUNNING
>> [84226.179858] RTcfg: error -11 while sending stage 1 frame
>> [84226.179870] RTcfg: error -11 while sending stage 1 frame
>> [84226.179872] RTcfg: error -11 while sending stage 1 frame
>> [84227.179861] RTcfg: error -11 while sending stage 1 frame
>> [84227.179877] RTcfg: error -11 while sending stage 1 frame
>> [84227.179879] RTcfg: error -11 while sending stage 1 frame
>> [84228.180889] RTcfg: error -11 while sending stage 1 frame
>> .......
>> .......
>>
>> These error is flowing continuously in the kernel logs. What does this
>> indicates ?
>>
>
> The error may indicate that packet transmission via rteth0 is not
> working properly. Maybe the rtnet driver is not fully supporting that
> NIC, or interrupts do not arrive for the NIC (check /proc/xenomai/irqs),
> or you simply lack a (virtual) link on that interface.
>

Here is the output of /proc/xenomai/irq

$ cat /proc/xenomai/irq
  IRQ         CPU0        CPU1
   19:           0       39710         rteth0
 2304:           0           0         [sync]
 2305:           3           5         [reschedule]
 2306:      207869      151958         [timer/0]
 2307:           2           0         [timer-ipi]
 2339:          12           8         [virtual]


With this error, I cannot proceed further to measure latency over rtnet.
How to resolve this error ?
Is there any work around ?


> Jan
>

