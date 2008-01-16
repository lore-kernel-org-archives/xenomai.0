Message-ID: <478DD90B.6020302@domain.hid>
Date: Wed, 16 Jan 2008 11:14:35 +0100
From: "Bernhard Michael" <michael.bernhard@domain.hid>
MIME-Version: 1.0
References: <47891672.4050409@domain.hid>
	<2ff1a98a0801140525y2bc4a198o97967585f6de0f7c@domain.hid>
	<478B8249.90303@domain.hid>
	<2ff1a98a0801140752y5e6e47e2tb9980bfb344522a4@domain.hid>
	<478CAB5F.70208@domain.hid>
	<2ff1a98a0801150509w2dae4826r4696cd95c21aecb3@domain.hid>
	<478CBD27.4020501@domain.hid>
	<2ff1a98a0801150610n4404224bl98be4fcbccba70b7@domain.hid>
In-Reply-To: <2ff1a98a0801150610n4404224bl98be4fcbccba70b7@domain.hid>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai problems on pxa
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> To solve the problem about unaligned accesses, the solution is to put
> some print_symbol or show_stack(NULL, NULL) in xnpod_trap_fault. Once
> we get the exact location of an unaligned access, disassemble the
> kernel or a module at the given location and try and understand why
> there is an unaligned access. 

Well, even though I've never done that before I couldn't resist to try it out.

I put a 'show_stack(NULL,NULL)' in 'xnpod_trap_fault' and got following
stack traces:

----

[<c002734c>] (show_stack+0x0/0x5c) from [<bf005d88>] (xnpod_trap_fault+0x50/0x1e0 [xeno_nucleus])
[<bf005d38>] (xnpod_trap_fault+0x0/0x1e0 [xeno_nucleus]) from [<bf002278>] (xnarch_trap_fault+0x20/0x28 [xeno_nucleus])
 r6 = C01EFFE0  r5 = 00000000  r4 = 58454E4F
[<bf002258>] (xnarch_trap_fault+0x0/0x28 [xeno_nucleus]) from [<c01f0038>] (exception_event+0x58/0x70)
[<c01effe0>] (exception_event+0x0/0x70) from [<c005abf0>] (__ipipe_dispatch_event+0x124/0x1ec)
 r5 = 00000000  r4 = 00000100
[<c005aacc>] (__ipipe_dispatch_event+0x0/0x1ec) from [<c002b914>] (do_alignment+0x1a4/0x410)
[<c002b770>] (do_alignment+0x0/0x410) from [<c0029a98>] (do_DataAbort+0x3c/0x13c)
[<c0029a5c>] (do_DataAbort+0x0/0x13c) from [<c00229ac>] (__dabt_svc+0x4c/0x60)
[<bf028e54>] (rt_timer_inquire+0x0/0xb0 [xeno_native]) from [<bf02c9a0>] (__rt_timer_inquire+0x20/0x7c [xeno_native])
 r7 = BF01C2A4  r6 = C308BEA4  r5 = 00000000  r4 = C308BFB0
[<bf02c980>] (__rt_timer_inquire+0x0/0x7c [xeno_native]) from [<bf00c688>] (hisyscall_event+0x1ac/0x2b8 [xeno_nucleus])
 r6 = C3C2F100  r5 = 00000000  r4 = C308BFB0
[<bf00c4dc>] (hisyscall_event+0x0/0x2b8 [xeno_nucleus]) from [<c005abf0>] (__ipipe_dispatch_event+0x124/0x1ec)
[<c005aacc>] (__ipipe_dispatch_event+0x0/0x1ec) from [<c0028270>] (__ipipe_syscall_root+0x5c/0x108)
[<c0028214>] (__ipipe_syscall_root+0x0/0x108) from [<c0022f7c>] (vector_swi+0x5c/0x98)

Xenomai: Switching sampling-763 to secondary mode after exception #8 in kernel-space at 0xbf028e94 (pid 765)

[<c002734c>] (show_stack+0x0/0x5c) from [<bf005d88>] (xnpod_trap_fault+0x50/0x1e0 [xeno_nucleus])
[<bf005d38>] (xnpod_trap_fault+0x0/0x1e0 [xeno_nucleus]) from [<bf002278>] (xnarch_trap_fault+0x20/0x28 [xeno_nucleus])
 r6 = C01EFFE0  r5 = 00000000  r4 = 58454E4F
[<bf002258>] (xnarch_trap_fault+0x0/0x28 [xeno_nucleus]) from [<c01f0038>] (exception_event+0x58/0x70)
[<c01effe0>] (exception_event+0x0/0x70) from [<c005abf0>] (__ipipe_dispatch_event+0x124/0x1ec)
 r5 = 00000000  r4 = 00000100
[<c005aacc>] (__ipipe_dispatch_event+0x0/0x1ec) from [<c002b914>] (do_alignment+0x1a4/0x410)
[<c002b770>] (do_alignment+0x0/0x410) from [<c0029a98>] (do_DataAbort+0x3c/0x13c)
[<c0029a5c>] (do_DataAbort+0x0/0x13c) from [<c00229ac>] (__dabt_svc+0x4c/0x60)
[<bf02a7d4>] (__rt_task_set_periodic+0x0/0x11c [xeno_native]) from [<bf00c3f8>] (losyscall_event+0xc8/0x1ac [xeno_nucleus])
 r6 = C308BFB0  r5 = 00000001  r4 = 00000022
[<bf00c330>] (losyscall_event+0x0/0x1ac [xeno_nucleus]) from [<c005abf0>] (__ipipe_dispatch_event+0x124/0x1ec)
[<c005aacc>] (__ipipe_dispatch_event+0x0/0x1ec) from [<c0028270>] (__ipipe_syscall_root+0x5c/0x108)
[<c0028214>] (__ipipe_syscall_root+0x0/0x108) from [<c0022f7c>] (vector_swi+0x5c/0x98)

Xenomai: Switching sampling-763 to secondary mode after exception #8 in kernel-space at 0xbf02a8b0 (pid 765)
latency: failed to set periodic, code -110
warming up...

[<c002734c>] (show_stack+0x0/0x5c) from [<bf005d88>] (xnpod_trap_fault+0x50/0x1e0 [xeno_nucleus])
[<bf005d38>] (xnpod_trap_fault+0x0/0x1e0 [xeno_nucleus]) from [<bf002278>] (xnarch_trap_fault+0x20/0x28 [xeno_nucleus])
 r6 = C01EFFE0  r5 = 00000000  r4 = 58454E4F
[<bf002258>] (xnarch_trap_fault+0x0/0x28 [xeno_nucleus]) from [<c01f0038>] (exception_event+0x58/0x70)
[<c01effe0>] (exception_event+0x0/0x70) from [<c005abf0>] (__ipipe_dispatch_event+0x124/0x1ec)
 r5 = 00000000  r4 = 00000100
[<c005aacc>] (__ipipe_dispatch_event+0x0/0x1ec) from [<c002b914>] (do_alignment+0x1a4/0x410)
[<c002b770>] (do_alignment+0x0/0x410) from [<c0029a98>] (do_DataAbort+0x3c/0x13c)
[<c0029a5c>] (do_DataAbort+0x0/0x13c) from [<c00229ac>] (__dabt_svc+0x4c/0x60)
[<bf02af24>] (__rt_sem_p+0x0/0xc0 [xeno_native]) from [<bf00c3f8>] (losyscall_event+0xc8/0x1ac [xeno_nucleus])
 r6 = C3B33FB0  r5 = 00000001  r4 = 00000006
[<bf00c330>] (losyscall_event+0x0/0x1ac [xeno_nucleus]) from [<c005abf0>] (__ipipe_dispatch_event+0x124/0x1ec)
[<c005aacc>] (__ipipe_dispatch_event+0x0/0x1ec) from [<c0028270>] (__ipipe_syscall_root+0x5c/0x108)
[<c0028214>] (__ipipe_syscall_root+0x0/0x108) from [<c0022f7c>] (vector_swi+0x5c/0x98)

Xenomai: Switching display-763 to secondary mode after exception #8 in kernel-space at 0xbf02afd4 (pid 764)
latency: failed to pend on semaphore, code -1

----

In the first unaligned access, data abort occurs in 'rt_timer_inquire'. 
In this function I put a 'printk' after each C-line. If I didn't mess
the things up this way, data abort occurs at the assignment:

info->period = period;

Looking at the assembler, instruction 'strd' is used to store this 'long long'
variable.

Interestingly, structure 'info' is allocated on the stack in function
'__rt_timer_inquire' which calls 'rt_timer_inquire' and passes 'info' as an
argument.

I'm not sure but the problem could be that 'long long' variables need to be
8-byte aligned in order to allow 'strd' and 'ldrd' instructions. 
See: http://groups.google.ch/group/comp.sys.arm/browse_thread/thread/a4ed79328671521d/2e3bb93e5a59f785

However, I don't know how to make 'info' to be allocated at an 8-byte boundary.

Looking at the assembler of the two other catches (in '__rt_task_set_periodic'
and '__rt_sem_p') shows that both function use also 'strd' and 'ldrd'
instructions. I didn't check if data abort occurred at these instructions however.

> You can do this yourself if you are in a
> hurry, or let me do it if I am able to reproduce the bug on AT91, but
> I need to generate a full image with EABI enabled, so it will take
> some time.

OK, I started with it but I'd like to let you work on this now. I don't have the knowledge
to fiddle with compiler options or using macros or whatever to solve this problem.

Today, I don't have access to the hardware. When needed I can run tests on an other day.

--
Michael

