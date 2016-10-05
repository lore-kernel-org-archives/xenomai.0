From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Wed, 05 Oct 2016 14:42:39 +0200
Message-ID: <3287485.VU35SOUnQ7@soho>
In-Reply-To: <a9d87162-de0a-3c56-d17b-7f6610622e72@siemens.com>
References: <2990549.hKSmcVRoDB@indiana> <3624229.iZt7HIcxlZ@soho>
 <a9d87162-de0a-3c56-d17b-7f6610622e72@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] Xenomai 3.0.3 is broken in my system (was Regarding
	Xenomai and RTNET)
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

El Dimecres, 5 d'octubre de 2016, a les 12:39:04, Jan Kiszka va escriure:
> On 2016-10-04 17:36, Leopold Palomo-Avellaneda wrote:
> > El Dilluns, 3 d'octubre de 2016, a les 18:12:12, Leopold Palomo-Avellaneda
> > va> 
> > escriure:
> >> Hi,
> >> 
> >> I have been making some tests and I have arrived to the conclusion that
> >> the
> >> PC that I would like to install Xenomai and RTNET doesn't like it.
> >> 
> >> It's a PC with a motherboard Gigabyte Q170M-D3H-CF. I'm running 4.1.18
> >> with
> >> xenomai 3.0.3. AFAIK, the xenomai tests works. However, when I try to run
> >> RTNET, I got crashes:
> >> 
> >> BUG: unable to handle kernel paging request at 00007f47ea0ef878
> >> 
> >>  IP: [<ffffffffa0231580>] rt_udp_ioctl+0x50/0x74 [rtudp]
> >>  PGD 458887067 PUD 4590a1067 PMD 45921f067 PTE 8000000438863867
> >>  Oops: 0001 [#1] PREEMPT SMP
> >>  Modules linked in: rt_igb rt_loopback rtcfg rtudp rtipv4 rtmac rtpacket
> >> 
> >> rtnet e100 mii ctr ccm binfmt_misc nfsd
> >> 
> >>  CPU: 4 PID: 6773 Comm: LWRJointPositio Not tainted 4.1.18-xenomai-3.0.3
> >>  #1
> >>  Hardware name: Gigabyte Technology Co., Ltd. To be filled by
> >> 
> >> O.E.M./Q170M-D3H- CF, BIOS F1 10/13/2015
> >> 
> >>  task: ffff880459a26010 ti: ffff880459a38000 task.ti: ffff880459a38000
> >>  RIP: 0010:[<ffffffffa0231580>]  [<ffffffffa0231580>]
> >>  rt_udp_ioctl+0x50/0x74
> >> 
> >> [rtudp]
> >> 
> >>  RSP: 0018:ffff880459a3be08  EFLAGS: 00010246
> >>  RAX: 00007f47ea0ef870 RBX: ffff880458d59400 RCX: ffff880458d59440
> >>  RDX: 0000000000000000 RSI: 0000000040100022 RDI: ffff880458d59400
> >>  RBP: 0000000000000003 R08: ffff880460297420 R09: 000000000000004e
> >>  R10: 00000000000000dc R11: ffff880459a3bdc0 R12: ffff880459a26010
> >>  R13: ffffc90001f05008 R14: 0000000040100022 R15: ffffffff81b85ec0
> >>  FS:  00007f47ea0f0700(0000) GS:ffff880460200000(0000)
> >> 
> >> knlGS:0000000000000000 CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> >> 
> >>  CR2: 00007f47ea0ef878 CR3: 000000045890c000 CR4: 00000000003406e0
> >>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>  I-pipe domain Linux
> >>  
> >>  Stack:
> >>   ffffffffa0231535 ffffffff8116fb70 ffff880459a265c0 00007f47ea0ef870
> >>   ffff8804599975d0 0000000000000010 ffff880459a3beb8 ffff880459a3be48
> >>   0000000000000002 ffff880459a26010 00007f47ea0ef870 ffff880459a26010
> >>  
> >>  Call Trace:
> >>   [<ffffffffa0231535>] ? rt_udp_ioctl+0x5/0x74 [rtudp]
> >>   [<ffffffff8116fb70>] ? rtdm_fd_ioctl+0x100/0x270
> >>   [<ffffffff81174b40>] ? CoBaLt_fcntl+0x20/0x20
> >>   [<ffffffff81174b40>] ? CoBaLt_fcntl+0x20/0x20
> >>   [<ffffffff81174b50>] ? CoBaLt_ioctl+0x10/0x20
> >>   [<ffffffff81174b45>] ? CoBaLt_ioctl+0x5/0x20
> >>   [<ffffffff8118450a>] ? ipipe_syscall_hook+0x11a/0x360
> >>   [<ffffffff81108da7>] ? __ipipe_notify_syscall+0xe7/0x1d0
> >>   [<ffffffff81107185>] ? __ipipe_restore_root_nosync+0x5/0x30
> >>   [<ffffffff8158fb34>] ? pipeline_syscall+0x9/0x16
> >>  
> >>  Code: 23 00 10 40 75 15 8b 50 08 48 8b 30 48 89 cf 48 83 c4 08 e9 a3 fd
> >>  ff
> >> 
> >> ff 0f 1f 00 48 89 c2 48 83 c4 08 e9 5
> >> 
> >>  RIP  [<ffffffffa0231580>] rt_udp_ioctl+0x50/0x74 [rtudp]
> >>  
> >>   RSP <ffff880459a3be08>
> >>  
> >>  CR2: 00007f47ea0ef878
> >>  ---[ end trace 085d23e71de3ae4b ]---
> >> 
> >> The funny (or ugly thing) is that, same kernel (I'm using debian
> >> packages)
> >> and almost the same Xenomai (compiled in each machine but with the same
> >> configure options) works in another similar box, with the same network
> >> cards (rt_igb). My application doesn't crash.
> >> 
> >> I also have tested another network card (rt_e1000_new) with the same core
> >> dump.
> >> 
> >> So, any idea how can I find some light in this? I don't know if it's a
> >> rtnet issue of a combination of kernel and hardware issue.
> > 
> > digging more in this I have found some interesting data. Although I though
> > that previous message was equal to all the crashes is not true. I have
> > much
> > 
> > more messages with this error:
> >  BUG: unable to handle kernel paging request at 00007ffda8577680
> >  IP: [<ffffffff812fe5c8>] strncmp+0x8/0x50
> >  PGD 4589e3067 PUD 45c719067 PMD 459a88067 PTE 8000000453c52867
> >  Oops: 0001 [#1] SMP
> >  Modules linked in: rt_loopback rtcfg rtudp rtipv4 rtmac rtpacket ctr ccm
> > 
> > binfmt_misc nfsd auth_rpcgss oid_registry nfs_acl nfs lockd grace fscache
> > sunrpc joydev rt_e1000e rt_e1000 hid_generic usbhid nls_utf8 nls_cp437
> > snd_hda_codec_hdmi vfat fat ppdev snd_hda_codec_realtek
> > snd_hda_codec_generic x86_pkg_temp_thermal rt_e1000_new coretemp rt_igb
> > rt_eepro100 kvm_intel rtnet kvm crct10dif_pclmul crc32_pclmul arc4
> > snd_hda_intel aesni_intel
> > snd_hda_controller aes_x86_64 snd_hda_codec lrw snd_hda_core gf128mul
> > snd_hwdep glue_helper snd_pcm ablk_helper cryptd snd_timer i915 snd evdev
> > soundcore pcspkr efivars serio_raw i2c_i801 drm_kms_helper drm wmi battery
> > i2c_algo_bit parport_pc video parport shpchp tpm_infineon tpm_tis tpm
> > button ath9k ath9k_common ath9k_hw ath mac80211 cfg80211 rfkill fuse
> > 
> >   autofs4 ext4 crc16 mbcache jbd2 sg sd_mod crc32c_intel ahci libahci
> >   xhci_pci> 
> > libata xhci_hcd e100 mii scsi_mod usbcore usb_common fan thermal_sys
> > i2c_hid hid i2c_core
> > 
> >  CPU: 7 PID: 1047 Comm: slaveinfo_rt Not tainted 4.1.18-xenomai-3.0.3 #2
> >  Hardware name: Gigabyte Technology Co., Ltd. To be filled by
> >  O.E.M./Q170M-D3H-> 
> > CF, BIOS F1 10/13/2015
> > 
> >  task: ffff88045b0faaa0 ti: ffff88045b44c000 task.ti: ffff88045b44c000
> >  RIP: 0010:[<ffffffff812fe5c8>]  [<ffffffff812fe5c8>] strncmp+0x8/0x50
> >  RSP: 0018:ffff88045b44fda0  EFLAGS: 00010202
> >  RAX: ffffc90001f07008 RBX: ffffffffa0366740 RCX: 0000000000000072
> >  RDX: 0000000000000010 RSI: 00007ffda8577680 RDI: ffff880459aaa004
> >  RBP: ffff880459aaa000 R08: ffff880460597420 R09: 0000000000000056
> >  R10: 00000000000000dc R11: ffff88045b44fdc0 R12: 00007ffda8577680
> >  R13: 00007ffda8577680 R14: 0000000040180021 R15: ffffffff81b832c0
> >  FS:  00007f3094175740(0000) GS:ffff880460500000(0000)
> >  knlGS:0000000000000000 CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> >  CR2: 00007ffda8577680 CR3: 000000045a12a000 CR4: 00000000003406e0
> >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >  I-pipe domain Linux
> >  
> >  Stack:
> >   ffffffffa035f151 0000000000052f08 0000000000000000 00007ffda8577680
> >   ffffffffa035f621 ffff880459a17000 0000000040180021 ffff88045b0faaa0
> >   ffffffffa03627be ffff880459a17000 0000000000000003 ffff88045b0faaa0
> >  
> >  Call Trace:
> >   [<ffffffffa035f151>] ? __rtdev_get_by_name+0x31/0x60 [rtnet]
> >   [<ffffffffa035f621>] ? rtdev_get_by_name+0x51/0xd0 [rtnet]
> >   [<ffffffffa03627be>] ? rt_socket_if_ioctl+0x2e/0x2f0 [rtnet]
> >   [<ffffffff8116505c>] ? rtdm_fd_ioctl+0xfc/0x220
> >   [<ffffffff81169d10>] ? CoBaLt_fcntl+0x20/0x20
> >   [<ffffffff81169d10>] ? CoBaLt_fcntl+0x20/0x20
> >   [<ffffffff81169d20>] ? CoBaLt_ioctl+0x10/0x20
> >   [<ffffffff81169d15>] ? CoBaLt_ioctl+0x5/0x20
> >   [<ffffffff8117932a>] ? ipipe_syscall_hook+0x25a/0x330
> >   [<ffffffff81100097>] ? __ipipe_notify_syscall+0xe7/0x1d0
> >   [<ffffffff811e7845>] ? fput+0x5/0x90
> >   [<ffffffff81567cf4>] ? pipeline_syscall+0x9/0x16
> > 
> > it shows that the crash is produced by __rtdev_get_by_name called from
> > rtdev_get_by_name called from rt_socket_if_ioctl ... with a strncmp
> > 
> > that function is defined kernel/drivers/net/stack/rtdev.c
> > 
> > static struct rtnet_device *__rtdev_get_by_name(const char *name)
> > {
> > 
> >     int                 i;
> >     struct rtnet_device *rtdev;
> >     
> >     
> >     for (i = 0; i < MAX_RT_DEVICES; i++) {
> >     
> >         rtdev = rtnet_devices[i];
> >         if ((rtdev != NULL) && (strncmp(rtdev->name, name, IFNAMSIZ) ==
> >         0))
> >         
> >             return rtdev;
> >     
> >     }
> >     return NULL;
> > 
> > }
> > 
> > however I couldn't understand why this function crashes in this box and
> > not in the other box that I have tested. I will update BIOS and see what
> > happen.
> > 
> > In any case, any help will be appreciated.
> 
> Instrument the code with printk to retrieve which parameters are in
> which state before they are evaluated (and cause the crash). That's the
> general answer that almost always applies if you don't see the cause.

I tried to do that. I simply add a printk trying to show the values of (i) and 
rtdev->name. However, after that the box crash with hundreds of messages so I 
couldn't see any valuable data. I guess that there's something more deep that 
fails here.

In any case, to me it's strange that the same code works in one box and makes 
a kernel crash in another box. Working on a user application. Using the same 
kernel and the same Xenomai version.

> In this case, I would say that kernel space is accessing an invalid
> userspace pointer (00007ffda8577680). That can happen with nasty RTnet,
> because it lacks safe userspace address accesses. So, userspace bugs
> quickly because kernel crashes. Long-pending to-do...

Well, I have dona another test. I have used a simple program, not made by me. 
Just en example that uses raw sockets

https://gist.github.com/austinmarton/1922600

I have compiled with:

gcc -I/usr/xenomai/include/cobalt -I/usr/xenomai/include -D_GNU_SOURCE -
D_REENTRANT -D__COBALT__ -D__COBALT_WRAP__ sendRaw.c -
Wl,@/usr/xenomai/lib/cobalt.wrappers   /usr/xenomai/lib/xenomai/bootstrap.o -
Wl,--wrap=main -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -
L/usr/xenomai/lib -lcobalt -lpthread -lrt -o sendRaw 


And it crash with the same:

BUG: unable to handle kernel paging request at 00007ffe9c534390
[ 5122.346329] IP: [<ffffffff812fe5c8>] strncmp+0x8/0x50
[ 5122.346341] PGD 45caee067 PUD 45add6067 PMD 45a75d067 PTE 800000044e767867
[ 5122.346357] Oops: 0001 [#1] SMP 
[ 5122.346365] Modules linked in: rt_igb rt_loopback rtcfg rtudp rtipv4 rtmac 
rtpacket rtnet ptp pps_core dca ctr ccm snd_hda_codec_hdmi binfmt_misc nfsd 
auth_rpcgss oid_registry nfs_acl nfs lockd grace fscache sunrpc joydev 
hid_generic nls_utf8 x86_pkg_temp_thermal nls_cp437 coretemp usbhid vfat 
snd_hda_codec_realtek kvm_intel ppdev fat snd_hda_codec_generic evdev kvm 
crct10dif_pclmul crc32_pclmul snd_hda_intel aesni_intel snd_hda_controller 
aes_x86_64 snd_hda_codec lrw snd_hda_core gf128mul glue_helper ablk_helper 
snd_hwdep cryptd i915 snd_pcm snd_timer snd drm_kms_helper serio_raw efivars 
pcspkr soundcore drm arc4 shpchp i2c_algo_bit i2c_i801 parport_pc battery 
parport wmi video tpm_tis tpm button ath9k ath9k_common ath9k_hw ath mac80211 
cfg80211 rfkill fuse autofs4 ext4 crc16 mbcache jbd2 sg sd_mod
[ 5122.346552]  crc32c_intel psmouse ahci libahci xhci_pci libata xhci_hcd 
e100 mii scsi_mod usbcore usb_common fan thermal_sys i2c_hid hid i2c_core 
[last unloaded: e1000e]
[ 5122.346591] CPU: 5 PID: 1517 Comm: sendRaw Not tainted 4.1.18-xenomai-3.0.3 
#1
[ 5122.346604] Hardware name: Gigabyte Technology Co., Ltd. To be filled by 
O.E.M./Q170M-D3H, BIOS F2 01/11/2016
[ 5122.346622] task: ffff88045885e960 ti: ffff880458a68000 task.ti: ffff880458a68000
[ 5122.346639] RIP: 0010:[<ffffffff812fe5c8>]  [<ffffffff812fe5c8>] strncmp+0x8/0x50
[ 5122.346653] RSP: 0018:ffff880458a6bda0  EFLAGS: 00010202
[ 5122.346663] RAX: ffffc90001f02008 RBX: ffffffffa0493740 RCX: 0000000000000072
[ 5122.346676] RDX: 0000000000000010 RSI: 00007ffe9c534390 RDI: ffff88045cafb804
[ 5122.346688] RBP: ffff88045cafb800 R08: ffff880460397420 R09: 000000000000004e
[ 5122.346700] R10: 00000000000000dc R11: ffff880458a6bdc0 R12: 00007ffe9c534390
[ 5122.346713] R13: 00007ffe9c534390 R14: 0000000000008933 R15: ffffffff81b832c0
[ 5122.346725] FS:  00007fd66ac08740(0000) GS:ffff880460300000(0000) 
knlGS:0000000000000000
[ 5122.346739] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 5122.346750] CR2: 00007ffe9c534390 CR3: 000000045890c000 CR4: 
00000000003406e0
[ 5122.346762] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 5122.346775] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5122.346787] I-pipe domain Linux
[ 5122.346793] Stack:
[ 5122.346797]  ffffffffa048c151 0000000000052f08 0000000000000000 00007ffe9c534390
[ 5122.346813]  ffffffffa048c621 ffff8804599a8a00 0000000000008933 ffff88045885e960
[ 5122.346829]  ffffffffa048f7be ffff8804599a8a00 0000000000000003 ffff88045885e960
[ 5122.346844] Call Trace:
[ 5122.346851]  [<ffffffffa048c151>] ? __rtdev_get_by_name+0x31/0x60 [rtnet]
[ 5122.346864]  [<ffffffffa048c621>] ? rtdev_get_by_name+0x51/0xd0 [rtnet]
[ 5122.346876]  [<ffffffffa048f7be>] ? rt_socket_if_ioctl+0x2e/0x2f0 [rtnet]
[ 5122.346890]  [<ffffffff8116505c>] ? rtdm_fd_ioctl+0xfc/0x220
[ 5122.346901]  [<ffffffff81169d10>] ? CoBaLt_fcntl+0x20/0x20
[ 5122.346911]  [<ffffffff81169d10>] ? CoBaLt_fcntl+0x20/0x20
[ 5122.346921]  [<ffffffff81169d20>] ? CoBaLt_ioctl+0x10/0x20
[ 5122.346931]  [<ffffffff81169d15>] ? CoBaLt_ioctl+0x5/0x20
[ 5122.346941]  [<ffffffff8117932a>] ? ipipe_syscall_hook+0x25a/0x330



Checking it, I think that it's a problem pf using ioctl command to select the 
device. I have tried (and I can repeat if it's necessary) to use the POSIX 
layer and the Native (alchemy) layer.

Any idea?

Leopold


-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

