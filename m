From: Peter Soetens <peter.soetens@domain.hid>
Date: Fri, 7 Sep 2007 11:27:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709071127.17913.peter.soetens@domain.hid>
Subject: [Xenomai-core] Summary: Xenomai 2.3.2 and 2.4 lock-ups and OOPSes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Just in case you hooked off the long discussion about the issues we found from
Xenomai 2.3.2 on:

  o We are using the xeno_native skin, create Xeno tasks and semaphores, but 
have strong indications that the crashes are caused by the memory allocation 
scheme of Xenomai in combination with task creation/deletion
  o We found two ways to break Xenomai, causing a 'Killed' (rt_task_delete) 
and causing an OOPS (rt_task_join).
  o They happen on 2.6.20 and 2.6.22 kernels
  o On the 2.3 branch, r2429 works, r2433 causes the faults. The patch is 
small, and in the ChangLog: 

2007-05-11  Philippe Gerum  <rpm@xenomai.org>

    * include/nucleus/heap.h (xnfreesafe): Use xnpod_current_p() when
    checking for deferral.

    * include/nucleus/pod.h (xnpod_current_p): Give exec mode
    awareness to this predicate, checking for primary/secondary mode
    of shadows.

2007-05-11  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>

    * ksrc/skins: Always defer thread memory release in deletion hook
    by calling xnheap_schedule_free() instead of xnfreesafe().

  o We reverted this patch on HEAD of the 2.3 branch, but got -ENOMEM errors 
during Xenomai resource allocations, indicating that later changes depend on 
this patch. So we use clean HEAD again further on to find the causes:
 o A first test (in Orocos) creates one thread, two semaphores, lets it wait 
on them and cleans up the thread.
 o During rt_task_delete, our program gets 'Killed' (without joinable thread), 
hence a user space problem. However, gdb is of no use, all thread info is 
lost.
 o We made the thread joinable (T_JOINABLE), and then joined. This bypassed 
the Kill on the first run but causes an OOPS the second time the same 
application is started:

Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<fef4a1f3>]    Not tainted VLI
EFLAGS: 00010002   (2.6.20.9-ipipe-1.8-08 #2)
EIP is at get_free_range+0x56/0x160 [xeno_nucleus]
eax: f3a81d01   ebx: 00000200   ecx: 55550101   edx: fef62b00
esi: 55550101   edi: 00000200   ebp: f0f33ec4   esp: f0f33e98
ds: 007b   es: 007b   ss: 0068
Process NonPeriodicActi (pid: 3020, ti=f0f32000 task=f7ce61b0 
task.ti=f0f32000)
Stack: 00000000 00000600 fef62b80 f3a81b24 f3a80000 fef62ba4 f3a80720 55550101
       00000600 f0f33f18 f7ce6360 f0f33ee4 fef4a948 fef62b80 f0f33f08 00000000
       00000400 f0f33f18 f7ce6360 f0f33f50 ff13e1de 00000282 00000282 bfab6350
Call Trace:
 [<c0103ffb>] show_trace_log_lvl+0x1f/0x35
 [<c01040bb>] show_stack_log_lvl+0xaa/0xcf
 [<c01042a9>] show_registers+0x1c9/0x392
 [<c0104588>] die+0x116/0x245
 [<c0110fca>] do_page_fault+0x287/0x61d
 [<c010ea35>] __ipipe_handle_exception+0x63/0x136
 [<c029466d>] error_code+0x79/0x88
 [<fef4a948>] xnheap_alloc+0x15b/0x17d [xeno_nucleus]
 [<ff13e1de>] __rt_task_create+0xe0/0x171 [xeno_native]
 [<fef5655f>] losyscall_event+0xaf/0x170 [xeno_nucleus]
 [<c0138804>] __ipipe_dispatch_event+0xc0/0x1da
 [<c010e90b>] __ipipe_syscall_root+0x43/0x10a
 [<c0102e79>] system_call+0x29/0x41
 =======================
Code: 74 61 85 c0 74 5d c7 45 e0 00 00 00 00 8b 4d e4 8b 49 10 89 4d ec 85 c9 
74 38 8b 45 dc 8b 78 0c 89 4d f0 89 ce 89 fb eb 02 89 ce <8b> 09 8d 04 3e 39 
c1 0f 94 c2 3b 5d d8 0f 92 c0 01 fb 84 c2 75
EIP: [<fef4a1f3>] get_free_range+0x56/0x160 [xeno_nucleus] SS:ESP 
0068:f0f33e98
[hard lockup]

  o Our application is also mixing the original RT_TASK struct and return 
value of the rt_task_self() function call when calling rt_ functions. 
Switching between one of those influences the crashing behaviour as well, not 
further investigated.

  o This was reproduced on two different systems (one with SMI workaround 
working)
 
You have the patch that broke things, I hope this gives you a hint on what 
causes our crashes. Know that Orocos as-is has worked with Xenomai from  
Xenomai 2.0 on.

Peter

-- 
Peter Soetens -- FMTC -- <http://www.fmtc.be>

