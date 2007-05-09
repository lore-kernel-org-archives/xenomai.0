From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <464175A7.6060504@domain.hid>
References: <4639D724.5010702@domain.hid>
	<1178198991.29605.54.camel@domain.hid>  <463AE79E.2090901@domain.hid>
	<1178281926.29093.93.camel@domain.hid> <463B2A69.7080704@domain.hid>
	<463EE376.9030702@domain.hid> <463EEA4A.1070405@domain.hid>
	<463F1468.8010403@domain.hid> <463F178D.4020805@domain.hid>
	<463F1D99.5090208@domain.hid> <463F2F14.1000205@domain.hid>
	<46401F76.7080904@domain.hid>  <464175A7.6060504@domain.hid>
Content-Type: text/plain
Date: Wed, 09 May 2007 09:49:11 +0200
Message-Id: <1178696951.5004.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Latency calculation and test
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

On Wed, 2007-05-09 at 09:17 +0200, Jan Kiszka wrote:
> Johan Borkhuis wrote:
> > Jan,
> > 
> > Jan Kiszka wrote:
> >> Johan Borkhuis wrote:
> >> -snip-
> >>  
> >>> :|  + begin   0x80000001 -1908    0.414  __ipipe_dispatch_event+0x1e4
> >>> (__ipipe_syscall_root+0x64)
> >>> :|  + end     0x80000001 -1908!  52.121  __ipipe_dispatch_event+0x204
> >>> (__ipipe_syscall_root+0x64)
> >>> :   + func               -1857+   1.170  do_page_fault+0x14
> >>> (handle_page_fault+0xc)
> >>>     
> >> This one is interesting: page fault over the RT-thread that belongs to
> >> PID 1160 (prio 79).
> >>  
> >>> :|  # func               -1845+   1.585  rpi_push+0x14 [xeno_nucleus]
> >>> (xnshadow_relax+0x84 [xeno_nucleus])
> >>> :|  # func               -1844    0.463  xnpod_schedule_runnable+0x14
> >>> [xeno_nucleus] (rpi_push+0x84 [xeno_nucleus])
> >>> :|  # [    0] swapper 79 -1843+   1.658  xnpod_schedule_runnable+0x54
> >>> [xeno_nucleus] (rpi_push+0x84 [xeno_nucleus])
> >>>     
> >> And now we are running the Linux kernel at xeno-prio 79 (due to
> >> prio-coupling).
> >>   
> > Thank you for pointing these out. This made me change 2 things in the
> > configuration:
> > - Disabling swap. This should not make any difference as I don't have
> > any swapspace, but the page_fault triggered me to have a look at that
> > setting.
> > - Enabling "Disable priority coupling". I missed the Disable part here,
> > so it was still enabled during this run.
> 
> Don't get me wrong: I was not saying the prio-coupling it the root of
> the problem here, it's just an amplifier. The (or at least one) root is
> that your RT task still causes page faults. That needs to be fixed!
> 

Additionally, prio coupling should not be applied when transitioning to
secondary mode is caused by special operations, like handling a fault or
exiting. I'm going to have a look at this.

-- 
Philippe.



