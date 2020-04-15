Subject: Re: I wonder why it calls pipeline_syscall function firstly when i
 call the open function to aquire the handle of a rtdm driver?
References: <CAAvDm6Y4dHadO85ycq3n99_3GbD0geeHASezoTDAUZ-eQzXQpA@mail.gmail.com>
 <73aa242c-4a2d-7b6a-5e9e-b29d4b02ac06@siemens.com>
 <CAAvDm6Y1ANq1scprQyqN+vx8JwinwGT6uZM5ipqjj+SO=hd8Bw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b5375386-c0b2-96e8-703f-1341fba1ccf1@siemens.com>
Date: Wed, 15 Apr 2020 10:31:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6Y1ANq1scprQyqN+vx8JwinwGT6uZM5ipqjj+SO=hd8Bw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 15.04.20 10:19, 孙世龙 wrote:
> Hi，
>        I am glad to hear from you.
>      >> And that leads to kmalloc being called with a size that it does not
>      >> support. Use vmalloc instead, as the kernel recommends, and hook 
> that
>      >> pointer to a smaller context structure.
>      I agree with you.
>      I hope that my pool english would not confuse you.
>     I am not intend to ask help to slove the problem showed in the log 
> listed below.
> 
>     I wonder why it calls pipeline_syscall function firstly when i call 
> the open function to aquire the handle of a rtdm driver?

The arch-specific bits of I-pipe intercept all syscalls and route them 
to ipipe_handle_syscall. This is where it is decided whether to inform 
the "head domain" (Xenomai) or to pass them on normally to Linux.

Xenomai gets informed here because userspace directed your wrapped 
open() call to the CoBaLt_open() syscall. That's needed because RTDM 
drivers are not normal Linux drivers and, thus, need to be informed via 
a special hook when a device they provide gets opened.

HTH,
Jan

>     The stack call log for kernel is listed below.
> 
>     Looking forward to hearing from you.
>     Best regards.
> 
> 
> [103309.193491] RPI_GPIO RTDM, loading
> [103309.196729] vmalloc() succefully ptr=ffffbd0592fe9000
> [103376.533957] ------------[ cut here ]------------
> [103376.535002] WARNING: CPU: 4 PID: 14840 at mm/page_alloc.c:3532 
> __alloc_pages_slowpath+0xa99/0xb60
> [103376.535008] Modules linked in: rpi_gpio_rtdm(OE) snd_ens1371 
> snd_ac97_codec ac97_bus gameport snd_pcm snd_seq_midi snd_seq_midi_event 
> snd_rawmidi snd_seq crct10dif_pclmul crc32_pclmul ghash_clmulni_intel 
> snd_seq_device snd_timer vmw_vsock_vmci_transport vsock aesni_intel snd 
> aes_x86_64 soundcore lrw input_leds glue_helper ablk_helper cryptd 
> rt_e1000 rtnet serio_raw i2c_piix4 nfit vmw_vmci shpchp mac_hid nfsd 
> auth_rpcgss nfs_acl lockd grace sunrpc parport_pc ppdev lp parport 
> autofs4 hid_generic usbhid hid psmouse vmwgfx ahci libahci ttm e1000 
> drm_kms_helper syscopyarea sysfillrect sysimgblt mptspi fb_sys_fops 
> mptscsih drm mptbase scsi_transport_spi pata_acpi fjes [last unloaded: 
> rpi_gpio_rtdm]
> [103376.535040] CPU: 4 PID: 14840 Comm: xenomai_rtdm_rp Tainted: G       
>      OE   4.9.38-xnm-3.0.9-udd-redo-dbg-relax-dis-guest-def-rlx #1
> [103376.535041] Hardware name: VMware, Inc. VMware Virtual 
> Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
> [103376.535042] I-pipe domain: Linux
> [103376.535043]  ffffbd0582c07b60 ffffffffae423201 0000000000000000 
> 0000000000000000
> [103376.535045]  ffffbd0582c07ba0 ffffffffae0719eb 00000dcc61659100 
> 0000000000000000
> [103376.535046]  0000000000000000 000000000240c0c0 000000000000000e 
> 0000000000000000
> [103376.535048] Call Trace:
> [103376.535515]  [] dump_stack+0x96/0xc5
> [103376.535562]  [] __warn+0xcb/0xf0
> [103376.535564]  [] warn_slowpath_null+0x1d/0x20
> [103376.535566]  [] __alloc_pages_slowpath+0xa99/0xb60
> [103376.535766]  [] ? mntput_no_expire+0x5/0x180
> [103376.535768]  [] ? mntput+0x24/0x40
> [103376.535769]  [] ? terminate_walk+0x8e/0xf0
> [103376.535771]  [] ? get_page_from_freelist+0x46a/0xab0
> [103376.535772]  [] ? path_openat+0x414/0x1400
> [103376.535940]  [] ? xnclock_core_local_shot+0x63/0xb0
> [103376.536159]  [] ? 
> trace_event_raw_event_workqueue_execute_start+0x50/0xa0
> [103376.536162]  [] __alloc_pages_nodemask+0x1fe/0x260
> [103376.536177]  [] alloc_pages_current+0x95/0x140
> [103376.536179]  [] kmalloc_order+0x18/0x40
> [103376.536180]  [] kmalloc_order_trace+0x24/0xa0
> [103376.536193]  [] __kmalloc+0x1ed/0x200
> [103376.536206]  [] create_instance+0x4b/0x80
> [103376.536208]  [] __rtdm_dev_open+0xa4/0x250
> [103376.536221]  [] ? cobalt_copy_to_user+0x70/0x70
> [103376.536222]  [] CoBaLt_open+0x2a/0x40
> [103376.536224]  [] ipipe_syscall_hook+0x114/0x320
> [103376.536247]  [] __ipipe_notify_syscall+0xbf/0x170
> [103376.536249]  [] ? SyS_write+0x79/0xc0
> [103376.536505]  [] pipeline_syscall+0x8/0x1b
> [103376.536540] ---[ end trace 41f9f284a6c92035 ]---
> 
> 
> 
> Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>> 于 
> 2020年4月15日周三 下午3:29写道：
> 
>     On 15.04.20 04:45, 孙世龙 via Xenomai wrote:
>      > Hi，
>      >
>      > I am using xenomai-v3.0.9 with linux3.0.9.
>      >
>      > I wonder that why it calls pipeline_syscall function firstly
>      > when i call the open function to aquire the handle of a rtdm driver?
>      >
>      > The related call trace log for kernel is listed below.
>      >
>      > Some notes.
>      >
>      > I am quite conscious of the reason which causes the error.
>      > So i am not intend to ask help to slove the problem showed in the log
>      > listed below.
>      >
>      > I have set the context_size of the rtdm_driver struct to a huge
>     number in
>      > my rtdm driver.
> 
>     And that leads to kmalloc being called with a size that it does not
>     support. Use vmalloc instead, as the kernel recommends, and hook that
>     pointer to a smaller context structure.
> 
>     Jan
> 
>      > So the error occurs when i call the open function to aquire the
>     rtdm handle.
>      > I am not confused any more after i have read the source code.
>      >
>      > But i could not make it clealy why it calls pipeline_syscall function
>      > firstly.
>      >
>      > Looking forward to hearing from you.
>      > Best regards.
>      >
>      >
>      > [103309.193491] RPI_GPIO RTDM, loading
>      > [103309.196729] vmalloc() succefully ptr=ffffbd0592fe9000
>      > [103376.533957] ------------[ cut here ]------------
>      > [103376.535002] WARNING: CPU: 4 PID: 14840 at mm/page_alloc.c:3532
>      > __alloc_pages_slowpath+0xa99/0xb60
>      > [103376.535008] Modules linked in: rpi_gpio_rtdm(OE) snd_ens1371
>      > snd_ac97_codec ac97_bus gameport snd_pcm snd_seq_midi
>     snd_seq_midi_event
>      > snd_rawmidi snd_seq crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
>      > snd_seq_device snd_timer vmw_vsock_vmci_transport vsock
>     aesni_intel snd
>      > aes_x86_64 soundcore lrw input_leds glue_helper ablk_helper
>     cryptd rt_e1000
>      > rtnet serio_raw i2c_piix4 nfit vmw_vmci shpchp mac_hid nfsd
>     auth_rpcgss
>      > nfs_acl lockd grace sunrpc parport_pc ppdev lp parport autofs4
>     hid_generic
>      > usbhid hid psmouse vmwgfx ahci libahci ttm e1000 drm_kms_helper
>     syscopyarea
>      > sysfillrect sysimgblt mptspi fb_sys_fops mptscsih drm mptbase
>      > scsi_transport_spi pata_acpi fjes [last unloaded: rpi_gpio_rtdm]
>      > [103376.535040] CPU: 4 PID: 14840 Comm: xenomai_rtdm_rp Tainted: G
>      >    OE   4.9.38-xnm-3.0.9-udd-redo-dbg-relax-dis-guest-def-rlx #1
>      > [103376.535041] Hardware name: VMware, Inc. VMware Virtual
>     Platform/440BX
>      > Desktop Reference Platform, BIOS 6.00 04/13/2018
>      > [103376.535042] I-pipe domain: Linux
>      > [103376.535043]  ffffbd0582c07b60 ffffffffae423201 0000000000000000
>      > 0000000000000000
>      > [103376.535045]  ffffbd0582c07ba0 ffffffffae0719eb 00000dcc61659100
>      > 0000000000000000
>      > [103376.535046]  0000000000000000 000000000240c0c0 000000000000000e
>      > 0000000000000000
>      > [103376.535048] Call Trace:
>      > [103376.535515]  [] dump_stack+0x96/0xc5
>      > [103376.535562]  [] __warn+0xcb/0xf0
>      > [103376.535564]  [] warn_slowpath_null+0x1d/0x20
>      > [103376.535566]  [] __alloc_pages_slowpath+0xa99/0xb60
>      > [103376.535766]  [] ? mntput_no_expire+0x5/0x180
>      > [103376.535768]  [] ? mntput+0x24/0x40
>      > [103376.535769]  [] ? terminate_walk+0x8e/0xf0
>      > [103376.535771]  [] ? get_page_from_freelist+0x46a/0xab0
>      > [103376.535772]  [] ? path_openat+0x414/0x1400
>      > [103376.535940]  [] ? xnclock_core_local_shot+0x63/0xb0
>      > [103376.536159]  [] ?
>      > trace_event_raw_event_workqueue_execute_start+0x50/0xa0
>      > [103376.536162]  [] __alloc_pages_nodemask+0x1fe/0x260
>      > [103376.536177]  [] alloc_pages_current+0x95/0x140
>      > [103376.536179]  [] kmalloc_order+0x18/0x40
>      > [103376.536180]  [] kmalloc_order_trace+0x24/0xa0
>      > [103376.536193]  [] __kmalloc+0x1ed/0x200
>      > [103376.536206]  [] create_instance+0x4b/0x80
>      > [103376.536208]  [] __rtdm_dev_open+0xa4/0x250
>      > [103376.536221]  [] ? cobalt_copy_to_user+0x70/0x70
>      > [103376.536222]  [] CoBaLt_open+0x2a/0x40
>      > [103376.536224]  [] ipipe_syscall_hook+0x114/0x320
>      > [103376.536247]  [] __ipipe_notify_syscall+0xbf/0x170
>      > [103376.536249]  [] ? SyS_write+0x79/0xc0
>      > [103376.536505]  [] pipeline_syscall+0x8/0x1b
>      > [103376.536540] ---[ end trace 41f9f284a6c92035 ]---
>      >
> 
>     -- 
>     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>     Corporate Competence Center Embedded Linux
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

