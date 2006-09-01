Subject: Re: [Xenomai-help] [Fwd: Performance decrease]
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17656.11641.610980.162241@domain.hid>
References: <1156941389.4323.17.camel@domain.hid> <1156942089.4323.29.camel@domain.hid>
	<17655.18827.661904.949733@domain.hid>
	<1157094795.4322.9.camel@domain.hid>
	<17656.11641.610980.162241@domain.hid>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 16:35:10 +0200
Message-Id: <1157121310.4981.18.camel@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2006-09-01 at 14:54 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > On Thu, 2006-08-31 at 22:41 +0200, Gilles Chanteperdrix wrote:
>  > > Philippe Gerum wrote:
>  > >  > On Wed, 2006-08-30 at 14:36 +0200, Philippe Gerum wrote:
>  > >  > > -------- Forwarded Message --------
>  > >  > > > From: Daniel Schnell <danielsch@domain.hid>
>  > >  > > > To: xenomai-help <xenomai@xenomai.org>
>  > >  > > > Subject: Performance decrease
>  > >  > > > Date: Wed, 30 Aug 2006 11:58:25 -0000
>  > >  > > > 
>  > >  > > > Hi,
>  > >  > > > 
>  > >  > > >  
>  > >  > > > 
>  > >  > > > I have made some CPU throughput tests with/without "Nucleus options->pervasive real-time support in user-space" 
>  > >  > >  enabled/disabled. And the performance dicrease in using that option is for my processor (MPC5200, 400 MHz) about 10%.
>  > >  > 
>  > >  > There is an impact induced by activating the user-space support, since
>  > >  > all system calls are filtered through Xenomai; some work is currently
>  > >  > undergoing to reduce this overhead, so that only system calls issued by
>  > >  > Xenomai shadows would be intercepted. This said, out of curiosity, how
>  > >  > do you measure those 10% on your board?
>  > > 
>  > > Just being curious: how will you achieve this ? You will make the
>  > > function used to dispatch system calls a per-thread pointer ?
>  > > 
>  > 
>  > Syscalls are just another form of exceptions, so the change will need to
>  > affect all event notifications. A per-thread pointer is an opion
>  > provided there is also a mean to install the callback address, so we
>  > would also need to intercept the Linux task creation event. 
> 
> If we continue on this idea. PTD initialization already intercept the
> Linux task creation event to set the PTDs to 0. Maybe we could dedicate
> a PTD to mean that a thread is "monitored", so that when an Adeos event
> occurs, the event only triggers Xenomai callbacks if the thread is
> monitored

The advantage I see with wiring the callback into the task struct is
that it should be easier to handle the binding issue. While we are at
it, we could just define an additional callback pointer, no need to
recycle ptds.

>  (not sure that it would work for the "schedule" event
> though).

We want to know all scheduling events anyway, including those involving
non-shadows, so that we can make the root thread inherit the right
priority (and also engage the interrupt shield as needed).

> 
> But there is an exception: the "bind" syscall event must be intercepted
> for threads that are not yet marked as monitored.

That's the major issue. We need to keep events flowing to a filtering
callback in order to detect binding ops, but without going through the
entire pipeline abstraction. And pipelining as it is now must be kept
for bound Linux tasks, i.e. shadows. The idea is to save the time spent
in the Adeos event dispatcher for tasks that don't need to tell the
world about what they are actually doing.

-- 
Philippe.



