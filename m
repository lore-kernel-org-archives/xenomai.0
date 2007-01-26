Subject: Re: Antwort: Re: [Xenomai-core] Questions about pSOS task mode and
	task priority
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OF5910DE28.1586BCD6-ONC125726F.005E4D75@domain.hid>
References: <OF5910DE28.1586BCD6-ONC125726F.005E4D75@domain.hid>
Content-Type: text/plain
Date: Fri, 26 Jan 2007 18:26:14 +0100
Message-Id: <1169832375.3346.67.camel@domain.hid>
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
To: Thomas Necker <Thomas.Necker@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2007-01-26 at 18:16 +0100, Thomas Necker wrote:
> Hi Philippe
> 
> > > non-preemptive mode.
> > > With original pSOS this was allowed and "non-preemptive" meant that a
> > > runnable task cannot be preempted by other tasks but can block itself.
> > > Why is this different in Xenomai and is it possible to implement the 
> same
> > > behaviour in Xenomai core?
> > > 
> > 
> > Xenomai implements the non-preemptible mode as most RTOSes implement
> > scheduling locks. From this POV, allowing a non-preemptible task to
> > block makes no sense, and doing so usually either locks up the board, or
> > causes an API error.
> > 
> > It could be possible to switch the preemption bit on before entering a
> > blocking state only for pSOS tasks, then reinstate it when the task
> > wakes up, though. However, before going down that path, is there any
> > pSOS documentation that clearly states that such behaviour is to be
> > expected (i.e. that blocking calls _may_ be called in non-preemptible
> > mode)?
> > 
> > Or did you benefit from an undocumented and fortunate side-effect of the
> > pSOS implementation when relying on such behaviour?
> 
> Since Markus has already left, I had a quick look in the pSOS System 
> Concepts Manual:
> 
>     Each task has a mode word, with two settable bits that can affect 
> scheduling.
>     One bit controls the task's preemptibility. If disabled, then once the 
> task
>     enters the running state, it will stay running even if other tasks
>     of higher priority enter the ready state. A task switch will occur 
> only if
>     the running task blocks, or if it re-enables preemption.
> 
> So it clearly states that a non-preemtible task may block (and 
> rescheduling occurs in
> this case).

Ok, so this is a must fix. Will do. Thanks for reporting.

> 
> Regards,
> Thomas
> 
> 
> 
-- 
Philippe.



