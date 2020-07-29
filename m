Subject: Re: rt_pipe_write memory allocation bug - xenomai 3.x
References: <5adc97a4-014f-3a50-9109-4e574662cf7b@numalliance.com>
 <7f4384d6-c318-2448-99d9-bbfa7061f78e@siemens.com>
 <fc40f71f-66fd-7a2c-440f-19cbd8da8b18@iit.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a14c5832-1996-15b6-5438-ac25a9e02476@siemens.com>
Date: Thu, 30 Jul 2020 00:05:45 +0200
MIME-Version: 1.0
In-Reply-To: <fc40f71f-66fd-7a2c-440f-19cbd8da8b18@iit.it>
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
To: alessio margan <alessio.margan@iit.it>, xenomai@xenomai.org

On 28.07.20 11:17, alessio margan via Xenomai wrote:
> Hi all,
> 
> I got this , briefly
> 
> an UI_thread open 2 pipes : rd_xddp (block) wr_xddp (noblock)
> 
> an RT_thread (periodic producer)  open 2 pipes both noblock but write 
> back to UI if something is read
> 
> at a period of 1 ms it works, at 500 us no
> 
> xeno-config --verbose
>          --core=cobalt
>          --version="3.1"
>          --cc="gcc"
>          --ccld="/usr/xenomai/bin/wrap-link.sh gcc"
>          --arch="x86"
>          --prefix="/usr/xenomai"
>          --library-dir="/usr/xenomai/lib"
> 
> [Xenomai] switching RT_thread to secondary mode after exception #14 in 
> kernel-space at 0xffffffffad130635 (pid 1151)
> [  280.564579] BUG: unable to handle kernel paging request at 
> ffff9abb6ad9b326
> [  280.564585] PGD 23c201067 P4D 23c201067 PUD 0
> [  280.564589] Oops: 0000 [#1] SMP PTI
> [  280.564593] CPU: 0 PID: 1151 Comm: RT_thread Not tainted 
> 4.19.89-xeno-ipipe-3.1 #1
> [  280.564597] Hardware name: Default string Default string/SKYBAY, BIOS 
> 5.11 01/29/2016
> [  280.564600] I-pipe domain: Linux
> [  280.564607] RIP: 0010:xnheap_free+0xd5/0x290
> [  280.564610] Code: 4d 89 e8 48 8b 13 41 83 e0 02 48 8b 75 c0 4c 8b 5b 
> 18 48 29 d6 49 89 f1 49 c1 e9 09 49 63 c1 48 8d 3c 40 48 c1 e7 02 49 01 
> fb <41> 0f b7 43 06 66 c1 e8 07 83 e0 3f 3c 02 44 0f b6 d0 0f 84 f8 00
> [  280.564618] RSP: 0018:ffffb0f40275fb70 EFLAGS: 00010283
> [  280.564621] RAX: ffffffff85ff7998 RBX: ffffffffae0f2fc0 RCX: 
> ffffffffadb3b607
> [  280.564624] RDX: ffffb0f4010cd000 RSI: 00004f0bfef33000 RDI: 
> fffffffa47f9b320
> [  280.564628] RBP: ffffb0f40275fbb0 R08: 0000000000000000 R09: 
> 0000002785ff7998
> [  280.564631] R10: 000000c5beb58919 R11: ffff9abb6ad9b320 R12: 
> 000000000005f140
> [  280.564635] R13: 0000000000000000 R14: ffffffffae0f3028 R15: 
> 0000000000000000
> [  280.564638] FS:  00007f6de79ef700(0000) GS:ffff9ac127400000(0000) 
> knlGS:0000000000000000
> [  280.564642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  280.564646] CR2: ffff9abb6ad9b326 CR3: 0000000264e12005 CR4: 
> 00000000003606f0
> [  280.564649] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  280.564653] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [  280.564656] Call Trace:
> [  280.564664]  __xddp_recvmsg+0x203/0x480
> [  280.564669]  ? __switch_to_asm+0x41/0x70
> [  280.564672]  ? __switch_to_asm+0x35/0x70
> [  280.564675]  ? __switch_to_asm+0x41/0x70
> [  280.564678]  ? __switch_to_asm+0x35/0x70
> [  280.564681]  ? __switch_to_asm+0x41/0x70
> [  280.564684]  ? __switch_to_asm+0x35/0x70
> [  280.564687]  ? __switch_to_asm+0x41/0x70
> [  280.564690]  ? __switch_to_asm+0x35/0x70
> [  280.564693]  ? __switch_to_asm+0x41/0x70
> [  280.564696]  ? __switch_to_asm+0x35/0x70
> [  280.564699]  ? __switch_to_asm+0x41/0x70
> [  280.564702]  ? __switch_to_asm+0x35/0x70
> [  280.564705]  ? __switch_to_asm+0x41/0x70
> [  280.564708]  ? __switch_to_asm+0x35/0x70
> [  280.564711]  ? __switch_to_asm+0x41/0x70
> [  280.564714]  xddp_recvmsg+0xc5/0x160
> [  280.564718]  ? ___xnsched_run+0x27a/0x4a0
> [  280.564721]  ? __switch_to_asm+0x41/0x70
> [  280.564725]  ? xnthread_suspend+0x40a/0x570
> [  280.564728]  ? __switch_to_asm+0x35/0x70
> [  280.564731]  ? __switch_to_asm+0x41/0x70
> [  280.564734]  ? __switch_to_asm+0x35/0x70
> [  280.564737]  ? __switch_to_asm+0x41/0x70
> [  280.564742]  ? __put_fd+0x262/0x2d0
> [  280.564745]  ? ipipe_timer_set+0x5f/0x70
> [  280.564748]  ? rtdm_fd_get+0x1bc/0x220
> [  280.564752]  rtipc_recvmsg+0x11/0x20
> [  280.564755]  rtdm_fd_recvmsg+0x6e/0xc0
> [  280.564759]  CoBaLt_recvmsg+0x68/0xd0
> [  280.564761]  ? CoBaLt_write+0x10/0x10
> [  280.564767]  handle_head_syscall+0xe0/0x2f0
> [  280.564770]  ipipe_fastcall_hook+0x13/0x20
> [  280.564773]  ipipe_handle_syscall+0x4b/0xb0
> [  280.564777]  do_syscall_64+0x2e/0x250
> [  280.564780]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  280.564783] RIP: 0033:0x7f6de79b2e71
> [  280.564786] Code: 89 f5 53 89 fb bf 01 00 00 00 48 83 ec 10 48 8d 74 
> 24 0c e8 01 b3 ff ff b9 53 00 00 10 48 63 fb 49 63 d4 48 89 ee 89 c8 0f 
> 05 <8b> 7c 24 0c 31 f6 48 89 c3 e8 e1 b2 ff ff 48 83 c4 10 48 63 c3 5b
> [  280.564794] RSP: 002b:00007f6de79eec30 EFLAGS: 00000206 ORIG_RAX: 
> 0000000010000053
> [  280.564798] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 
> 00007f6de79b2e71
> [  280.564801] RDX: 0000000000000040 RSI: 00007f6de79eec80 RDI: 
> 0000000000000004
> [  280.564805] RBP: 00007f6de79eec80 R08: 0000000000000000 R09: 
> 0000000000000000
> [  280.564808] R10: 00005587dae90c58 R11: 0000000000000206 R12: 
> 0000000000000040
> [  280.564812] R13: 0000000000000004 R14: 00007f6de79eed1c R15: 
> 0000000000000004
> [  280.564816] Modules linked in: ctr ccm rtpacket binfmt_misc arc4 
> iwldvm mac80211 iwlwifi i915 i2c_algo_bit ftdi_sio drm_kms_helper 
> usbserial cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt 
> fb_sys_fops cfbcopyarea rt_e1000e fb x86_pkg_temp_thermal 
> intel_powerclamp font fbdev crc32c_intel rtnet drm cfg80211 
> drm_panel_orientation_quirks intel_pch_thermal evdev video button btusb 
> btrtl btbcm btintel bluetooth jitterentropy_rng hmac drbg ecdh_generic 
> nfsd auth_rpcgss nfs_acl lockd grace loop sunrpc autofs4 ahci e1000e 
> libahci ptp xhci_pci i2c_i801 pps_core xhci_hcd libata usbcore 
> usb_common fan
> [  280.564855] CR2: ffff9abb6ad9b326
> [  280.564858] ---[ end trace 73a21e5dbd797a64 ]---
> [  280.564863] RIP: 0010:xnheap_free+0xd5/0x290
> [  280.564866] Code: 4d 89 e8 48 8b 13 41 83 e0 02 48 8b 75 c0 4c 8b 5b 
> 18 48 29 d6 49 89 f1 49 c1 e9 09 49 63 c1 48 8d 3c 40 48 c1 e7 02 49 01 
> fb <41> 0f b7 43 06 66 c1 e8 07 83 e0 3f 3c 02 44 0f b6 d0 0f 84 f8 00
> [  280.564873] RSP: 0018:ffffb0f40275fb70 EFLAGS: 00010283
> [  280.564877] RAX: ffffffff85ff7998 RBX: ffffffffae0f2fc0 RCX: 
> ffffffffadb3b607
> [  280.564880] RDX: ffffb0f4010cd000 RSI: 00004f0bfef33000 RDI: 
> fffffffa47f9b320
> [  280.564884] RBP: ffffb0f40275fbb0 R08: 0000000000000000 R09: 
> 0000002785ff7998
> [  280.564887] R10: 000000c5beb58919 R11: ffff9abb6ad9b320 R12: 
> 000000000005f140
> [  280.564891] R13: 0000000000000000 R14: ffffffffae0f3028 R15: 
> 0000000000000000
> [  280.564894] FS:  00007f6de79ef700(0000) GS:ffff9ac127400000(0000) 
> knlGS:0000000000000000
> [  280.564898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  280.564901] CR2: ffff9abb6ad9b326 CR3: 0000000264e12005 CR4: 
> 00000000003606f0
> [  280.564905] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  280.564908] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> 

Can you refactor your reproduction case to compile and work stand-alone? 
I would need something I can through into my debugging environment to 
retrigger such a crash.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

