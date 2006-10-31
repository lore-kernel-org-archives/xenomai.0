Subject: Re: [Xenomai-help] Kernel OOps large appl.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0144D680@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB0144D680@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 14:43:39 +0100
Message-Id: <1162302219.4996.72.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-10-31 at 13:25 +0000, Daniel Schnell wrote:
> Hi,
>  
> we are porting our application to the POSIX skin of Xenomai. We are
> using a 2.4.25 Denx based Kernel with 4 days old Xenomai 2.3-devel svn
> trunk on a MPC5200B based custom board. The application spawns 36
> Threads, uses 265 mutexes and 22 condition variables. We increased all
> numbers that can be set inside Xenomai kernel config to 10x, just to
> be sure we are not blowing out Kernel limits (Prinzip: Stange im
> Nebel).
>  
>  
> The following output of ksymoops will be done for the occuring oops:
>  
[...]
> Trace; c00129dc <schedule+280/574>
> Trace; c011fb94 <xnshadow_ppd_lookup_inner+12c/1d4>

This backtrace looks weird.

> Trace; c0120f18 <xnshadow_sys_bind+298/300>
> Trace; c0025fbc <__ipipe_dispatch_event+b4/198>
> Trace; c000d638 <__ipipe_syscall_root+44/e0>
> Trace; c0005a3c <DoSyscall+1c/90>
> Trace; 0ffd9f80 Before first symbol
> Trace; 0fc4b888 Before first symbol
> Trace; 0fc4b750 Before first symbol
> Trace; 0fc0cf40 Before first symbol
> Trace; 0ffd890c Before first symbol
> Trace; 0ff68fc0 Before first symbol
> Trace; 0ee6c9a0 Before first symbol
>  
>  
>  
> The call right before entering the system space traced down with a
> running gdb is __wrap_clock_nanosleep().

This means that you are linking your application with the POSIX skin
too. So your setup is UVM/psos library + POSIX skin support?
Please send your Makefile, this should help understanding what's bound
to your application.

> It always happens here. But when just testing this function alone in a
> cycle, no kernel oops happens. The oops seems to be a correlation of
> different events.

The stack trace does not even match the wrapped nanosleep syscall, so
there is some strange interactions ongoing between the interfaces used.

>  
>  
> On the other side we have a constant problem with clock_nanosleep() in
> that it always returns after 1/4 of the supposed time.
>  
> I.e. calling
>  
> struct timespec t
> t.tv_sec = 5; t.tv_nsec = 0;
> clock_nanosleep(CLOCK_REALTIME, 0, &t, NULL);
>  
> returns after 1 second and not 4.
>  
> Whereas clock_gettime(CLOCK_REALTIME, &t) works correctly (i.e. the
> difference of two timestamps taken before and after clock_nanosleep()
> with the above settings results in a diff time of 1 sec). So somehow
> the external hardware timer setup is incorrect or maybe frequencies ?

The setup for a lite5200 hw on a Denx 2.4.25 kernel should work out of
the box. This is much more likely a software issue, maybe related to the
strangenesses above.

>  
> Any ideas ?
>  
>  
> Regards,
>  
> Daniel.
>  
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



