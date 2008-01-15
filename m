Message-ID: <2ff1a98a0801150206r2977970ay445a18f65a025e5d@domain.hid>
Date: Tue, 15 Jan 2008 11:06:13 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <200801151024.53483.peter.soetens@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200801141627.32289.peter.soetens@domain.hid>
	<478BC989.6020103@domain.hid>
	<200801151024.53483.peter.soetens@domain.hid>
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

On Jan 15, 2008 10:24 AM, Peter Soetens <peter.soetens@domain.hid> wrote:
> On Monday 14 January 2008 21:43:53 Philippe Gerum wrote:
> > Peter Soetens wrote:
> > > Hi,
> > >
> > > Is it possible that this call only clears the T_PRIMARY flag temporary,
> > > and that after 'some' rt_ call, the flag is set again ?
> >
> > Any potentially blocking rt-syscall for instance, occurring between
> > rt_task_set_mode() and rt_task_inquire(), would indeed switch the thread
> > back to primary, clearing the XNRELAX bit from the status.
>
> Thanks, It would be nice to add this sentence to the API docs.
>
> So how do I run a task permanently in secondary mode ? The reason I want to do
> this is two fold: We want to share xenomai native mutexes and semaphores
> between threads running in primary domain and threads running under the Linux
> scheduler.

A thread which blocks on a xenomai native mutex or semaphore will
switch to primary mode, it will not run under the Linux scheduler.

> And we want a thread type that allows user code to go in endless
> loops without hanging the machine. In RTAI we did this creating an RTAI task
> which was run in the soft-rt mode.

You should probably use a native task with priority 0, this task will
use the SCHED_OTHER policy when run by Linux scheduler, which means it
will not hang the machine. But of course, you will have to take care
that the loop does not take place in primary mode.

> I believe a plain posix thread can not use the 'native' interface ?

A plain posix thread can use some of the native interface services,
but not the blocking ones. Blocking a thread requires xenomai tasks
running in primary mode.

-- 
                                               Gilles Chanteperdrix

