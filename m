Subject: Re: [Xenomai-core] [BUG] trunk: screwed Linux irq state
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45D07C14.1090107@domain.hid>
References: <45CF951B.8080404@domain.hid>	<1171233732.5035.24.camel@domain.hid>
	<17871.41373.425284.839228@domain.hid>
	<1171237780.5035.30.camel@domain.hid>
	<17871.45750.434103.944040@domain.hid>	<45CFB49F.1050000@domain.hid>
	<45CFBE7B.3050906@domain.hid> <45D05431.10409@domain.hid>
	<45D068C0.8090208@domain.hid> <1171287998.5001.4.camel@domain.hid>
	<45D0704D.9000304@domain.hid> <1171289404.5001.14.camel@domain.hid>
	<45D07C14.1090107@domain.hid>
Content-Type: text/plain
Date: Mon, 12 Feb 2007 16:10:48 +0100
Message-Id: <1171293049.5001.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Mon, 2007-02-12 at 15:39 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Mon, 2007-02-12 at 14:49 +0100, Jan Kiszka wrote:
> > 
> >>Philippe Gerum wrote:
> >>
> >>>On Mon, 2007-02-12 at 14:16 +0100, Gilles Chanteperdrix wrote:
> >>>
> >>>>Jan Kiszka wrote:
> >>>>
> >>>>>Jan Kiszka wrote:
> >>>>>
> >>>>>
> >>>>>>2.6.19 didn't magically start to work as well. Instead I have a back
> >>>>>>trace now, see attachment.
> >>>>>>
> >>>>>>I included a full set of 16k points, but the thrilling things are around
> >>>>>>-73 to -25: Some Linux process with IRQs on gets preempted by an RT-IRQ
> >>>>>>(RTnet NIC). That triggers an RT kernel thread to run for a while (RTnet
> >>>>>>stack manager, prio 98). But when returning to Linux again, its IRQs
> >>>>>>remain masked now. The reason must be that weird exception at -62. Don't
> >>>>>>know where it comes from and why is there no report about THAT issue in
> >>>>>>the kernel logs.
> >>>>>
> >>>>>The cause of this page fault will get tracked down later today, but the
> >>>>>way it is handled already causes some doubts to me. To make discussion
> >>>>>easier, here is the relevant excerpt from the trace:
> >>>>
> >>>>Maybe this fault is due to the No-cow patch ? Before the no-cow patch,
> >>>>vmalloced areas were added to all processes page directories, now they
> >>>>are added only to the page directories of processes with the VM_PINNED
> >>>>flag. So, if ipipe_test_root tries to access some module memory area
> >>>>over the context of a non-realtime thread, a fault will occur.
> >>>>
> >>>
> >>>Yes, it's a minor fault occurring due to on-demand memory mapping, this
> >>>is why we don't get any alarming message in the kernel log.
> >>>
> >>
> >>Looks like it's something that should never happen, for sure.
> > 
> > 
> > Now that vmalloc & ioremap memory may have their pte set on demand anew
> > due to the nocow patch, minor faults in kernel space are possible again,
> > but this should only happen on behalf of the Linux domain, this is not
> > expected to happen in primary mode.
> 
> Does not a primary mode IRQ handler borrow the mmu context from the
> tasks it preempts ?
> 

Yes, this is where the problem stands if we happen to preempt a regular
task and tread over code which might trigger minor faults. The best way
to check this would be to somehow enable VM_PINNED for all tasks. Back
to square #1.

-- 
Philippe.



