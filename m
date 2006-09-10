Message-ID: <4503CA64.7030701@domain.hid>
Date: Sun, 10 Sep 2006 10:18:44 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: AW: [Xenomai-help] resubmission : memset of heap crashes
	Xenomai-Task
References: <5D63919D95F87E4D9D34FF7748CE2C2A4E9E80@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A4E9E80@domain.hid>
Content-Type: multipart/mixed; boundary="------------000602020700030007010109"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000602020700030007010109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] :
>> Ok. Now the question remains: does this problem still exist=20
>> with version
>> 2.2.2 ? The heaps overhead computations have changed recently.
>>
>=20
> Good news. I can=B4t reproduce the "seg. fault" with 2.2.2 although I t=
ried hard (restarted at least 20 times). Obviously the new "heap overhead=
 computations" eliminated the problem.=20
> Wolgang could you be so nice to try to reproduce the problem with 2.2.2=
, just to be sure ?

I ran heap.c plenty of times on my MPC5200 setup under Linux 2.4.25 and=20
Xenomai (head of SVN) and was unable to reproduce the segfault error=20
:-). But I got an Oops when I aborted the program via ^C _once_ after=20
reboot. All subsequent executions worked fine. I have attached the trace=20
and a manual backtrace. Seems like a crash in strlen() called from=20
remove_proc_entry().

Wolfgang.

>=20
> Many thanks to everybody who spend his precious time=20
> Roderik
>=20
> P.s.: with 2.2.2 I noticed, that in /proc/xenomai/interfaces vxWorks is=
 not listed although I compiled the kernel with support for vxworks. Is t=
his o.K. ?
>=20
>=20


--------------000602020700030007010109
Content-Type: text/x-log;
 name="heap-exit.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="heap-exit.log"

bash-2.05b# ./heap
Start Heap
root_thread_init :
timer startedt
display task created
root_thread_init beendet
Available Memory 45674496 (Pagesize 4096)
heap 0 of size 16000000 created
Heap 0 allocated size 16000000
heap 1 of size 16000000 created
Heap 1 allocated size 16000000
heap 2 of size 16000000 created
Heap 2 allocated size 16000000
__alloc_pages: 0-order allocation failed (gfp=0x1f2/0)
Available Memory after allocation 8888320
__alloc_pages: 0-order allocation failed (gfp=0x1f2/0)
Heap 3 created with size 4172800
Heap 3 allocated size 4172800
Memory allocated in total : 52172800
1 loops done
11 loops done
UDP->root_thread_exit
*** long delay ***
Machine check in kernel mode.
Caused by (from SRR1=41000): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C00117A0 XER: 20000000 LR: C0060018 SP: C03D7F00 REGS: c03d7e50 TRAP: 0200    Not tainted
MSR: 00041000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c03d6000[2] 'keventd' Last syscall: -1
last math 00000000 last altivec 00000000
GPR00: 00000000 C03D7F00 C03D6000 F0927EB7 F0927EB7 00000008 00000000 C024540C
GPR08: 00000000 C02042B4 C01F0000 C01DBC80 84044442 1001AA80 03FBA000 00000000
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 003FF000 C0240000 C0240000 C0210000
GPR24: C02453CC C31919C0 C01C5DB8 C01C6C30 C3E1A420 C3E1A620 C01E731C 22004042
Call backtrace:
C00232F4 C01115E4 C0019A34 C0022E44 C0008598
UDP->root_thread_exit
UDP->root_thread_exit

(gdb) l *0xC00117A0
No source file for address 0xc00117a0. *** in strlen ***
(gdb) l *0xC00232F4
0xc00232f4 is in ipipe_unstall_pipeline_from (core.c:279).
274             else
275                     pos = __ipipe_pipeline.next;
276
277             __ipipe_walk_pipeline(pos, cpuid);
278
279             if (__ipipe_pipeline_head_p(ipd))
280                     local_irq_enable_hw();
281             else
282                     ipipe_unlock_cpu(flags);
283     }
(gdb) l *0xC01115E4
0xc01115e4 is in registry_proc_callback (registry.c:369).
364
365                     xnlock_put_irqrestore(&nklock, s);
366
367                     remove_proc_entry(entry->name, dir);
368
369                     if (entries <= 0) {
370                             remove_proc_entry(type, rdir);
371
372                             if (pnode->root->entries <= 0)
373                                     remove_proc_entry(root, registry_proc_root);
(gdb) l *0xC0019A34
0xc0019a34 is in __run_task_queue (softirq.c:357).
352                     f = p->routine;
353                     data = p->data;
354                     wmb();
355                     p->sync = 0;
356                     if (f)
357                             f(data);
358             }
359     }
360
361     static int ksoftirqd(void * __bind_cpu)
(gdb) l *0xC0022E44
0xc0022e44 is in context_thread (context.c:103).
98                      if (TQ_ACTIVE(tq_context))
99                              set_task_state(curtask, TASK_RUNNING);
100                     schedule();
101                     remove_wait_queue(&context_task_wq, &wait);
102                     run_task_queue(&tq_context);
103                     wake_up(&context_task_done);
104                     if (signal_pending(curtask)) {
105                             while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)
106                                     ;
107                             spin_lock_irq(&curtask->sigmask_lock);
(gdb) l *0xC0008598
No source file for address 0xc0008598. *** in arch_kernel_thread ***
(gdb) l *0xC0060018
0xc0060018 is in remove_proc_entry (generic.c:565).
560             int len;
561
562             if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
563                     goto out;
564             len = strlen(fn);
565             for (p = &parent->subdir; *p; p=&(*p)->next ) {
566                     if (!proc_match(len, fn, *p))
567                             continue;
568                     de = *p;
569                     *p = de->next;
(gdb)


--------------000602020700030007010109--

