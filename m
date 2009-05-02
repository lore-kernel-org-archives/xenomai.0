From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <49FC7466.1080602@domain.hid>
References: <200904301508.29432@domain.hid> <200904301509.13094@domain.hid>
	<200904301510.8382@domain.hid> <200904301511.15875@domain.hid>
	<200904301512.9035@domain.hid> <200904301513.12716@domain.hid>
	<200904301514.6099@domain.hid> <200904301515.16182@domain.hid>
	<200904301516.696@domain.hid>  <49F9B123.7080203@domain.hid>
	<1241103352.26544.177.camel@domain.hid>  <49F9C374.1040209@domain.hid>
	<1241116652.26544.183.camel@domain.hid>  <49FC7466.1080602@domain.hid>
Content-Type: text/plain
Date: Sat, 02 May 2009 20:31:20 +0200
Message-Id: <1241289080.26544.238.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm_event_timedwait returns -EINTR
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
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-help <xenomai@xenomai.org>

On Sat, 2009-05-02 at 18:27 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Thu, 2009-04-30 at 17:27 +0200, Gilles Chanteperdrix wrote:
> >> Philippe Gerum wrote:
> >>> On Thu, 2009-04-30 at 07:09 -0700, Thomas Lockhart wrote:
> >>>>> Hello, I have a problem with rtdm_event_timedwait() function. It
> >>>>> sometimes ends prematurely with -EINTR error code. It depends on
> >>>>> special circumstances (CPU load, resizing console window in X, ...).
> >>>> In other areas of Xenomai when one sees a EINTR return one should
> >>>> reenter the original call. Like this (?):
> >>>>
> >>>> do {
> >>>>   err = rt_task_wait_period(...)
> >>>> } while (err != -EINTR);
> >>>>
> >>> Just to clarify a few points more:
> >>>
> >>> Xenomai always tells the kernel that blocking (Xenomai) syscalls
> >>> _should_ be restarted when interrupted by a Linux signal (i.e.
> >>> -ERESTARTSYS is passed down to the kernel by the Xenomai core in that
> >>> case), and the kernel will actually restart that (Xenomai) syscall if no
> >>> handler was installed for such signal, or if SA_RESTART is set in the
> >>> sigaction() flags for the signal.
> >>>
> >>> In all other cases, the syscall will not be restarted despite the
> >>> "should restart" hint passed to the Linux kernel, and -EINTR will be
> >>> eventually returned by the native API syscall (or errno == EINTR for the
> >>> POSIX skin). The way other skins (e.g. VxWorks) will propagate the
> >>> -EINTR condition on interrupted syscalls to the user program depends on
> >>> their respective API conventions, but they will propagate that
> >>> information in a way or another as well, if the syscall was not
> >>> restarted.
> >>>
> >>> Additionally, syscalls may be forcibly unblocked via rt_task_unblock(),
> >>> which will cause -EINTR to be returned to the caller as well. This is
> >>> totally unrelated to Linux signal management though.
> >> Are not there cases where the kernel/libc "jumps back" to the beginning
> >> of the syscall when asked to restart a syscall ?
> > 
> > Yes, that is how a restart is done, simply by moving the instruction
> > pointer back.
> > 
> >>  Is not it what causes
> >> the problem with rt_event_wait ?
> >>  In fact if it is the problem then it
> >> means that the user-space skins should always convert delays to an
> >> absolute expiry date, and pass this as argument to the syscall, so that
> >> blindly restarting the syscall will work as expected. However, if that
> >> is the case, it means that we have quite a few syscalls to fix...
> >>
> > 
> > This is why 2.5 introduces *_until() call forms for most timed syscalls,
> > to specify absolute delays.
> 
> Ok. But the one with fixed relative delays can be fixed too, doing like
> nanosleep: in case of -EINTR, copy back to user-space the next delay in
> case the syscall is restarted.
> 

I'm not saying this can't be fixed, I'm just saying that this is not
mandatory to fix them to have proper behavior based on the new *_until()
forms.

-- 
Philippe.



