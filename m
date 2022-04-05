Message-ID: <4c410496-a8d6-08cd-8bd2-0f2ae6f96e4d@siemens.com>
Date: Tue, 5 Apr 2022 19:39:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] xnthread_relax: Make sure wakework irq work has a stack
Content-Language: en-US
References: <20220405114052.7385-1-richard@nod.at>
 <94940f791d07b0f2e4f8594b26aa47680a024d0b.camel@siemens.com>
 <CAFLxGvzdJYiVd+ZsQ++PPcd_P1ajdDPgWe0Tpko0JAo3G5rb_A@mail.gmail.com>
 <54aa3260-9a9b-dbdb-90a8-6395fd86fc28@siemens.com>
 <1433861802.219536.1649174000463.JavaMail.zimbra@nod.at>
 <965edc40-6bae-fd91-331e-b1e59bf61a84@siemens.com>
 <835760478.219600.1649175258568.JavaMail.zimbra@nod.at>
 <1590716923.219798.1649179412883.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1590716923.219798.1649179412883.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai <xenomai@xenomai.org>

On 05.04.22 19:23, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>>> How about additionally widening the suspected race window by adding a
>>> delay to lostage_task_wakeup?
>>
>> Excellent idea! :-)
> 
> Yeah, with a dealy in lostage_task_wakeup() my WARN_ON_ONCE() triggers
> very quickly.
> 
> [  123.237698] ------------[ cut here ]------------
> [  123.238755] WARNING: CPU: 1 PID: 1411 at kernel/xenomai/thread.c:2158 xnthread_relax+0x5d4/0x680
> [  123.240698] Modules linked in: loader(OE) tun bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables xeno_can_peak_pci xeno_can_sja1000 xeno_can xeno_16550A libcrc32c nfnetlink xeno_rtipc snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sunrpc pktcdvd rt_e1000 rt_e1000_new crc32_pclmul rtnet i2c_piix4 bochs drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm e1000 serio_raw crc32c_intel ata_generic pata_acpi floppy qemu_fw_cfg fuse
> [  123.252790] CPU: 1 PID: 1411 Comm: app Tainted: G           OE     5.15.9xeno3.2-x8664G-rw #6
> [  123.255001] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [  123.257443] IRQ stage: Linux
> [  123.258090] RIP: 0010:xnthread_relax+0x5d4/0x680
> [  123.259136] Code: 18 05 00 00 e8 5d 8d 13 00 41 8b 97 18 05 00 00 48 8d b3 6c 02 00 00 48 c7 c7 a0 8f 6d 82 e8 5c 96 cc 00 0f 0b e9 9d fc ff ff <0f> 0b e9 af fd ff ff 65 44 8b 2d a5 2d ca 7e 41 83 fd 03 77 7a 45
> [  123.263163] RSP: 0018:ffff88811381fb60 EFLAGS: 00010202
> [  123.264330] RAX: 0000000000000022 RBX: ffffc90000bf6408 RCX: ffffffff8137e13b
> [  123.265893] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88811381fc18
> [  123.267474] RBP: 1ffff11022703f6e R08: ffffed1022703f84 R09: ffffed1022703f84
> [  123.269095] R10: ffff88811381fc1b R11: ffffed1022703f83 R12: ffff88811381fc10
> [  123.270662] R13: ffff888104f03e00 R14: 0000000000000000 R15: ffffc90000bf6428
> [  123.272222] FS:  00007fb4d0aca700(0000) GS:ffff88811b080000(0000) knlGS:0000000000000000
> [  123.273983] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  123.275262] CR2: 0000000000a74008 CR3: 0000000111938003 CR4: 0000000000170ea0
> [  123.276823] Call Trace:
> [  123.277401]  <TASK>
> [  123.277878]  ? xnthread_wait_period+0x4c0/0x4c0
> [  123.278899]  ? xnsynch_release+0x690/0x690
> [  123.279828]  ? __cobalt_sem_destroy+0x2dd/0x630
> [  123.280848]  ? recalibrate_cpu_khz+0x10/0x10
> [  123.281812]  ? xnthread_set_periodic+0x3a0/0x3a0
> [  123.282855]  ? recalibrate_cpu_khz+0x10/0x10
> [  123.283816]  ? ktime_get_mono_fast_ns+0xdb/0x120
> [  123.284852]  ? xnlock_dbg_release+0xd9/0x170
> [  123.285812]  prepare_for_signal+0x297/0x3a0
> [  123.286765]  ? CoBaLt_serialdbg+0x140/0x140
> [  123.287709]  ? cobalt_thread_setschedparam_ex+0x1a0/0x1a0
> [  123.288906]  handle_head_syscall+0x6e2/0x810
> [  123.289867]  ? __cobalt_cond_wait_prologue+0xf60/0xf60
> [  123.291017]  ? CoBaLt_trace+0x650/0x650
> [  123.291887]  ? cobalt_thread_setschedparam_ex+0x1a0/0x1a0
> [  123.293088]  pipeline_syscall+0x8e/0x140
> [  123.293979]  syscall_enter_from_user_mode+0x30/0x80
> [  123.295076]  do_syscall_64+0x1d/0xa0
> [  123.295895]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 

Ok, we are seeing clearer but not everything. Could you find out if work
and thread are running on different CPUs? Or, via tracing, what led to
this case otherwise?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

