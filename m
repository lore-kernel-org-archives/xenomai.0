References: <ff7b3efb-7fb7-a26a-7412-953076de6ce6@siemens.com>
 <6a4b8afd-0e6a-e2e7-ed24-7650a4d742bf@xenomai.org>
 <51da76cf-b6ee-9943-26e8-c91db5cb6b7f@siemens.com>
 <5fedac20-47d9-7617-a9d6-a38a351ae2ad@xenomai.org>
 <fc7bbd5c-796b-954a-e1b5-42c0cecd0291@siemens.com>
 <fab389a7-81c8-3fd4-3d3a-d30433395c5f@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <10ea5fa1-e78b-e566-d3c9-183a6ee32956@siemens.com>
Date: Fri, 15 Dec 2017 18:53:25 +0100
MIME-Version: 1.0
In-Reply-To: <fab389a7-81c8-3fd4-3d3a-d30433395c5f@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe: 4.4 BUG on x86, maybe on 4.9 as well
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2017-12-15 17:45, Philippe Gerum wrote:
> On 12/15/2017 04:02 PM, Jan Kiszka wrote:
>> On 2017-12-15 15:44, Philippe Gerum wrote:
>>> On 12/15/2017 03:24 PM, Jan Kiszka wrote:
>>>> On 2017-12-14 20:44, Philippe Gerum wrote:
>>>>> On 12/14/2017 08:28 PM, Jan Kiszka wrote:
>>>>>> Hi Philippe,
>>>>>>
>>>>>> something got broken with the exception path rework:
>>>>>>
>>>>>> [    2.619458] debug: unmapping init [mem 0xffffffff81b43000-0xffffffff81ee5fff]
>>>>>> [    2.622011] BUG: using __this_cpu_read() in preemptible [00000000] code: init/1
>>>>>> [    2.623446] caller is __this_cpu_preempt_check+0x13/0x20
>>>>>> [    2.624724] CPU: 2 PID: 1 Comm: init Not tainted 4.4.105+ #689
>>>>>> [    2.626073] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
>>>>>> [    2.628911] I-pipe domain: Linux
>>>>>> [    2.630083]  ffffffff81993439 ffff88003fb43c10 ffffffff813afa45 0000000000000002
>>>>>> [    2.631427]  ffff88003fb38000 ffff88003fb43c50 ffffffff813db5eb ffffffff82c57340
>>>>>> [    2.631427]  ffff88003fb43c98 0000000000000002 ffff88003fb44000 0000000000000000
>>>>>> [    2.631427] Call Trace:
>>>>>> [    2.631427]  [<ffffffff813afa45>] dump_stack+0xb2/0xdd
>>>>>> [    2.631427]  [<ffffffff813db5eb>] check_preemption_disabled+0x17b/0x1c0
>>>>>> [    2.631427]  [<ffffffff813db663>] __this_cpu_preempt_check+0x13/0x20
>>>>>> [    2.631427]  [<ffffffff8104eb1f>] do_page_fault+0x3f/0x60
>>>>>> [    2.631427]  [<ffffffff8170f8b7>] page_fault+0x27/0x60
>>>>>> [    2.631427]  [<ffffffff813bcef2>] ? __clear_user+0x42/0x70
>>>>>> [    2.631427]  [<ffffffff813bcf69>] clear_user+0x49/0x80
>>>>>> [    2.631427]  [<ffffffff812727d4>] padzero+0x24/0x40
>>>>>> [    2.631427]  [<ffffffff81274bfe>] load_elf_binary+0x8fe/0x10f0
>>>>>> [    2.631427]  [<ffffffff81116ee8>] ? ipipe_unstall_root+0x58/0x90
>>>>>> [    2.631427]  [<ffffffff812222c7>] search_binary_handler+0x97/0x1d0
>>>>>> [    2.631427]  [<ffffffff81223b86>] do_execveat_common.isra.40+0x5d6/0x7e0
>>>>>> [    2.631427]  [<ffffffff81223aff>] ? do_execveat_common.isra.40+0x54f/0x7e0
>>>>>> [    2.631427]  [<ffffffff8122bb00>] ? path_openat+0x1440/0x14e0
>>>>>> [    2.631427]  [<ffffffff816fff20>] ? rest_init+0xd0/0xd0
>>>>>> [    2.631427]  [<ffffffff81223dbc>] do_execve+0x2c/0x30
>>>>>> [    2.631427]  [<ffffffff810002eb>] run_init_process+0x2b/0x30
>>>>>> [    2.631427]  [<ffffffff816fff5d>] kernel_init+0x3d/0xe0
>>>>>> [    2.631427]  [<ffffffff8170d4c0>] ret_from_fork+0x40/0x70
>>>>>> [    2.631427]  [<ffffffff816fff20>] ? rest_init+0xd0/0xd0
>>>>>>
>>>>>> Unless you have some immediate idea, I will debug this tomorrow. Issue
>>>>>> disappears when I revert the related patches in the ipipe queue.
>>>>>>
>>>>>
>>>>> Issue may be in the changes affecting IPIPE_DO_TRAP() [4e180c151]. The
>>>>> sequence used to be prologue -> handler -> restore_root, it is now
>>>>> prologue -> restore_root -> handler, which basically means that the
>>>>> stall bit fixup is no more, ... a fixup.
>>>>
>>>> Right, this is broken. The previous code was well matured, it just
>>>> excluded the case int3 for dyn-ftrace, kprobe etc. so far.
>>>>
>>>
>>> Actually, the code was broken with int3 as issued by ftrace. This is
>>> what triggered the change.
>>
>> Nope, you just had to turn those things off. We may have missed some
>> Kconfig dependencies, true, but we never supported code patching like
>> for dyn-ftrace, jump labels, or similar things. We should, but it's not
>> trivial as we see.
>>
>>>
>>>> While gaining that support would be valuable, I would still recommend to
>>>> revert the changes for now and redesign the int3 handling carefully on top.
>>>>
>>>
>>> We should not be that far from a proper implementation. I'd like to try
>>> the kvm config that shows the issue. Is there any way to reproduce this
>>> easily?
>>
>> CONFIG_DEBUG_*. I've attached mine. One key aspect is that the fixup
>> must run *after* the Linux handler. This is now broken.
>>
>> Look, I've debugged that stuff more than once, and it took quite some
>> effort and multiple attempts until we ended up with the current stable
>> version. We should work on top of that to enable code patching via int3,
>> very carefully and with good explanations (you can find my attempts for
>> the current version also in git). And that's why we should revert first.
>>
> 
> Absolutely no issue with that, I'll revert those patches and let the
> I-pipe/x86 maintainers tackle that stuff. I can live with a separate
> branch anyway.

Thanks. But you probably don't need a branch of your own for using
ftrace, just this for now:

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 834e6117f5f8..b9f6121c8530 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -83,7 +83,7 @@ config X86
 	select HAVE_AOUT			if X86_32
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
-	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL		if !IPIPE
 	select HAVE_ARCH_KASAN			if X86_64 && SPARSEMEM_VMEMMAP
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_KMEMCHECK


That was (effectively) what I had to explain internally as well a while
ago but forgot to push it.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

