Message-ID: <54F9C6C0.2040203@xenomai.org>
Date: Fri, 06 Mar 2015 10:24:48 -0500
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <54F8DA7C.8050207@gatech.edu>
In-Reply-To: <54F8DA7C.8050207@gatech.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Error trying to view Analogy subdevices
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/05/2015 05:36 PM, Yogi A. Patel wrote:
> Hi -
> 
> I see the following when I load a National Instruments DAQ with Analogy:
> 
> Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6259 board
> analogy_mite 0000:06:04.0: setting latency timer to 64
> Analogy: analogy_ni_pcimio: pcimio_attach: found irq 11
> ------------[ cut here ]------------
> WARNING: at arch/x86/kernel/ipipe.c:243 ipipe_set_irq_affinity+0x7e/0xb0()
> Hardware name: PowerEdge T110 II
> Modules linked in: cuse dm_crypt dm_mod coretemp kvm_intel kvm aesni_intel xts
> aes_x86_64 lrw gf128mul ablk_helper cryptd ipv6 bnep snd_hda_codec_hdmi rfcomm
> dcdbas snd_usb_audio snd_usbmidi_lib snd_hda_intel snd_hda_codec snd_hwdep
> snd_seq_midi snd_rawmidi snd_seq_midi_event btusb bluetooth rfkill snd_pcm
> snd_seq snd_page_alloc analogy_ni_pcimio analogy_ni_mio fglrx(PO) snd_seq_device
> snd_timer analogy_8255 snd soundcore analogy_ni_tio analogy_ni_mite xeno_analogy
> microcode lpc_ich mfd_core shpchp fuse parport_pc ppdev lp parport ext4 jbd2
> mbcache sd_mod crc_t10dif sr_mod cdrom mpt2sas raid_class scsi_transport_sas
> crc32c_intel tg3 ptp pps_core ahci libahci
> Pid: 2118, comm: analogy_config Tainted: P           O 3.8.13-xenomai-2.6.3 #1
> Call Trace:
>  [<ffffffff8103aa90>] warn_slowpath_common+0x70/0xa0
>  [<ffffffff8103ab7a>] warn_slowpath_null+0x1a/0x20
>  [<ffffffff8102336e>] ipipe_set_irq_affinity+0x7e/0xb0
>  [<ffffffff810f41c9>] xnintr_attach+0x39/0x140
>  [<ffffffff81138a02>] rtdm_irq_request+0x32/0x70
>  [<ffffffffa020e09d>] __a4l_request_irq+0x2d/0x30 [xeno_analogy]
>  [<ffffffffa020f0d3>] a4l_request_irq+0xb3/0x130 [xeno_analogy]
>  [<ffffffffa0c3bc90>] ? mite_handle_b_linkc+0xf0/0xf0 [analogy_ni_mio]
>  [<ffffffffa0c4a192>] pcimio_attach+0x582/0x7a4 [analogy_ni_pcimio]
>  [<ffffffffa020d0c5>] a4l_assign_driver+0x65/0xf0 [xeno_analogy]
>  [<ffffffffa020d26b>] a4l_device_attach+0x6b/0x90 [xeno_analogy]
>  [<ffffffffa020d325>] a4l_ioctl_devcfg+0x65/0x130 [xeno_analogy]
>  [<ffffffffa020f34d>] a4l_ioctl+0x1d/0x20 [xeno_analogy]
>  [<ffffffff81136be4>] __rt_dev_ioctl+0xb4/0x160
>  [<ffffffff811370f2>] ? __rt_dev_open+0x92/0x100
>  [<ffffffff8113a029>] ? sys_rtdm_open+0x69/0x80
>  [<ffffffff81139eb8>] sys_rtdm_ioctl+0x28/0x30
>  [<ffffffff81103e35>] losyscall_event+0xc5/0x2b0
>  [<ffffffff810c169a>] ipipe_syscall_hook+0x3a/0x40
>  [<ffffffff810bfd0f>] __ipipe_notify_syscall+0xbf/0x130
>  [<ffffffff81023965>] __ipipe_syscall_root+0x35/0xe0
>  [<ffffffff8126ec17>] __ipipe_syscall_root_thunk+0x35/0x67
>  [<ffffffff814f69e7>] ? system_call_after_swapgs+0x54/0x6d
> ---[ end trace a4b9bd55c188be24 ]---

do you have any additional a4l_ logs after this? wondering if the attach suceeded.

also, what is the sequence of events to generate this problem?


> 
> Then when I run cat /proc/analogy/00-analogy_ni_pcimio, I get "Killed" as the
> only output on the command line and the dmesg shows:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
> IP: [<ffffffffa020f1e5>] a4l_rdproc_transfer+0x45/0x190 [xeno_analogy]
> PGD 3274a7067 PUD 35526c067 PMD 0
> Oops: 0000 [#1] SMP
> Modules linked in: vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O) cuse
> dm_crypt dm_mod coretemp kvm_intel kvm aesni_intel xts aes_x86_64 lrw gf128mul
> ablk_helper cryptd ipv6 bnep snd_hda_codec_hdmi rfcomm dcdbas snd_usb_audio
> snd_usbmidi_lib snd_hda_intel snd_hda_codec snd_hwdep snd_seq_midi snd_rawmidi
> snd_seq_midi_event btusb bluetooth rfkill snd_pcm snd_seq snd_page_alloc
> analogy_ni_pcimio analogy_ni_mio fglrx(PO) snd_seq_device snd_timer analogy_8255
> snd soundcore analogy_ni_tio analogy_ni_mite xeno_analogy microcode lpc_ich
> mfd_core shpchp fuse parport_pc ppdev lp parport ext4 jbd2 mbcache sd_mod
> crc_t10dif sr_mod cdrom mpt2sas raid_class scsi_transport_sas crc32c_intel tg3
> ptp pps_core ahci libahci
> CPU 1
> Pid: 8923, comm: cat Tainted: P        W  O 3.8.13-xenomai-2.6.3 #1 Dell Inc.
> PowerEdge T110 II/0W6TWP
> RIP: 0010:[<ffffffffa020f1e5>]  [<ffffffffa020f1e5>]
> a4l_rdproc_transfer+0x45/0x190 [xeno_analogy]
> RSP: 0018:ffff880338de7e38  EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000000d
> RDX: 0000000000001000 RSI: ffffffffa0212280 RDI: ffff880377dcd020
> RBP: ffff880338de7e60 R08: ffffffffa0212273 R09: 0000000000000000
> R10: 00007ffff799c280 R11: 0000000000000246 R12: ffff8803e4a150c0
> R13: 0000000080000002 R14: 0000000080000008 R15: 0000000000000001
> FS:  00007f380a01c740(0000) GS:ffff88044fd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000001 CR3: 0000000352b60000 CR4: 00000000001407e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> I-pipe domain Linux
> Process cat (pid: 8923, threadinfo ffff880338de4000, task ffff8803ebe2b820)
> Stack:
>  0000000000000000 ffff8804262a0380 0000000000000001 ffff880338de7f50
>  ffff8803e4a150c0 ffff880338de7ec8 ffffffff811ad61e ffff88043b46eae0
>  0000000001fff000 ffff8803e4a150f8 0000000000010000 0000000000000000
> Call Trace:
>  [<ffffffff811ad61e>] seq_read+0x11e/0x3a0
>  [<ffffffff811eccfd>] proc_reg_read+0x6d/0xa0
>  [<ffffffff8118cbec>] vfs_read+0x9c/0x170
>  [<ffffffff8118ce79>] sys_read+0x49/0xa0
>  [<ffffffff814f6a16>] system_call_fastpath+0x16/0x1b
> Code: be 08 00 00 80 41 55 41 bd 02 00 00 80 41 54 49 89 fc 53 31 db e8 0c df f9
> e0 31 c0 48 c7 c6 73 22 21 a0 4c 89 e7 e8 fb de f9 e0 <41> 8b 07 85 c0 75 6f e9
> cf 00 00 00 0f 1f 80 00 00 00 00 48 3d
> RIP  [<ffffffffa020f1e5>] a4l_rdproc_transfer+0x45/0x190 [xeno_analogy]
>  RSP <ffff880338de7e38>
> CR2: 0000000000000001
> ---[ end trace a4b9bd55c188be25 ]---
> 
> Any thoughts?
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 

- -- 
jro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU+ca9AAoJECDcy2IJkagRM30H/3bjVTop+b8dgQsbh58ZvDhF
PdcIF+ErUn/+ujkA0HPSeMQqd09QFqxUbZvJ3i+rjgNtOpyMellFa4Dv//FAMW0f
wYTXFZbzHISiIdMhTzMSJSqMp9IbABRwltFt233o3luOPuL46gEK/gdW8qdCVnX2
g4KmtwXbVCJvit2/39qAdoobxNJ9jabnuzl2CwWaM3m8fNjlfp4GQ9fUJl7vpFab
wQRDw3Ev3nCf28+cHCdDSwx4jiugoRHACBSxdZbuCo8DfwjZDdOVmqi7W9KIUy8o
xsp6rOd039HDEQnbwNc8td3N7CDu8L0VrOiMjrl9ahm5tbN/JWBew04HLj3QWtk=
=mA/R
-----END PGP SIGNATURE-----

