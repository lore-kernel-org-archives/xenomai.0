MIME-Version: 1.0
References: <d53140e58f60459694e2e66a94d0a518@systemceramics.com>
 <CAPR3TAhurhcwOGe9wfnOTUd=VBRvXuMLxZtNZ-3+QNyd=TOJnA@mail.gmail.com>
 <ebec2dcf-9549-fed2-6a48-299597bc7079@siemens.com>
In-Reply-To: <ebec2dcf-9549-fed2-6a48-299597bc7079@siemens.com>
From: cagnulein <cagnulein@gmail.com>
Date: Fri, 1 Mar 2019 11:30:11 +0100
Message-ID: <CAPR3TAjFNV-0LgZ=+ydtseAQw-jdmYRHO4FQwybTjAHwDV59Xg@mail.gmail.com>
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

Yes qemu on a xenomai kernel (host device). My guest is a windows 10 2019.

I'm already compiling the last git. I will let you know.
Thanks

Il ven 1 mar 2019, 11:24 Jan Kiszka <jan.kiszka@siemens.com> ha scritto:

> On 01.03.19 10:35, cagnulein via Xenomai wrote:
> > I=E2=80=99m testing the 4.14.89 ipipe (i was usually using 4.9.146) and=
 i=E2=80=99ve got
> a
> > deterministic warning every time i start qemu. Is it already known?
> >
>
> Thanks for reporting. I suppose this wasn't tested in a while.
>
> Just to be sure: You are starting QEMU/KVM *on* a Xenomai kernel, and
> *not*
> Xenomai as KVM guest, right?
>
> Could you also give latest https://gitlab.denx.de/Xenomai/ipipe-x86/ a
> try, if
> something happened to have changed?
>
> I will try to reproduce ASAP.
>
> Jan
>
> > Thanks
> >
> > R.
> >
> >
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.078798] WARNING: CPU: 0 PID:
> 1154
> > at ./arch/x86/include/asm/fpu/internal.h:617 __kernel_fpu_end+0x8b/0xa0
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.078802] Modules linked in:
> > hid_generic usbhid hid xt_CHECKSUM iptable_mangle ipt_MASQUERADE
> > nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4
> > nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4
> > xt_tcpudp tun ebtable_filter ebtables ip6table_filter ip6_tables
> > iptable_filter bridge stp llc intel_rapl x86_pkg_temp_thermal coretemp
> > kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_int=
el
> > pcbc i2c_designware_platform i2c_designware_core nls_ascii nls_cp437 vf=
at
> > fat aesni_intel aes_x86_64 crypto_simd glue_helper cryptd intel_cstate
> > intel_rapl_perf pcspkr i915 prime_numbers lpc_ich drm_kms_helper drm
> idma64
> > fb_sys_fops mei_me syscopyarea intel_lpss_pci sysfillrect intel_lpss
> > sysimgblt mfd_core mei shpchp sg evdev video ip_tables x_tables autofs4
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.078913]  ext4 crc16 mbcache jb=
d2
> > fscrypto btrfs zstd_decompress zstd_compress xxhash raid10 raid456
> > async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq
> > libcrc32c crc32c_generic raid1 raid0 multipath linear md_mod sd_mod
> > mmc_block igb i2c_algo_bit dca ahci sdhci_pci sdhci xhci_pci libahci pt=
p
> > crc32c_intel i2c_i801 xhci_hcd mmc_core pps_core libata usbcore scsi_mo=
d
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.078982] CPU: 0 PID: 1154 Comm:
> > qemu-system-x86 Not tainted 4.14.89 #1
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.078985] I-pipe domain: Linux
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.078988] task: ffff94aff6f49c80
> > task.stack: ffffb5be80a58000
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.078991] RIP:
> > 0010:__kernel_fpu_end+0x8b/0xa0
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.078994] RSP:
> 0018:ffffb5be80a5bcf8
> > EFLAGS: 00010246
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.078999] RAX: 00000000ffffff00
> RBX:
> > ffff94aff6e88000 RCX: ffff94aff6f49c80
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079002] RDX: 00000000ffffffff
> RSI:
> > 0000000000000246 RDI: ffff94aff6f4a800
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079005] RBP: ffffb5be80a5bdd0
> R08:
> > ffffffffc0c1c060 R09: ffff94aff6f8f000
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079010] R10: 0000000000004bc0
> R11:
> > ffff94afe4680008 R12: ffffffffc0ca0f80
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079013] R13: 0000000000000000
> R14:
> > ffff94aff6e88000 R15: ffff94aff83c9bc0
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079017] FS:
> > 00007f388aba8700(0000) GS:ffff94affb200000(0000) knlGS:0000000000000000
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079020] CS:  0010 DS: 0000 ES:
> > 0000 CR0: 0000000080050033
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079023] CR2: 000001b737101034
> CR3:
> > 0000000178424000 CR4: 00000000003426f0
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079026] Call Trace:
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079029]
> > kvm_put_guest_fpu.part.165+0x43/0xc0 [kvm]
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079032]
> > kvm_arch_vcpu_ioctl_run+0x6bd/0x18a0 [kvm]
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079035]  ?
> > kvm_arch_vcpu_load+0x4d/0x250 [kvm]
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079038]  ?
> vmx_vcpu_load+0x5/0x3e0
> > [kvm_intel]
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079041]  ?
> > kvm_arch_vcpu_load+0x68/0x250 [kvm]
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079044]  ?
> > kvm_vcpu_ioctl+0x315/0x5f0 [kvm]
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079047]  ?
> > kvm_arch_vcpu_ioctl_run+0x5/0x18a0 [kvm]
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079050]
> > kvm_vcpu_ioctl+0x315/0x5f0 [kvm]
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079053]  do_vfs_ioctl+0xa2/0x6=
20
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079056]  SyS_ioctl+0x74/0x80
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079059]
> do_syscall_64+0x86/0x140
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079062]
> > entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079065] RIP: 0033:0x7f389962ed=
d7
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079068] RSP:
> 002b:00007f388aba7828
> > EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079073] RAX: ffffffffffffffda
> RBX:
> > 0000000000000000 RCX: 00007f389962edd7
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079076] RDX: 0000000000000000
> RSI:
> > 000000000000ae80 RDI: 000000000000001b
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079079] RBP: 00007f388aba7920
> R08:
> > 0000558c6bf3a900 R09: 00000000000000ff
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079082] R10: 00007f388aba7840
> R11:
> > 0000000000000246 R12: 0000000000000000
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079085] R13: 00007ffec978276f
> R14:
> > 0000000000000000 R15: 00007f389e9b9040
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079088] Code: 89 3c 24 eb 0a 0=
f
> 1f
> > 00 db e2 0f 77 db 04 24 0f 1f 44 00 00 b8 ff ff ff ff 89 c2 48 0f c7 1f
> eb
> > ad 48 0f ae 89 80 0b 00 00 eb a3 <0f> 0b eb aa e8 ac 37 04 00 66 90 66 =
2e
> > 0f 1f 84 00 00 00 00 00
> >
> > Mar  1 01:14:05 debiankvm kernel: [   96.079184] ---[ end trace
> > 97cffb6b036eaaeb ]---
> >
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
