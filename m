References: <de71569b-291a-afad-14f1-6f876b9cffde@siemens.com>
 <87y23s3byb.fsf@xenomai.org> <87ee5is12i.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: mm problems with 5.15.9-dovetail1
Date: Sat, 08 Jan 2022 16:36:59 +0100
In-reply-to: <87ee5is12i.fsf@xenomai.org>
Message-ID: <87a6g6s0d6.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
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


Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Hi,
>>
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> Hi Philippe,
>>>
>>> seems we have some issue with the new 5.15 dovetail kernel, see e.g.
>>>
>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/371693
>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/371694
>>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/371695
>>> (kernel BUG at mm/rmap.c:1049!)
>>>
>>> Or are there changes needed on Xenomai side?
>>
>> Nope. Plain bug I'd say. I'll have look at this in a couple of days.
>
> posix_fork is triggering the bug. The logic disabling COW for dovetailed
> tasks breaks with Cobalt over 5.15, but does not with EVL which explains
> why I did not notice earlier. Working on this.

Can you confirm this helps on your end?

Thanks,

commit 075d00feb7c2987a972aa4bc34d2a3107ec20307 (HEAD -> rebase/v5.15-dovetail)
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Sat Jan 8 16:30:24 2022 +0100

    dovetail: mm: fix logic of COW-disabling check
    
    COW-disabling for a dovetailed task does not depend on the pinning
    status of the source page considered by copy_present_page(). Decouple
    both checks, which fixes the following kernel splat on fork() from a
    dovetailed task:
    
    [   18.376448] ------------[ cut here ]------------
    [   18.376915] kernel BUG at mm/rmap.c:1049!
    [   18.377259] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI IRQ_PIPELINE
    [   18.377262] CPU: 0 PID: 121 Comm: smokey Not tainted 5.15.9+ #12
    [   18.377264] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
    [   18.377265] IRQ stage: Linux
    [   18.377266] RIP: 0010:__page_set_anon_rmap+0x59/0x70
    [   18.377271] Code: c9 74 22 48 83 c0 01 48 89 43 18 f6 47 52 40 75 1b 48 2b 17 48 c1 ea 0c 48 03 97 98 00 00 00 48 89 53 20 5b c3 48 8b 00 eb d9 <0f> 0b 48 89 d6 e8 ad c6 01 00 48 89 c2 eb e6 0f 1f 84 00 00 00 00
    [   18.377273] RSP: 0018:ffffc90000b0bb50 EFLAGS: 00010246
    [   18.377275] RAX: 0000000000000000 RBX: 000000010498f000 RCX: 0000000000000001
    [   18.377276] RDX: 00007fe623795000 RSI: ffff888102ab5398 RDI: ffffea00041263c0
    [   18.377277] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8881029da958
    [   18.377277] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888102aa3ca8
    [   18.377278] R13: ffff888102abaca8 R14: ffffea00041263c0 R15: 00007fe623795000
    [   18.377281] FS:  00007fe623815740(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
    [   18.377284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [   18.377285] CR2: 00007ffef0186000 CR3: 0000000102320000 CR4: 00000000000406f0
    [   18.377286] Call Trace:
    [   18.377287]  <TASK>
    [   18.377287]  copy_pte_range+0x646/0x8c0
    [   18.377292]  copy_pud_range+0x20a/0x2b0
    [   18.377294]  copy_page_range+0x10f/0x2e0
    [   18.377297]  ? dup_mmap+0x232/0x4e0
    [   18.377300]  dup_mmap+0x3a6/0x4e0
    [   18.377303]  dup_mm.isra.0+0x52/0xf0
    [   18.377304]  copy_process+0x169e/0x1920
    [   18.377307]  kernel_clone+0x4f/0x3e0
    [   18.377309]  ? cobalt_thread_setschedparam_ex+0x200/0x200
    [   18.377312]  ? rcu_read_lock_sched_held+0x57/0x80
    [   18.377315]  ? handle_root_syscall+0x269/0x440
    [   18.377319]  __do_sys_clone+0x52/0x60
    [   18.377321]  do_syscall_64+0x4d/0xa0
    [   18.377324]  entry_SYSCALL_64_after_hwframe+0x44/0xae
    
    Signed-off-by: Philippe Gerum <rpm@xenomai.org>

diff --git a/mm/memory.c b/mm/memory.c
index 0e3e2228f67ff8f..1c4fce2b4bdf1db 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -904,9 +904,10 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	 * process, we don't want to impose the COW-induced latency on
 	 * it: make sure the child gets its own copy of the page.
 	 */
-	if (likely(!page_needs_cow_for_dma(src_vma, page) &&
-			(!dovetailing() || !test_bit(MMF_DOVETAILED,
-						&src_vma->vm_mm->flags))))
+	if (likely(!page_needs_cow_for_dma(src_vma, page)))
+		return 1;
+
+	if (dovetailing() & test_bit(MMF_DOVETAILED, &src_vma->vm_mm->flags))
 		return 1;
 
 	new_page = *prealloc;

-- 
Philippe.

