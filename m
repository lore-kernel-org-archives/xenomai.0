MIME-Version: 1.0
References: <d53140e58f60459694e2e66a94d0a518@systemceramics.com>
 <CAPR3TAhurhcwOGe9wfnOTUd=VBRvXuMLxZtNZ-3+QNyd=TOJnA@mail.gmail.com>
 <ebec2dcf-9549-fed2-6a48-299597bc7079@siemens.com>
 <CAPR3TAjFNV-0LgZ=+ydtseAQw-jdmYRHO4FQwybTjAHwDV59Xg@mail.gmail.com>
 <CAPR3TAhP1VwSE5OjKiznfuzsRXyigeN+ohQP1jQE-roLDMh5LA@mail.gmail.com>
 <32be3d2e-020f-468c-2940-26a09e96daeb@siemens.com>
 <CAPR3TAitTeY0rNVZ6v0moFzh0d_hA6zyS-R3fm+DK+HX4yj3PQ@mail.gmail.com>
 <04ffd701-4df7-5a2b-8000-cf5bec9d06d7@siemens.com>
In-Reply-To: <04ffd701-4df7-5a2b-8000-cf5bec9d06d7@siemens.com>
From: cagnulein <cagnulein@gmail.com>
Date: Thu, 21 Mar 2019 08:04:39 +0100
Message-ID: <CAPR3TAg=5on1=gJHSChHHwAb3AafZNx3jizMerdZvYKnN5YObA@mail.gmail.com>
Subject: Re: kvm fpu warning on 4.14.89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

I've got a similar issue even with the 4.9.146 with a kvm guest on and
latency on too. It's quite deterministic. Any idea?

[ 2071.952650] ------------[ cut here ]------------

[ 2071.952657] WARNING: CPU: 0 PID: 0 at
./arch/x86/include/asm/fpu/internal.h:674 __kernel_fpu_end+0x116/0x120

[ 2071.952659] Modules linked in: tun bridge stp llc
i2c_designware_platform i2c_designware_core nls_ascii nls_cp437 vfat fat
intel_rapl x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel joydev rt_igb aesni_intel
aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd rtnet
intel_rapl_perf pcspkr evdev i915 video mei_me idma64 shpchp mei
intel_lpss_pci intel_lpss mfd_core netconsole configfs ip_tables x_tables
autofs4 ext4 crc16 jbd2 fscrypto mbcache btrfs xor hid_generic usbhid hid
raid6_pq qxl bochs_drm drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops ttm drm mmc_block crc32c_intel igb i2c_algo_bit i2c_i801
i2c_smbus dca ptp sdhci_pci pps_core sdhci mmc_core xhci_pci xhci_hcd
usbcore

[ 2071.952787] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.146 #10

[ 2071.952788] I-pipe domain: Xenomai

[ 2071.952790]  0000000000000000 ffffffff99142263 0000000000000000
0000000000000000

[ 2071.952797]  ffffffff995bce48 ffffffff98e65a1b 0000000000000046
ffff8f73b9e10a40

[ 2071.952804]  0000000000000086 0000000010000000 0000000000000001
ffffb607007d0840

[ 2071.952811] Call Trace:

[ 2071.952813]  [<ffffffff99142263>] ? dump_stack+0xb5/0xd2

[ 2071.952815]  [<ffffffff98e65a1b>] ? __warn+0xcb/0xf0

[ 2071.952816]  [<ffffffff98e228c6>] ? __kernel_fpu_end+0x116/0x120

[ 2071.952818]  [<ffffffffc092fd68>] ?
__vmx_load_host_state.part.92+0xe8/0x1a0 [kvm_intel]

[ 2071.952820]  [<ffffffffc07c83dd>] ?
kvm_put_guest_fpu.part.175+0x4d/0x100 [kvm]

[ 2071.952821]  [<ffffffffc07ce8a5>] ? kvm_arch_vcpu_put+0x95/0xa0 [kvm]

[ 2071.952823]  [<ffffffffc07ce8da>] ?
__ipipe_handle_vm_preemption+0x2a/0x50 [kvm]

[ 2071.952825]  [<ffffffff98f77219>] ? ___xnsched_run.part.71+0x3d9/0x510

[ 2071.952827]  [<ffffffff98faba66>] ? timerfd_handler+0x36/0x50

[ 2071.952828]  [<ffffffff98f80dc5>] ? xntimerq_insert+0x5/0xa0

[ 2071.952830]  [<ffffffff98f6fe89>] ? xnintr_core_clock_handler+0x389/0x39=
0

[ 2071.952832]  [<ffffffff98f80a45>] ? xntimer_heading_p+0x5/0x60

[ 2071.952833]  [<ffffffff98f1bbf8>] ? dispatch_irq_head+0x88/0x110

[ 2071.952835]  [<ffffffff98e39e24>] ? __ipipe_handle_irq+0x64/0x1a0

[ 2071.952837]  [<ffffffff993e99a9>] ? apic_timer_interrupt+0x89/0xb0

[ 2071.952838]  [<ffffffff98e39b99>] ? __ipipe_halt_root+0x29/0x40

[ 2071.952840]  [<ffffffff993e6ed1>] ? default_idle+0x21/0x100

[ 2071.952842]  [<ffffffff993e72cd>] ? default_idle_call+0x2d/0x32

[ 2071.952843]  [<ffffffff98ea9208>] ? cpu_startup_entry+0x108/0x1c0

[ 2071.952845]  [<ffffffff999a8f5f>] ? start_kernel+0x472/0x492

[ 2071.952847] ---[ end trace 68e4b63403285e43 ]---

[ 2071.967775] ------------[ cut here ]------------

[ 2071.967780] WARNING: CPU: 1 PID: 727 at
./arch/x86/include/asm/fpu/internal.h:668 __kernel_fpu_begin+0x12a/0x150

[ 2071.967782] Modules linked in: tun bridge stp llc
i2c_designware_platform i2c_designware_core nls_ascii nls_cp437 vfat fat
intel_rapl x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel joydev rt_igb aesni_intel
aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd rtnet
intel_rapl_perf pcspkr evdev i915 video mei_me idma64 shpchp mei
intel_lpss_pci intel_lpss mfd_core netconsole configfs ip_tables x_tables
autofs4 ext4 crc16 jbd2 fscrypto mbcache btrfs xor hid_generic usbhid hid
raid6_pq qxl bochs_drm drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops ttm drm mmc_block crc32c_intel igb i2c_algo_bit i2c_i801
i2c_smbus dca ptp sdhci_pci pps_core sdhci mmc_core xhci_pci xhci_hcd
usbcore

[ 2071.967893] CPU: 1 PID: 727 Comm: qemu-system-x86 Tainted: G
W       4.9.146 #10

[ 2071.967895] I-pipe domain: Linux

[ 2071.967896]  0000000000000000 ffffffff99142263 0000000000000000
0000000000000000

[ 2071.967904]  ffffffff995bce48 ffffffff98e65a1b ffff8f73b9e08000
0000000000000046

[ 2071.967910]  0000000000000000 0000000000000000 ffff8f73b9e10000
ffff8f73b673c048

[ 2071.967917] Call Trace:

[ 2071.967919]  [<ffffffff99142263>] ? dump_stack+0xb5/0xd2

[ 2071.967921]  [<ffffffff98e65a1b>] ? __warn+0xcb/0xf0

[ 2071.967923]  [<ffffffff98e2208a>] ? __kernel_fpu_begin+0x12a/0x150

[ 2071.967924]  [<ffffffffc07c9058>] ?
kvm_load_guest_fpu.part.174+0x18/0x100 [kvm]

[ 2071.967926]  [<ffffffffc07d5a56>] ?
kvm_arch_vcpu_ioctl_run+0x1506/0x1a20 [kvm]

[ 2071.967928]  [<ffffffffc07ce5e1>] ? kvm_arch_vcpu_load+0x61/0x290 [kvm]

[ 2071.967929]  [<ffffffffc07b9885>] ? kvm_vcpu_ioctl+0x315/0x5f0 [kvm]

[ 2071.967931]  [<ffffffff98e919d0>] ? wake_up_q+0x70/0x70

[ 2071.967933]  [<ffffffff9902d2d2>] ? do_vfs_ioctl+0xa2/0x620

[ 2071.967934]  [<ffffffff9902d8c4>] ? SyS_ioctl+0x74/0x80

[ 2071.967936]  [<ffffffff98e02c62>] ? do_syscall_64+0x82/0xf0

[ 2071.967938]  [<ffffffff993e7abe>] ?
entry_SYSCALL_64_after_swapgs+0x58/0xc6

[ 2071.967939] ---[ end trace 68e4b63403285e44 ]---

Il lun 11 mar 2019, 20:39 Jan Kiszka <jan.kiszka@siemens.com> ha scritto:

> On 11.03.19 15:36, cagnulein wrote:
> > Hi Jan, did you get any chance to look at my issue?
>
> Not yet, sorry. I hope I can do some Xenomai stuff tomorrow, including at
> least
> a reproduction of this issue.
>
> Jan
>
> > Thanks
> >
> > Il ven 1 mar 2019, 15:58 Jan Kiszka <jan.kiszka@siemens.com
> > <mailto:jan.kiszka@siemens.com>> ha scritto:
> >
> >     On 01.03.19 15:21, cagnulein wrote:
> >      > Hi, with the last git the warning disappear, thanks.
> >      > Now I would like to submit a new issue : with the last git and
> with the
> >     4.14.89
> >      > also, if I run latency-test without the kvm guest on, everything
> works fine.
> >      > If I run latency-test with the kvm guest on the system hangs! Th=
e
> entire
> >     system
> >      > not only the guest.
> >      > This doesn't happen with the 4.9.146.
> >      > Any hints to debug it?
> >
> >     Hmm, this will be more complicated in fact. I need to try
> reproducing that in
> >     KVM (nested setup) because that allows insights to be obtained more
> easily.
> >
> >     Jan
> >
> >      > Thanks in advance
> >      >
> >      > Il ven 1 mar 2019, 11:30 cagnulein <cagnulein@gmail.com
> >     <mailto:cagnulein@gmail.com>
> >      > <mailto:cagnulein@gmail.com <mailto:cagnulein@gmail.com>>> ha
> scritto:
> >      >
> >      >     Yes qemu on a xenomai kernel (host device). My guest is a
> windows 10
> >     2019.
> >      >
> >      >     I'm already compiling the last git. I will let you know.
> >      >     Thanks
> >      >
> >      >     Il ven 1 mar 2019, 11:24 Jan Kiszka <jan.kiszka@siemens.com
> >     <mailto:jan.kiszka@siemens.com>
> >      >     <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.co=
m>>>
> ha
> >     scritto:
> >      >
> >      >         On 01.03.19 10:35, cagnulein via Xenomai wrote:
> >      >          > I=E2=80=99m testing the 4.14.89 ipipe (i was usually =
using
> 4.9.146)
> >     and i=E2=80=99ve
> >      >         got a
> >      >          > deterministic warning every time i start qemu. Is it
> already
> >     known?
> >      >          >
> >      >
> >      >         Thanks for reporting. I suppose this wasn't tested in a
> while.
> >      >
> >      >         Just to be sure: You are starting QEMU/KVM *on* a Xenoma=
i
> kernel,
> >     and *not*
> >      >         Xenomai as KVM guest, right?
> >      >
> >      >         Could you also give latest
> >     https://gitlab.denx.de/Xenomai/ipipe-x86/ a
> >      >         try, if
> >      >         something happened to have changed?
> >      >
> >      >         I will try to reproduce ASAP.
> >      >
> >      >         Jan
> >      >
> >      >          > Thanks
> >      >          >
> >      >          > R.
> >      >          >
> >      >          >
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.078798]
> WARNING: CPU:
> >     0 PID:
> >      >         1154
> >      >          > at ./arch/x86/include/asm/fpu/internal.h:617
> >     __kernel_fpu_end+0x8b/0xa0
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.078802]
> Modules
> >     linked in:
> >      >          > hid_generic usbhid hid xt_CHECKSUM iptable_mangle
> ipt_MASQUERADE
> >      >          > nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat
> >     nf_conntrack_ipv4
> >      >          > nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT
> nf_reject_ipv4
> >      >          > xt_tcpudp tun ebtable_filter ebtables ip6table_filter
> ip6_tables
> >      >          > iptable_filter bridge stp llc intel_rapl
> x86_pkg_temp_thermal
> >     coretemp
> >      >          > kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
> >     ghash_clmulni_intel
> >      >          > pcbc i2c_designware_platform i2c_designware_core
> nls_ascii
> >     nls_cp437 vfat
> >      >          > fat aesni_intel aes_x86_64 crypto_simd glue_helper
> cryptd
> >     intel_cstate
> >      >          > intel_rapl_perf pcspkr i915 prime_numbers lpc_ich
> >     drm_kms_helper drm
> >      >         idma64
> >      >          > fb_sys_fops mei_me syscopyarea intel_lpss_pci
> sysfillrect
> >     intel_lpss
> >      >          > sysimgblt mfd_core mei shpchp sg evdev video ip_table=
s
> >     x_tables autofs4
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.078913]  ext=
4
> crc16
> >     mbcache jbd2
> >      >          > fscrypto btrfs zstd_decompress zstd_compress xxhash
> raid10 raid456
> >      >          > async_raid6_recov async_memcpy async_pq async_xor
> async_tx xor
> >     raid6_pq
> >      >          > libcrc32c crc32c_generic raid1 raid0 multipath linear
> md_mod
> >     sd_mod
> >      >          > mmc_block igb i2c_algo_bit dca ahci sdhci_pci sdhci
> xhci_pci
> >     libahci ptp
> >      >          > crc32c_intel i2c_i801 xhci_hcd mmc_core pps_core liba=
ta
> >     usbcore scsi_mod
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.078982] CPU:
> 0 PID:
> >     1154 Comm:
> >      >          > qemu-system-x86 Not tainted 4.14.89 #1
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.078985] I-pi=
pe
> >     domain: Linux
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.078988] task=
:
> >     ffff94aff6f49c80
> >      >          > task.stack: ffffb5be80a58000
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.078991] RIP:
> >      >          > 0010:__kernel_fpu_end+0x8b/0xa0
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.078994] RSP:
> >      >         0018:ffffb5be80a5bcf8
> >      >          > EFLAGS: 00010246
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.078999] RAX:
> >      >         00000000ffffff00 RBX:
> >      >          > ffff94aff6e88000 RCX: ffff94aff6f49c80
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079002] RDX:
> >      >         00000000ffffffff RSI:
> >      >          > 0000000000000246 RDI: ffff94aff6f4a800
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079005] RBP:
> >      >         ffffb5be80a5bdd0 R08:
> >      >          > ffffffffc0c1c060 R09: ffff94aff6f8f000
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079010] R10:
> >      >         0000000000004bc0 R11:
> >      >          > ffff94afe4680008 R12: ffffffffc0ca0f80
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079013] R13:
> >      >         0000000000000000 R14:
> >      >          > ffff94aff6e88000 R15: ffff94aff83c9bc0
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079017] FS:
> >      >          > 00007f388aba8700(0000) GS:ffff94affb200000(0000)
> >     knlGS:0000000000000000
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079020] CS:
> 0010 DS:
> >     0000 ES:
> >      >          > 0000 CR0: 0000000080050033
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079023] CR2:
> >      >         000001b737101034 CR3:
> >      >          > 0000000178424000 CR4: 00000000003426f0
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079026] Call
> Trace:
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079029]
> >      >          > kvm_put_guest_fpu.part.165+0x43/0xc0 [kvm]
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079032]
> >      >          > kvm_arch_vcpu_ioctl_run+0x6bd/0x18a0 [kvm]
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079035]  ?
> >      >          > kvm_arch_vcpu_load+0x4d/0x250 [kvm]
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079038]  ?
> >      >         vmx_vcpu_load+0x5/0x3e0
> >      >          > [kvm_intel]
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079041]  ?
> >      >          > kvm_arch_vcpu_load+0x68/0x250 [kvm]
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079044]  ?
> >      >          > kvm_vcpu_ioctl+0x315/0x5f0 [kvm]
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079047]  ?
> >      >          > kvm_arch_vcpu_ioctl_run+0x5/0x18a0 [kvm]
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079050]
> >      >          > kvm_vcpu_ioctl+0x315/0x5f0 [kvm]
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079053]
> >     do_vfs_ioctl+0xa2/0x620
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079056]
> >     SyS_ioctl+0x74/0x80
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079059]
> >      >         do_syscall_64+0x86/0x140
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079062]
> >      >          > entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079065] RIP:
> >     0033:0x7f389962edd7
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079068] RSP:
> >      >         002b:00007f388aba7828
> >      >          > EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079073] RAX:
> >      >         ffffffffffffffda RBX:
> >      >          > 0000000000000000 RCX: 00007f389962edd7
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079076] RDX:
> >      >         0000000000000000 RSI:
> >      >          > 000000000000ae80 RDI: 000000000000001b
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079079] RBP:
> >      >         00007f388aba7920 R08:
> >      >          > 0000558c6bf3a900 R09: 00000000000000ff
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079082] R10:
> >      >         00007f388aba7840 R11:
> >      >          > 0000000000000246 R12: 0000000000000000
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079085] R13:
> >      >         00007ffec978276f R14:
> >      >          > 0000000000000000 R15: 00007f389e9b9040
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079088] Code=
:
> 89 3c
> >     24 eb 0a
> >      >         0f 1f
> >      >          > 00 db e2 0f 77 db 04 24 0f 1f 44 00 00 b8 ff ff ff ff
> 89 c2 48
> >     0f c7
> >      >         1f eb
> >      >          > ad 48 0f ae 89 80 0b 00 00 eb a3 <0f> 0b eb aa e8 ac
> 37 04 00
> >     66 90 66 2e
> >      >          > 0f 1f 84 00 00 00 00 00
> >      >          >
> >      >          > Mar  1 01:14:05 debiankvm kernel: [   96.079184] ---[
> end trace
> >      >          > 97cffb6b036eaaeb ]---
> >      >          >
> >      >
> >      >         --
> >      >         Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >      >         Corporate Competence Center Embedded Linux
> >      >
> >
> >     --
> >     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> >     Corporate Competence Center Embedded Linux
> >
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
