Message-ID: <4AA7C4F7.6000903@domain.hid>
Date: Wed, 09 Sep 2009 17:08:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7a15153d0909081259o47b0fcb7k46f679e7dfe83456@domain.hid>	<4AA6BC5D.8020704@domain.hid>
	<7a15153d0909090803o309c5883q5c02ebef4fa794d8@domain.hid>
In-Reply-To: <7a15153d0909090803o309c5883q5c02ebef4fa794d8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] High Latency on PXA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

Felipe Castro wrote:
> Yes , i compiled with msoft-float , anyway  I downloaded xenomai 2.4.9.1
> and recompile my kernel,
> 
> During the startup it was ok ,
> 
> [    1.340935] NetWinder Floating Point Emulator V0.97 (double precision)
> [    1.344875] I-pipe: Domain Xenomai registered.
> [    1.344970] Xenomai: hal/arm started.
> [    1.375581] I-pipe: Domain IShield registered.
> [    1.377746] Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon) loaded.
> 
> and running xeno-info i got:
> 
> root@domain.hid$ ./xeno-info
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>  
> BusyBox v1.6.1 (2009-07-15 08:44:38 BRT) multi-call binary
> Linux vpac270 2.6.27-vpac1 #55 PREEMPT Wed Sep 9 06:07:03 BRT 2009
> armv5tel unknown
>  
> module-init-tools      found
> Modules Loaded         xeno_native
> 
> But running latency test program:
> 
> root@domain.hid$ ./latency -p 3000
> == Sampling period: 3000 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> [  360.030571] Xenomai: fatal: bug at
> kernel/xenomai/nucleus/shadow.c:1128 (!irqs_disabled_hw())
> [  360.030608]  CPU  PID    PRI      TIMEOUT  STAT      NAME
> [  360.030631]    0  0       -1      0        00500088  ROOT
> [  360.030653] >  0  363      0      0        00300180  display-361
> [  360.030678] Master time base: clock=1170102652
> [  360.030697]
> [  360.123559] [<c0021dec>] (show_stack+0x0/0x48) from [<c007e0a8>]
> (xnshadow_harden+0x1b8/0x210)
> [  360.149304] [<c007def0>] (xnshadow_harden+0x0/0x210) from
> [<c007e5c8>] (xnshadow_wait_barrier+0xf8/0x108)
> [  360.177811]  r8:00000018 r7:00000000 r6:c787bfb0 r5:c7a80810 r4:c787a000
> [  360.197738] [<c007e4d0>] (xnshadow_wait_barrier+0x0/0x108) from
> [<c007fb18>] (xnshadow_sys_barrier+0x14/0x18)
> [  360.227281]  r6:c787a000 r5:c787bfb0 r4:00000001
> [  360.241003] [<c007fb04>] (xnshadow_sys_barrier+0x0/0x18) from
> [<c007feac>] (losyscall_event+0xbc/0x1ac)
> [  360.268996] [<c007fdf0>] (losyscall_event+0x0/0x1ac) from
> [<c0066094>] (__ipipe_dispatch_event+0xd0/0x1c8)
> [  360.297788] [<c0065fc4>] (__ipipe_dispatch_event+0x0/0x1c8) from
> [<c0022c8c>] (__ipipe_syscall_root+0x7c/0x110)
> [  360.327847] [<c0022c10>] (__ipipe_syscall_root+0x0/0x110) from
> [<c001e028>] (vector_swi+0x68/0xa8)
> 
> any sugestion ?

You are probably not using the I-pipe patch which comes with Xenomai
2.4.9.1,
type:
cat /proc/ipipe/version

-- 
                                          Gilles


