Date: Wed, 13 Mar 2019 03:53:09 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <544217707.857557.1552467189711.JavaMail.zimbra@wolfram.com>
In-Reply-To: <731343616.4059321.1550495335135.JavaMail.zimbra@wolfram.com>
References: <1798013633.4056474.1550493375498.JavaMail.zimbra@wolfram.com>
 <f51b37b7-4293-4b29-6d78-3eb460de3015@siemens.com>
 <731343616.4059321.1550495335135.JavaMail.zimbra@wolfram.com>
Subject: Re: Cyclic hardware reset for e1000e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>


Please visit us at: [ http://www.wolframmathcore.com/ | wolframmathcore.com=
 ] or [ http://www.wolfram.com/ | wolfram.com ]

----- Den 18 feb 2019, p=C3=A5 kl 14:08, Per =C3=96berg pero@wolfram.com sk=
rev:

> ----- Den 18 feb 2019, p=C3=A5 kl 13:43, Jan Kiszka jan.kiszka@siemens.co=
m skrev:

> > On 18.02.19 13:36, Per Oberg via Xenomai wrote:
> > > Hello list

> >> I have this issue where my e1000e network card gets into some kind of =
cyclic
> >> hardware reset during operation. The weird thing is that this only hap=
pens when
> >> I let systemd start the application. If it's started manually it alway=
s works
> > > as intended.

> >> I am running xenomai 3.0.7 with a linux-4.9.38 kernel and I use the ne=
twork
> > > connection in Linux non-rt mode. I use systemd and NetworkManager.

> >> I do realize that once I get into the reset it will continue resetting=
 because I
> >> keep flooding the buffers. My issue is that it -never- happens when I =
start my
> >> process manually, only when systemd starts it. Because the network goe=
s down
> >> quite badly I cannot log in and disable the service once it happens an=
d
> >> therefore I cannot really try starting it manually after letting the n=
etwork
> > > recover.

> >> There is some information from intel in [1] below. There is talk about=
 power
> > > management function and EPROM etc. They specifically write:

> > > "82573(V/L/E) TX Unit Hang Messages
> >> Several adapters with the 82573 chipset display "TX unit hang" message=
s during
> >> normal operation with the e1000 driver. The issue appears both with TS=
O enabled
> >> and disabled, and is caused by a power management function that is ena=
bled in
> >> the EEPROM. Early releases of the chipsets to vendors had the EEPROM b=
it that
> >> enabled the feature. After the issue was discovered newer adapters wer=
e
> > > released with the feature disabled in the EEPROM."

> > > I also read something about disabling GRO/TSO/GSO that helped some pe=
ople.

> > > My questions to the list are:

> > > 1. Have you guys any experience with this?
> > > 2. Would I be better of using the RT Net drivers?
> >> 3. What could cause the issue to trigger only when run by systemd. (I =
thought
> > > about timing issues and NetworkManager, but how do I debug this?)

> >> [1]
> > > https://serverfault.com/questions/193114/linux-e1000e-intel-networkin=
g-driver-problems-galore-where-do-i-start

> > > Thoughts anyone?

> > Are you giving Linux enough time to work (no 100% RT domination of any =
core for
> > hundreds of milliseconds or longer)?

> I am not sure, yet. I have this logging function for reporting back to me=
 when I
> loose samples. Loosing samples would currently make the software try to c=
atch
> up and this would mean 100% cpu till it does. I do see this being logged =
around
> the time it resets but I'm not sure if it's much worse than "usual". If f=
or
> some reason the hardware reset happens because linux gets starved I can e=
asily
> see this going cyclic.

> Per =C3=96berg

So, I have managed to do some checking

It looks like the cyclic resets are about 80-100 seconds apart.=20
Before the first reset we are most likely holding the CPUs for about 3-4ms.

I managed to get hold of a kernel message saying:=20
[...] WARNING: CPU: 0 PID: 3 at net/sched/sch_generic.c:316 dev_watchdog+0x=
215/0x220
[...] NETDEV WATCHDOG: enp0s31f6 (e1000e): transmit queue 0 timed out

The full trace is shown below.

One difference that I have found is that I am running with "--cpu-affinity=
=3D2,3" when running manually, but not when using systemd to start the prog=
ram. Can this have an impact?


--------------------  DMESG TRACE -----------------------------------------

[31865.706967] ------------[ cut here ]------------
[31865.706973] WARNING: CPU: 0 PID: 3 at net/sched/sch_generic.c:316 dev_wa=
tchdog+0x215/0x220
[31865.706974] NETDEV WATCHDOG: enp0s31f6 (e1000e): transmit queue 0 timed =
out
[31865.706974] Modules linked in: iTCO_wdt iTCO_vendor_support ppdev i915 i=
ntel_rapl intel_powerclamp coretemp kvm_intel kvm drm_kms_helper irqbypass =
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel drm intel_gt=
t aesni_intel agpgart aes_x86_64 fb_sys_fops lrw gf128mul glue_helper e1000=
e ablk_helper syscopyarea cryptd sysfillrect sysimgblt efi_pstore igb xhci_=
pci psmouse xhci_hcd dca pcspkr i2c_algo_bit serio_raw ptp efivars pps_core=
 xeno_can_peak_pci xeno_can_sja1000 xeno_can i2c_i801 shpchp i2c_smbus hci_=
uart btbcm btintel bluetooth parport_pc parport pinctrl_sunrisepoint pinctr=
l_intel i2c_hid tpm_tis tpm_tis_core tpm sch_fq_codel efivarfs ipv6 crc_cci=
tt
[31865.707329] CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted 4.9.38-xenomai+ =
#6
[31865.707330] Hardware name: Default string Default string/SKYBAY, BIOS 5.=
11 09/22/2016
[31865.707331] I-pipe domain: Linux
[31865.707333]  ffffc90000033c80 ffffffff813e0324 ffffc90000033cd0 00000000=
00000000
[31865.707336]  ffffc90000033cc0 ffffffff81054b67 0000013c6dc2eb00 00000000=
00000000
[31865.707517]  ffff88026048fc80 0000000000000000 ffff88025ed74000 00000000=
00000001
[31865.707520] Call Trace:
[31865.707524]  [<ffffffff813e0324>] dump_stack+0x96/0xc2
[31865.707526]  [<ffffffff81054b67>] __warn+0xc7/0xf0
[31865.707527]  [<ffffffff81054bda>] warn_slowpath_fmt+0x4a/0x50
[31865.707529]  [<ffffffff81a04be0>] ? dev_graft_qdisc+0x70/0x70
[31865.707568]  [<ffffffff81a04df5>] dev_watchdog+0x215/0x220
[31865.707569]  [<ffffffff81a04be0>] ? dev_graft_qdisc+0x70/0x70
[31865.707571]  [<ffffffff81a04be0>] ? dev_graft_qdisc+0x70/0x70
[31865.707573]  [<ffffffff810a6d47>] call_timer_fn.isra.25+0x17/0x70
[31865.707575]  [<ffffffff810a6e47>] expire_timers+0xa7/0xd0
[31865.707576]  [<ffffffff810a6eec>] run_timer_softirq+0x7c/0x160
[31865.707578]  [<ffffffff81aae546>] ? _raw_spin_unlock_irq+0x16/0x30
[31865.707581]  [<ffffffff810595b6>] __do_softirq+0xe6/0x1e0
[31865.707583]  [<ffffffff810596e2>] run_ksoftirqd+0x32/0x40
[31865.707584]  [<ffffffff81073ff5>] smpboot_thread_fn+0x165/0x230
[31865.707611]  [<ffffffff81073e90>] ? sort_range+0x20/0x20
[31865.707827]  [<ffffffff81070962>] kthread+0xd2/0xf0
[31865.707829]  [<ffffffff81070890>] ? kthread_park+0x60/0x60
[31865.707831]  [<ffffffff81aaed33>] ret_from_fork+0x23/0x30
[31865.707834] ---[ end trace 111a72a07d1d2f26 ]---
[31865.743096] e1000e 0000:00:1f.6 enp0s31f6: Reset adapter unexpectedly
[31867.827820] e1000e: enp0s31f6 NIC Link is Up 100 Mbps Full Duplex, Flow =
Control: Rx/Tx




Per =C3=96berg=20

