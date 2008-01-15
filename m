Message-ID: <2ff1a98a0801150505r7e4e0252qa51225bdf17435b5@domain.hid>
Date: Tue, 15 Jan 2008 14:05:07 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200801151334.18090.peter.soetens@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200801141627.32289.peter.soetens@domain.hid>
	<200801151024.53483.peter.soetens@domain.hid>
	<2ff1a98a0801150206r2977970ay445a18f65a025e5d@domain.hid>
	<200801151334.18090.peter.soetens@domain.hid>
Subject: Re: [Xenomai-help] Is rt_task_set_mode( T_PRIMARY, 0,
	0 ) temporary ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter.soetens@domain.hid>
Cc: xenomai@xenomai.org

On Jan 15, 2008 1:34 PM, Peter Soetens <peter.soetens@domain.hid> wrote:
> On Tuesday 15 January 2008 11:06:13 Gilles Chanteperdrix wrote:
> >
> > A thread which blocks on a xenomai native mutex or semaphore will
> > switch to primary mode, it will not run under the Linux scheduler.
> >
> > > And we want a thread type that allows user code to go in endless
> > > loops without hanging the machine. In RTAI we did this creating an RTAI
> > > task which was run in the soft-rt mode.
> >
> > You should probably use a native task with priority 0, this task will
> > use the SCHED_OTHER policy when run by Linux scheduler, which means it
> > will not hang the machine. But of course, you will have to take care
> > that the loop does not take place in primary mode.
>
> The native API says that the lowest priority is '1' and not '0'.
> <http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__task.html#g03387550693c21d0223f739570ccd992>
>
> Or do you suggest I should use pthread_setschedparam or similar after a call
> to rt_task_set_mode(T_PRIMARY, 0, 0 ) ?

The null priority is a (relatively) recent addition, so, maybe the
docs are not yet up to date.

>
> >
> > > I believe a plain posix thread can not use the 'native' interface ?
> >
> > A plain posix thread can use some of the native interface services,
> > but not the blocking ones. Blocking a thread requires xenomai tasks
> > running in primary mode.
>
> Ok. Thanks for this clarification. It looks like I'll have to redesign some
> code to take into account these policies. I just wonder if staying in the
> primary domain after a 'blocking' call is what users of rt_task_set_mode()
> expect. Why are the flags not restored to what the user has set ? I'm just
> complaining from a user's perspective :-]

The current policy is the lazy approach: mode switches occur only when
needed. This results in fewer mode switches, but this may mean that
you should use rt_task_set_mode from time to time if you want to force
a mode.

-- 
                                               Gilles Chanteperdrix

