Message-ID: <50e17aa8-9433-d852-3c34-e683ef271f28@siemens.com>
Date: Thu, 10 Feb 2022 16:59:22 +0100
MIME-Version: 1.0
Subject: Re: [External] - Re: DMA with EVL-attached Thread
Content-Language: en-US
References: <PH1P110MB1050206F44482CA7558806AEE22E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <e2b5135e-fffe-8aea-8525-4a1dd798d485@siemens.com>
 <PH1P110MB10504449ED970CBB975537CEE22F9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PH1P110MB10504449ED970CBB975537CEE22F9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Russell Johnson <russell.johnson@kratosdefense.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10.02.22 16:33, Russell Johnson wrote:
> Can a real-time userspace thread that has been attached to EVL make standard ioctl() calls on a Linux driver? If so, what would any disadvantage be?

Just like under classic Xenomai, you can trigger non-RT activities from
RT tasks, but those tasks will then first of all fall out of the oob
context. But as you usually do such resource management calls only
during setup/cleanup, that should be fine. More thoughts are needed if
you call it today in the critical loop of a task.

Jan

> 
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com> 
> Sent: Wednesday, February 9, 2022 11:29 PM
> To: Russell Johnson <russell.johnson@kratosdefense.com>; xenomai@xenomai.org
> Subject: [External] - Re: DMA with EVL-attached Thread
> 
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On 10.02.22 00:00, Russell Johnson via Xenomai wrote:
>> Hello,
>>
>> I currently have a DMA driver written based on the Linux DMA API found here: https://www.kernel.org/doc/Documentation/DMA-API-HOWTO.txt . I have multiple realtime threads in my userspace app that have to make constant DMA transfers. I have not seen any issue with DMA throughput using the Linux API. The question is, do I need to re-architect the dma driver to add in the oob_ioctl() FD so that a userspace EVL attached thread can use it? If the answer is yes, I have experimented a bit with doing that and ran into an issue. I have created a userspace test app with a thread attached to EVL and attempted to allocate, write, read, and free a dma buffer from the driver I modified with the oob_ioctl() FD. Alloc, write, and read all appear to work fine. However, calling free (which boils down to the kernel call "dma_free_coherent" is throwing a warning in the console:
>>
>> [75787.696762] ------------[ cut here ]------------ [75787.696763] 
>> WARNING: CPU: 9 PID: 25074 at kernel/dma/mapping.c:532 
>> dma_free_attrs+0x40/0x90 [75787.696772] Modules linked in: dma_buf_mgr(OE) xfs libcrc32c sr_mod sd_mod cdrom t10_pi ast drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm ixgbe ahci libahci igb libata mdio crc32c_intel ptp pps_core i2c_algo_bit dca [last unloaded: dma_buf_mgr]
>> [75787.696793] CPU: 9 PID: 25074 Comm: test_thread:250 Tainted: G        W  OE     5.15.0evl+ #6
>> [75787.696796] Hardware name: Supermicro Super Server/X10SDV-6C-TLN4F, 
>> BIOS 1.3 02/13/2018 [75787.696797] IRQ stage: EVL [75787.696799] RIP: 
>> 0010:dma_free_attrs+0x40/0x90 [75787.696802] Code: 89 fc 53 48 83 ec 
>> 08 48 8b 9f 38 02 00 00 4c 89 45 d0 48 85 db 48 0f 44 1d 4d ce 8b 01 
>> e8 88 23 80 00 85 c0 4c 8b 45 d0 74 02 <0f> 0b 4d 85 ed 74 16 48 85 db 
>> 75 20 4c 89 f9 4c 89 ea 4c 89 f6 4c [75787.696804] RSP: 
>> 0018:ffffb3fd40747d48 EFLAGS: 00010202 [75787.696807] RAX: 
>> 0000000000000001 RBX: 0000000000000000 RCX: 00000000798fa000 
>> [75787.696809] RDX: ffff8dda798fa000 RSI: 0000000000000400 RDI: 
>> ffff8ddb01b2f0d0 [75787.696810] RBP: ffffb3fd40747d78 R08: 
>> 0000000000000000 R09: 00080000000000ff [75787.696811] R10: 
>> 00000000807eb2a2 R11: 0000000000000033 R12: ffff8ddb01b2f0d0 
>> [75787.696813] R13: ffff8dda798fa000 R14: 0000000000000400 R15: 
>> 00000000798fa000 [75787.696814] FS:  00007f355a0d7700(0000) 
>> GS:ffff8dde6d880000(0000) knlGS:0000000000000000 [75787.696816] CS:  
>> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [75787.696818] CR2: 0000000000000000 CR3: 00000001b5448001 CR4: 00000000003706e0 [75787.696819] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 [75787.696820] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 [75787.696822] Call Trace:
>> [75787.696826]  free_dma_buf+0x5d/0xb0 [dma_buf_mgr] [75787.696831]  
>> dma_buf_mgr_oob_ioctl+0x159/0x396 [dma_buf_mgr] [75787.696835]  
>> EVL_ioctl+0x46/0xa0 [75787.696841]  
>> handle_pipelined_syscall+0x181/0x2d0
>> [75787.696846]  __pipeline_syscall+0xbc/0x230 [75787.696851]  ? 
>> sched_clock+0x9/0x10 [75787.696856]  pipeline_syscall+0x34/0x100 
>> [75787.696860]  syscall_enter_from_user_mode+0x39/0xf0
>> [75787.696865]  do_syscall_64+0x15/0xa0 [75787.696867]  
>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [75787.696872] RIP: 0033:0x7f355b0f2f9b [75787.696874] Code: Unable to 
>> access opcode bytes at RIP 0x7f355b0f2f71.
>> [75787.696875] RSP: 002b:00007f355a0d6860 EFLAGS: 00000246 ORIG_RAX: 
>> 000000000000009d [75787.696877] RAX: ffffffffffffffda RBX: 
>> 00007f355a0d6900 RCX: 00007f355b0f2f9b [75787.696878] RDX: 
>> 0000000040042501 RSI: 0000000000000006 RDI: 0000000010000002 
>> [75787.696880] RBP: 0000000040042501 R08: 0000000000000000 R09: 
>> 0000000000020750 [75787.696881] R10: 00007f355a0d6900 R11: 
>> 0000000000000246 R12: 0000000000000006 [75787.696882] R13: 
>> 0000000000801000 R14: 0000000000000000 R15: 00007f355a0d7700 
>> [75787.696884] ---[ end trace 9678e85a266ff468 ]---
>>
>> This warning does not exist when running the same functionality from the normal ioctl() FD from a standard thread in Linux. Is what I am trying to do possible? If so, any clue on what I am seeing here?
> 
> Yes, classic mistake: You are calling a Linux, in-band-only function
> (free_dma_buf) from an RT, out-of-band context. That does not work.
> Linux resource management has to happen in in-band context (standard ioctl handler).
> 
> Jan
> 
> --
> Siemens AG, Technology
> Competence Center Embedded Linux


-- 
Siemens AG, Technology
Competence Center Embedded Linux

