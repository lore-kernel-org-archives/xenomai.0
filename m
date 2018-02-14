MIME-Version: 1.0
In-Reply-To: <CALLqZ8Tvs8k_356Vcy=FCFBjzu6u3_FfbGEtf_thPKeh_qVMGQ@mail.gmail.com>
References: <CAOuPNLjAKofnxqE3F-CAKzPrkNak=-ZQP35L-ZE2aTvYz5ORGw@mail.gmail.com>
 <CALLqZ8R8W7XuOprQ6cxjXU2GWy8+1iw6FV-CfhLr5U1rhkmHig@mail.gmail.com>
 <CAOuPNLi8m_xtxG0cMWJXZHK0Y533fKKmOd1gbA9t-b7CHm3rUQ@mail.gmail.com>
 <CALLqZ8SQp0b6rXxecDaJRqmsCcegUyjzsWjiX28COUrwHY0f1g@mail.gmail.com>
 <CAOuPNLha-XLmhdnp3vcUktrgXOmehMOZNxF72scaiv37xV7-5g@mail.gmail.com>
 <CALLqZ8Tvs8k_356Vcy=FCFBjzu6u3_FfbGEtf_thPKeh_qVMGQ@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 14 Feb 2018 12:12:24 +0530
Message-ID: <CAOuPNLhR_na2Kk2U=poywxjAZegR2ahjjQL5HnujEqdq3Z1=kA@mail.gmail.com>
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

On Tue, Feb 13, 2018 at 11:56 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
> Did you get the output of lspci -knn as Jan suggested?
>

Here, is the output of lspci:

$ lspci -knn
00:00.0 Host bridge [0600]: Intel Corporation 440FX - 82441FX PMC
[Natoma] [8086:1237] (rev 02)
00:01.0 ISA bridge [0601]: Intel Corporation 82371SB PIIX3 ISA
[Natoma/Triton II] [8086:7000]
00:01.1 IDE interface [0101]: Intel Corporation 82371AB/EB/MB PIIX4
IDE [8086:7111] (rev 01)
        Kernel driver in use: ata_piix
        Kernel modules: pata_acpi
00:02.0 VGA compatible controller [0300]: InnoTek Systemberatung GmbH
VirtualBox Graphics Adapter [80ee:beef]
        Kernel driver in use: vboxvideo
        Kernel modules: vboxvideo
00:03.0 Ethernet controller [0200]: Intel Corporation 82540EM Gigabit
Ethernet Controller [8086:100e] (rev 02)
        Subsystem: Intel Corporation PRO/1000 MT Desktop Adapter [8086:001e]
        Kernel driver in use: e1000
        Kernel modules: e1000, rt_e1000
00:04.0 System peripheral [0880]: InnoTek Systemberatung GmbH
VirtualBox Guest Service [80ee:cafe]
        Kernel driver in use: vboxguest
        Kernel modules: vboxguest
00:05.0 Multimedia audio controller [0401]: Intel Corporation 82801AA
AC'97 Audio Controller [8086:2415] (rev 01)
        Subsystem: Dell 82801AA AC'97 Audio Controller [1028:0177]
        Kernel driver in use: snd_intel8x0
        Kernel modules: snd_intel8x0
00:06.0 USB controller [0c03]: Apple Inc. KeyLargo/Intrepid USB [106b:003f]
        Kernel driver in use: ohci-pci
00:07.0 Bridge [0680]: Intel Corporation 82371AB/EB/MB PIIX4 ACPI
[8086:7113] (rev 08)
        Kernel driver in use: piix4_smbus
        Kernel modules: i2c_piix4
00:08.0 Ethernet controller [0200]: Intel Corporation 82540EM Gigabit
Ethernet Controller [8086:100e] (rev 02)
        Subsystem: Intel Corporation PRO/1000 MT Desktop Adapter [8086:001e]
        Kernel driver in use: e1000
        Kernel modules: e1000, rt_e1000
00:0d.0 SATA controller [0106]: Intel Corporation 82801HM/HEM
(ICH8M/ICH8M-E) SATA Controller [AHCI mode] [8086:2829] (rev 02)
        Kernel driver in use: ahci
        Kernel modules: ahci


--------------------------------------
And here the output of lsmod (with rt driver):

$ lsmod
Module                  Size  Used by
tdma                   17488  0
rtmac                   7879  1 tdma
rtcfg                  38752  0
rtcap                   5397  1
rt_loopback             1143  1
rtpacket                5768  0
rtudp                   9262  0
rt_eepro100            14398  0
rtipv4                 21568  2 rtudp,rtcfg
vboxsf                 37824  0
crc32_pclmul            2524  0
aesni_intel            10524  0
aes_i586                7361  1 aesni_intel
lrw                     3595  1 aesni_intel
ablk_helper             2332  1 aesni_intel
cryptd                  9091  1 ablk_helper
snd_intel8x0           27580  2
intel_rapl_perf         6346  0
joydev                  8304  0
snd_ac97_codec         98669  1 snd_intel8x0
vboxvideo              36081  2
ac97_bus                1420  1 snd_ac97_codec
snd_pcm                82522  2 snd_ac97_codec,snd_intel8x0
ttm                    77681  1 vboxvideo
snd_seq_midi            5325  0
snd_seq_midi_event      5600  1 snd_seq_midi
drm_kms_helper        127184  1 vboxvideo
rt_e1000               86133  0
snd_rawmidi            19353  1 snd_seq_midi
drm                   280276  5 vboxvideo,ttm,drm_kms_helper
snd_seq                47392  2 snd_seq_midi_event,snd_seq_midi
input_leds              2566  0
snd_seq_device          3485  3 snd_seq,snd_rawmidi,snd_seq_midi
snd_timer              19107  2 snd_seq,snd_pcm
snd                    56488  11
snd_seq,snd_ac97_codec,snd_timer,snd_rawmidi,snd_intel8x0,snd_seq_device,snd_pcm
rtnet                  47695  10
rtipv4,rt_loopback,rtmac,rt_eepro100,rtpacket,rtcap,rtudp,rt_e1000,rtcfg,tdma
serio_raw               4826  0
vboxguest             225520  6 vboxsf,vboxvideo
soundcore               5748  1 snd
fb_sys_fops             1282  1 drm_kms_helper
syscopyarea             2970  2 vboxvideo,drm_kms_helper
sysfillrect             3238  2 vboxvideo,drm_kms_helper
sysimgblt               2288  2 vboxvideo,drm_kms_helper
mac_hid                 3151  0
i2c_piix4              12723  0
parport_pc             25458  0
ppdev                   7997  0
lp                      7603  0
parport                33603  3 lp,parport_pc,ppdev
autofs4                30618  2
hid_generic             1047  0
usbhid                 42466  0
hid                    88853  2 hid_generic,usbhid
psmouse               116445  0
fjes                   20052  0
ahci                   25179  4
video                  29958  0
libahci                22550  1 ahci
e1000                 118843  0
pata_acpi               2853  0


-------------------------------------------------------------------

Here, is the log for network driver:

$ dmesg | grep e1000
[    5.189127] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    5.189129] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    5.579357] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 08:00:27:52:ba:f1
[    5.579363] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    5.946696] e1000 0000:00:08.0 eth1: (PCI:33MHz:32-bit) 08:00:27:19:5b:dc
[    5.946700] e1000 0000:00:08.0 eth1: Intel(R) PRO/1000 Network Connection
[   47.256361] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: RX
[   48.796221] e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: RX


> What I'm getting at is if the native Linux driver is loaded and bound
> to the ethernet interface, then the Xenomai driver won't be able to
> load.  You'll need to check what driver current is loaded and bound to
> the pci interface for you network card. The native driver needs to be
> unbound then the Xenomai driver can load and bind properly.

You mean to say that I need to first disable/unload the e1000 driver
(non real time)  from kernel, and then start the rtnet so that
rt_e1000 driver should be loaded to expose the rteth0 interfaces ?

I could not find the write process in the RTNET xenomai documentation.
So, could be explain the basic steps in an easy way.
I think this is going to be useful for many other people here as well.


Thanks,
Pintu


> -Greg
>
> On Tue, Feb 13, 2018 at 1:10 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>> On Tue, Feb 13, 2018 at 10:29 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>> I'll defer to someone with more experience with RTNet, but I'd confirm
>>> that you have the correct drivers loaded, and that you don't see any
>>> errors in the kernel log.  Are the non-realtime drivers loaded?
>>>
>>
>> Yes, all driver modules are loaded I guess.
>> If you are pointing to any thing specific please let me know.
>>
>>
>>> -Greg
>>>
>>> On Tue, Feb 13, 2018 at 11:25 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>>> On Tue, Feb 13, 2018 at 8:09 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>> Have you confirmed that the rtnet drivers for your system are loaded?
>>>>> Are they built into the kernel or built as modules?
>>>>>
>>>>
>>>> Yes, I have enabled RTDM and RTNET in kernel confirm as loadable
>>>> module (M), and rent drivers are loaded successfully.
>>>> As I said before, all the rtnet modules are visible from lsmod.
>>>>
>>>> Also, as I said rtnet loopback (rtlo) is working fine.
>>>> But rteth0 does not come up using rent script.
>>>>
>>>> I even tried forcefully reserving the interface name to (eth0, eth1)
>>>> by passing kernel command line argument.
>>>> Now the interface name is shown as : eth0, eth1 (instead of enp0*)
>>>>
>>>> But still I am not able to get rteth0, rteth1 interface.
>>>>
>>>> Is there any thing I am missing?
>>>>
>>>> Thanks,
>>>> Pintu
>>>>
>>>>
>>>>> -Greg
>>>>>
>>>>> On Tue, Feb 13, 2018 at 8:26 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I am expecting some reply again with rtnet setup on ubuntu (virtual
>>>>>> box) using version: 4.9.62-pintu-xeno-3.0.6+
>>>>>> Note: I am using virtual box for experimental purpose before moving it
>>>>>> to the actual hardware
>>>>>>
>>>>>> I haven't got any reply with my previous query so I am top posting again.
>>>>>>
>>>>>> I am trying to verify UDP client/server socket communication using
>>>>>> rtnet interface.
>>>>>> Using loopback (rtlo with local address 127.0.0.1) it is working fine.
>>>>>>
>>>>>> But, I have no success using the rteth0/1 (actual ip address) interface.
>>>>>>
>>>>>> In my machine the network interface names are shown like below:
>>>>>> 1) enp0s3
>>>>>>                  inet addr:10.0.2.15
>>>>>> 2) enp0s8
>>>>>>                  inet addr:192.168.56.101
>>>>>>
>>>>>> When I try to start rtnet, I get these errors:
>>>>>>
>>>>>> $ sudo /usr/xenomai/sbin/rtnet start
>>>>>> rteth0: ERROR while getting interface flags: No such device
>>>>>> rteth0-mac: ERROR while getting interface flags: No such device
>>>>>> ioctl: No such device
>>>>>> ioctl: No such device
>>>>>> ioctl: No such device
>>>>>> ioctl: No such device
>>>>>> ioctl (add): No such device
>>>>>> ioctl (add): No such device
>>>>>> ioctl (add): No such device
>>>>>> vnic0: ERROR while getting interface flags: No such device
>>>>>> SIOCSIFADDR: No such device
>>>>>> vnic0: ERROR while getting interface flags: No such device
>>>>>> Waiting for all slaves...ioctl: No such device
>>>>>> ioctl: No such device
>>>>>>
>>>>>> After this I see only rtlo is up, and I could not find rteth* device.
>>>>>>
>>>>>> 3) rtlo
>>>>>>
>>>>>> 4) $ sudo /usr/xenomai/sbin/rtifconfig
>>>>>>           rtlo      Medium: Local Loopback
>>>>>>                      IP address: 127.0.0.1
>>>>>>                      UP LOOPBACK RUNNING  MTU: 1500
>>>>>>
>>>>>>
>>>>>> 5) In the rtnet script I tried replacing the eth0 interface with my
>>>>>> system interface name, but that also did not help.
>>>>>>
>>>>>> So, please let me know how to bring up rteth0 interface on my system ?
>>>>>>
>>>>>>
>>>>>> Hope I will get some help this time to proceed.
>>>>>> Please help!
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Pintu
>>>>>>
>>>>>>
>>>>>> On Tue, Jan 16, 2018 at 7:06 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>>>>>> Ok, I think I found the problem.
>>>>>>>
>>>>>>>> modprobe: FATAL: Module rttcp not found in directory
>>>>>>>
>>>>>>> 1)
>>>>>>> I think the rttcp module is disabled in the kernel.
>>>>>>>
>>>>>>> drivers/xenomai/net/stack/ipv4/Kconfig:
>>>>>>> # source "drivers/xenomai/net/stack/ipv4/tcp/Kconfig"
>>>>>>>
>>>>>>> But I wonder, why the rttcp is commented out in the kernel source.
>>>>>>> Is there any problem using tcp on xenomai ?
>>>>>>>
>>>>>>>
>>>>>>> 2)  If I remove "tcp" from rtnet.conf and also make RTCAP as "no", I
>>>>>>> am able to run the rtnet script.
>>>>>>> But, I still get the following errors:
>>>>>>>
>>>>>>> # sudo /usr/xenomai/sbin/rtnet start
>>>>>>> ioctl: No such device
>>>>>>> ioctl: No such device
>>>>>>> ioctl: No such device
>>>>>>> ioctl: No such device
>>>>>>> ioctl (add): No such device
>>>>>>> ioctl (add): No such device
>>>>>>> ioctl (add): No such device
>>>>>>> vnic0: ERROR while getting interface flags: No such device
>>>>>>> SIOCSIFADDR: No such device
>>>>>>> vnic0: ERROR while getting interface flags: No such device
>>>>>>> SIOCSIFNETMASK: No such device
>>>>>>> Waiting for all slaves...ioctl: No such device
>>>>>>> ioctl: No such device
>>>>>>>
>>>>>>>
>>>>>>> However, the rt_ modules are getting installed.
>>>>>>>
>>>>>>> # lsmod | grep rt
>>>>>>> rtmac                   7879  1 tdma
>>>>>>> rtcfg                  32455  0
>>>>>>> rt_loopback             1143  1
>>>>>>> rtpacket                5768  0
>>>>>>> rtudp                   9262  0
>>>>>>> rt_eepro100            14398  0
>>>>>>> rtipv4                 21568  2 rtudp,rtcfg
>>>>>>> rtnet                  46929  8
>>>>>>> rtipv4,rt_loopback,rtmac,rt_eepro100,rtpacket,rtudp,rtcfg,tdma
>>>>>>>
>>>>>>>
>>>>>>> 3) Another problem is, if I do : ifconfig, I could not find any rtnet0 node.
>>>>>>>     Also, if I run: "/usr/xenomai/sbin/rtping 10.0.2.15", I get this:
>>>>>>> # sudo /usr/xenomai/sbin/rtping 10.0.2.15
>>>>>>> Real-time PING 10.0.2.15 56(84) bytes of data.
>>>>>>> ioctl: No route to host
>>>>>>>
>>>>>>>     So, how can I make sure that rtnet is working ?
>>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Pintu
>>>>>>>
>>>>>>>
>>>>>>> On Tue, Jan 16, 2018 at 5:42 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I have brought up Xenomai 3.0.6 (dual kernel, cobalt) on a
>>>>>>>> Ubuntu-32-bit machine with Linux Kernel version 4.9.62.
>>>>>>>> # cat /proc/xenomai/version
>>>>>>>> 3.0.6
>>>>>>>>
>>>>>>>> # uname -a
>>>>>>>> Linux osboxes 4.9.62-pintu-xeno-3.0.6+ #4 SMP Wed Jan 3 18:54:46 IST
>>>>>>>> 2018 i686 i686 i686 GNU/Linux
>>>>>>>>
>>>>>>>> My Xenomai libraries are installed under:
>>>>>>>> # ls /usr/xenomai/
>>>>>>>> bin/     demo/    etc/     include/ lib/     sbin/
>>>>>>>>
>>>>>>>>
>>>>>>>> I have verified with sample posix and native application and the
>>>>>>>> xenomai is working fine.
>>>>>>>>
>>>>>>>> -------------------------
>>>>>>>> Next, I wanted to check rtdm driver such as RTnet.
>>>>>>>> So, I noticed that RTNET module needs to be enabled in my patched kernel 4.9.62.
>>>>>>>> So, I enabled it and installed the modules successfully.
>>>>>>>>
>>>>>>>> I also see that the modules are installed under:
>>>>>>>> # ls /lib/modules/4.9.62-pintu-xeno-3.0.6+/kernel/drivers/xenomai/net/drivers/
>>>>>>>> e1000/          rt_8139too.ko   rt_eepro100.ko  rt_loopback.ko
>>>>>>>>
>>>>>>>> # ls /lib/modules/4.9.62-pintu-xeno-3.0.6+/kernel/drivers/xenomai/net/stack/
>>>>>>>> ipv4/     packet/   rtcfg/    rtmac/    rtnet.ko
>>>>>>>>
>>>>>>>>
>>>>>>>> So, after that, when I try to install the rtnet driver, I get the
>>>>>>>> following error:
>>>>>>>> # sudo /usr/xenomai/sbin/rtnet -v start
>>>>>>>> Turning on verbose mode
>>>>>>>> modprobe: FATAL: Module rttcp not found in directory
>>>>>>>> /lib/modules/4.9.62-pintu-xeno-3.0.6+
>>>>>>>>
>>>>>>>>
>>>>>>>> When, I check the config file, the RTNET module path is listed as:
>>>>>>>> RTNET_MOD="/lib/modules/`uname -r`/kernel/drivers/xenomai/net"
>>>>>>>>
>>>>>>>>
>>>>>>>> I tried changing it to the correct path by adding xenomai/net/drivers
>>>>>>>> or xenomai/net/stack, but still I get the same error.
>>>>>>>>
>>>>>>>>
>>>>>>>> Please let me know how to correctly install the RTNET driver using the
>>>>>>>> /usr/xenomai/sbin/rtnet scripts.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Pintu
>>>>>>
>>>>>> _______________________________________________
>>>>>> Xenomai mailing list
>>>>>> Xenomai@xenomai.org
>>>>>> https://xenomai.org/mailman/listinfo/xenomai

