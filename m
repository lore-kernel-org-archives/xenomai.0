Message-ID: <d2635287-9ab0-180c-24f6-a6d5be950f0e@siemens.com>
Date: Tue, 19 Apr 2022 12:54:54 +0200
MIME-Version: 1.0
Subject: Re: Machine freezes under Ubuntu 20.04
Content-Language: en-US
References: <CAMMcbao60ib7YVUDsD5FD=J7aTCzsTAsG3ggUc7vXPHvbvd5uw@mail.gmail.com>
 <8e029de8-dac5-5788-c28b-1d20736ef494@siemens.com>
 <CAMMcbaoNMZWSk=UED8cCk=ToPFPeNq3Abx=KwCyPhL9Zbx9CYQ@mail.gmail.com>
 <498375c5-740c-23c5-0570-cf9b6b91e957@siemens.com>
 <CAMMcbapNQzaDHKEdSWJ2awZrZ3y7j23Lq1U=7k1pPwy8pz3BOA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAMMcbapNQzaDHKEdSWJ2awZrZ3y7j23Lq1U=7k1pPwy8pz3BOA@mail.gmail.com>
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
To: Arturo Laurenzi <arturo.laurenzi@gmail.com>
Cc: xenomai@xenomai.org

On 19.04.22 12:02, Arturo Laurenzi wrote:
> Sorry for the delayed answer, it took us some time to instrument our
> setup for broadcasting the kernel output over serial,
> and now we have some interesting results.
> See below.
> 
>> On 05.04.22 15:43, Arturo Laurenzi wrote:
>>>> On 04.04.22 15:21, Arturo Laurenzi via Xenomai wrote:
>>>
>>>>>
>>>>> Recently, we have started a transition towards Ubuntu 20.04, and things
>>>>> have started to break.
>>>>>
>>>>> The first attempt was to install kernel 5.4.151 and stick to ipipe. Under
>>>>> this setup, we experience issues even before starting our applications. We
>>>>> have seen random crashes while compiling with GCC, sporadic "System Program
>>>>> Problem Detected" popups by Ubuntu, and others. We even tried to re-install
>>>>> OS and kernel from scratch with no luck.
>>>>
>>>> A reference setup for this kernel line can be found in xenomai-images
>>>> (https://source.denx.de/Xenomai/xenomai-images). Would be good to
>>>> understand which deviation from it makes the difference for which
>>>> component (see also further questions below).
>>>
>>> I'm attaching the config we're using (from /boot/config-$(uname -r)).
>>> If that makes sense, we're going to try to configure the kernel
>>> according to this file
>>> (https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/files/amd64_defconfig).
>>> What kernel version do you recommend to try?
>>>
>>
>> Always the latest of the individual kernel series.
> 
> We still have to test the reference .config file, as we gave higher
> priority to the kernel output over serial stuff.
> 
>>>>>
>>>>> The second attempt was to stick to our old kernel 4.19.140. All the weird
>>>>> issues disappear and the system is stable. However, we are unable to have
>>>>> the system pass our suite of "stress tests", which basically involve starting,
>>>>> running, and killing process B multiple times in a cyclic fashion, while
>>>>> process A runs in the background. After a short while (minutes), the whole
>>>>> system just hangs, forcing us to do an hard reset. Only once, we managed to
>>>>> get this kernel oops after rebooting (journalctl -k -b -1 --no-pager).
>>>>>
>>>>
>>>> For reliably recording crashes, it is highly recommended to use a UART
>>>> as kernel debug output.
>>>
>>> Will do ASAP and let you know.
> 
> Done, see below.
> 
>>>>> The third attempt was to try out kernel 5.10.89 plus the new dovetail
>>>>> patch, and Xenomai v3.2.1. Again, all the weird issues are gone and the
>>>>> system is stable. However, we are unable to have the system pass our suite
>>>>> of "stress tests". Differently from 4.19-ipipe, the system resists for a
>>>>> longer time before hanging (few hours sometimes), but this also varies a
>>>>> lot.
>>>>>
>>>>> After some more investigation, we found out something interesting. By
>>>>> removing the code that interacts with Process A, Process B is then able to
>>>>> run "forever" (overnight at least), but *only if Process A is not running*.
>>>>> Otherwise, the system will hang. In other words, the mere presence of
>>>>> Process A is affecting Process B, even though both IDDP and ZMQ have been
>>>>> removed from B and replaced with fake data. Furthermore, the system does
>>>>> not freeze if we set B1's scheduling policy to SCHED_OTHER.
>>>>
>>>> Do you have the Xenomai watchdog enabled, thus will you be able to tell
>>>> RT application "hangs" (infinite loop at high prio) apart from real
>>>> hangs/crashes?
>>>
>>> Yes. When we try a while(true) inside a RT context, we see the
>>> watchdog killing our application
>>> as expected.
>>>
>>>
>>>>>
>>>>> From these - rather heuristic - tests, it looks like there could be some
>>>>> coupling between unrelated processes which causes some sort of bug, that is
>>>>> probably related to some interaction with mutexes/condvars, when these are
>>>>> used from a RT context. This issue shows up (or at least we have seen it)
>>>>> only under Ubuntu 20.04 (GCC 9.x), whereas a 18.04 build (GCC 7.x) looks
>>>>> fine.
>>>>
>>>> Ubuntu toolchains are known for agressively enabling certain security
>>>> features. Maybe one that we didn't check yet flipped between 18.04 and
>>>> 20.04 - if that switch is only difference between working and
>>>> non-working builds in your case. GCC itself should be fine, we are
>>>> testing with gcc-10 via Debian 11 in our CI.
>>>>
>>>> Can you check whether the toolchain change breaks the kernel (kernel
>>>> with old toolchain runs fine with userspace built via new toolchain)?
>>>
>>> We have tried this, and still the system freezes after a while. We
>>> followed the procedure that follows:
>>>  1) generate binaries for our "working" kernel 4.19.140-xeno-ipipe-3.1
>>> on a Ubuntu 18 machine (make deb-pkg)
>>>  2) copy the whole /usr/xenomai directory (compiled with the 18.04
>>> toolchain) to the test machine with Ubuntu 20.04
>>>  3) install the kernel binaries to the test machine
>>>  4) re-compile our application
>>> Is this ok?
>>>
>>
>> Wait, these are three variables: kernel, Xenomai application and Ubuntu
>> userspace. Does your system also break when using both kernel and
>> application binaries from a Ubuntu 18 build? Or will it start to break
>> once you recompile the Xenomai application with Ubuntu 20 toolchain?
> 
> Also this needs further investigation. Right now we're focusing on
> 5.10-dovetail + Xenomai 3.2 + application all built under
> the default 20.04 toolchain.
> 
>>>>>
>>>>> The purpose of this message is twofold.
>>>>> First, to see if these symptoms might "ring a bell" to anyone in the
>>>>> community, who might be able to suggest a fix.
>>>>> Second, we'd like to ask what you would do to debug this issue. Which tool
>>>>> could we use to trace what's going on, considering that whatever the bug
>>>>> is, it leads to a state where the machine is not usable at all. We can
>>>>> share our .config files if required, and we are willing to test more
>>>>> combinations of kernel and xenomai patch or library versions upon your
>>>>> advice. Any help you can give us is greatly appreciated.
>>>>>
>>>>
>>>> Can you simplify your test case to a level that makes it sharable,
>>>> executable by third parties? Please also share your kernel .config.
>>>
>>> Will try. It's not going to be quick though, as any trial we make
>>> needs hours of testing to understand if it causes a system freeze.
>>>
>>> What is the recommended to trace/debug this kind of problems? Is there
>>> anything "fancier" than broadcasting kernel output over a serial port?
>>>
>>
>> Hard to say in general. Full system freezes can be tricky to debug
>> unless there are at least some hints provided by the kernel. That's why
>> the focus is first on validating that.
> 
> In this regard, we managed to produce a stack trace via serial port.
> This is obtained on 5.10-dovetail + Xenomai 3.2 + application all
> built under
> the default 20.04 toolchain. This happens consistently in both our
> scenarios, i.e.
>  1) process A interacting with process B via IDDP and ZMQ (i.e. TCP/IP)
>  2) process A and a "modified" process B running at the same time, and
> not interacting in any way
> The stack trace is always the same (I am attaching a few examples)
> 
> [  594.117307] kernel tried to execute NX-protected page - exploit
> attempt? (uid: 1000)
> [  594.117308] BUG: unable to handle page fault for address: ffffa20908ee1b00
> [  594.117308] #PF: supervisor instruction fetch in kernel mode
> [  594.117308] #PF: error_code(0x0011) - permissions violation
> [  594.117309] PGD 44b601067 P4D 44b601067 PUD 80000001c00001e3
> [  594.117310] Oops: 0011 [#1] SMP PTI IRQ_PIPELINE
> [  594.117310] CPU: 1 PID: 34507 Comm: xbot2-core Not tainted
> 5.10.89-xeno-ipipe-3.1+ #1
> [  594.117311] Hardware name:  /TS175, BIOS BQKLR112 07/04/2017
> [  594.117311] IRQ stage: Linux
> [  594.117311] RIP: 0010:0xffffa20908ee1b00
> [  594.117312] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 <02> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0
> [  594.117312] RSP: 0018:ffffa37b8003cf80 EFLAGS: 00010202
> [  594.117313] RAX: ffffffff84cb1d29 RBX: ffffa37b89e8bd98 RCX: 00000000cd46ea8f
> [  594.117313] RDX: ffffa37b89e8bda0 RSI: ffffa20b9fc40000 RDI: ffffa37b89e8bd98
> [  594.117314] RBP: ffffffff84d10064 R08: ffffa2084005d800 R09: 0000000000000001
> [  594.117314] R10: 0000000000000001 R11: 0000000000000001 R12: 000000000000001e
> [  594.117314] R13: 000000000000001c R14: 0000000000000000 R15: 0000000000000024
> [  594.117315] FS:  00007fef2c191600(0000) GS:ffffa20b9fc40000(0000)
> knlGS:0000000000000000
> [  594.117315] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  594.117316] CR2: ffffa20908ee1b00 CR3: 000000010095e003 CR4: 00000000003706e0
> [  594.117316] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  594.117316] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  594.117317] Call Trace:
> [  594.117317]  <IRQ>
> [  594.117317]  ? irq_work_run_list+0x32/0x40
> [  594.117317]  ? irq_work_run+0x18/0x30
> [  594.117318]  ? inband_work_interrupt+0x9/0x10
> [  594.117318]  ? handle_synthetic_irq+0x59/0x80
> [  594.117318]  ? asm_call_irq_on_stack+0x12/0x20
> [  594.117319]  </IRQ>
> [  594.117319]  ? arch_do_IRQ_pipelined+0xc2/0x150
> [  594.117319]  ? sync_current_irq_stage+0x1ae/0x230
> [  594.117320]  ? __inband_irq_enable+0x47/0x50
> [  594.117320]  ? inband_irq_restore+0x21/0x30
> [  594.117320]  ? _raw_spin_unlock_irqrestore+0x1d/0x20
> [  594.117320]  ? __set_cpus_allowed_ptr+0xa2/0x200
> [  594.117321]  ? sched_setaffinity+0x1b7/0x2a0
> [  594.117321]  ? __x64_sys_sched_setaffinity+0x4e/0x90
> [  594.117321]  ? do_syscall_64+0x44/0xa0
> [  594.117322]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9

The call-stack is not reported as fully reliable. Are you running with
CONFIG_DEBUG_INFO=y? Do you have CONFIG_UNWINDER_ORC=y?

Assuming it is reliable, we may try to run some irq-work that no longer
exists. But that's speculation.

What may help here is ftrace dump on panic, see
https://www.kernel.org/doc/html/latest/admin-guide/sysctl/kernel.html#ftrace-dump-on-oops

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

