Message-ID: <4F95D57F.5050206@domain.hid>
Date: Tue, 24 Apr 2012 00:19:43 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <DUB114-W7121A0DDCD5D2E2B7CD801AF3B0@domain.hid>
In-Reply-To: <DUB114-W7121A0DDCD5D2E2B7CD801AF3B0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_event_wait makes linux crash if executed
 while debugging with gdbserver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabio Visona <fabioviso@domain.hid>
Cc: xenomai@xenomai.org

On 04/13/12 16:49, Fabio Visona wrote:
> Hello,
>
> I am trying to debug a Xenomai task through gdbserver over ethernet, with:
>
> gdbserver host:12345 --attach 240
>
> where 240 is the PID of the Xenomai real-time task I want to debug.
>
> After connecting with the gdb client, running continuosly is fine, but
> if I put a breakpoint and afterwards make the software execute an
> rt_event_wait call, the system crashes (gdb client stuck, no more
> ethernet connection, no panic message on the debug console serial port).
>
> By going step by step with the debugger, the exact point of the problem
> can be isolated:
>
> int rt_event_wait(RT_EVENT *event,
> unsigned long mask,
> unsigned long *mask_r, int mode, RTIME timeout)
> {
> int ret;
>
> ret = XENOMAI_SKINCALL5(__native_muxid,
> __native_event_wait,
> event, &mask, mode, XN_RELATIVE, &timeout);
> if (ret)
> return ret;
>
> *mask_r = mask;
>
> return 0;
> }
>
> with mode = EV_ANY, timeout is 10000 - 100000 ns about.
>
> Showing the assembly code of the XENOMAI_SKINCALL5 macro:
>
> 0x64fc4e <rt_event_wait+42>: R3 = 0x0 (X); /* R3=0x0( 0) */
> 0x64fc50 <rt_event_wait+44>: R7.L = 0x22b; /* (555)
> R7=0x0x27022b(2556459) */
> 0x64fc54 <rt_event_wait+48>: JUMP.S 0x0x64fc60 <rt_event_wait+60>;
> 0x64fc56 <rt_event_wait+50>: R0 = P1;
> 0x64fc58 <rt_event_wait+52>: R1 = -0x55 (X); /* R1=0x0xffffffab(-85) */
> 0x64fc5c <rt_event_wait+56>: CC = R0 == R1;
> 0x64fc5e <rt_event_wait+58>: IF !CC JUMP 0x0x64fc9e <rt_event_wait+122>;
> 0x64fc60 <rt_event_wait+60>: [FP + -0x848] = R3;
> 0x64fc64 <rt_event_wait+64>: R1 = R6;
> 0x64fc66 <rt_event_wait+66>: R2 = P4;
> 0x64fc68 <rt_event_wait+68>: R0 = [P5];
> 0x64fc6a <rt_event_wait+70>: R0 = R0 | R7;
> 0x64fc6c <rt_event_wait+72>: P0 = R0;
> 0x64fc6e <rt_event_wait+74>: R0 = P3;
> 0x64fc70 <rt_event_wait+76>: EXCPT 0x0;
> <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> 0x64fc72 <rt_event_wait+78>: P1 = R0;
> 0x64fc74 <rt_event_wait+80>: R0 = [FP + -0x848];
>
> Execution crashes at EXCPT 0x0, which should be a system call, according
> to Xenomai sources (syscall.h).
>
> Xenomai version is 2.5.3, Linux 2.6.34.7, running on a Blackfin BF518
> processor.
>
> Note that everything works fine running the application without debugger.
>
> Any hint?

This could be a pipeline (adeos) issue, or a Xenomai core issue.

Quite a bunch of nasty bugs were fixed since 2.5.3, and the interrupt 
pipeline patch shipped with this release in ksrc/arch/blackfin/patches. 
Some of them were even specific to ptracing a Xenomai application.

For narrowing the issue, I would suggest the following steps, incrementally:

- to upgrade the pipeline to this one, in case you are running any 
earlier version: 
http://download.gna.org/adeos/patches/v2.6/blackfin/older/adeos-ipipe-2.6.34-blackfin-1.15-01.patch

If the issue still shows up:

- to upgrade the Xenomai stack to 2.5.6.

I have a pipeline upgrade pending for the 3.2/blackfin kernel, so I'd be 
interested to know whether that gremlin still hides in recent releases, 
so that I might fix it prior to issuing that patch. I don't have any 
bf518 at hand, but if you have any simple test code reproducing the 
issue to send me, I could try it on my oldish bf561 in single core mode.

-- 
Philippe.

