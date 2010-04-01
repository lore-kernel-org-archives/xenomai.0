From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BB4F857.5020906@domain.hid>
References: <4B97BA0C.9000702@domain.hid>  <4B9AD0DE.4020103@domain.hid>
	<1268472523.27899.135.camel@domain.hid>
	<4B9BB9B1.5050003@domain.hid>
	<1268498034.27899.167.camel@domain.hid>
	<4B9C2100.6090806@domain.hid>
	<1268584465.27899.197.camel@domain.hid>
	<4BB4F857.5020906@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Apr 2010 23:24:02 +0200
Message-ID: <1270157042.2418.406.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Analogy cmd_write example explanation
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
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Thu, 2010-04-01 at 21:47 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Sun, 2010-03-14 at 00:34 +0100, Alexis Berlemont wrote:
> >> Philippe Gerum wrote:
> >>> On Sat, 2010-03-13 at 17:13 +0100, Alexis Berlemont wrote:
> >>>> Hi,
> >>>>
> >>>> Philippe Gerum wrote:
> >>>>> On Sat, 2010-03-13 at 00:40 +0100, Alexis Berlemont wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> Sorry for answering so late. I took a few days off far from any internet
> >>>>>> connection.
> >>>>>>
> >>>>>> It seems you sent many mails related with Analogy. Many thanks for your
> >>>>>> interest. I have not read all of them yet. However, I am beginning by
> >>>>>> this one (which seems unanswered). The answer is quick and easy :)
> >>>>>>
> >>>>>> Daniele Nicolodi wrote:
> >>>>>>> Hello. I'm looking into the analogy cmd_write example.
> >>>>>>>
> >>>>>>> I'm not sure I understand the reason for the rt_task_set_mode() function
> >>>>>>> call into the data acquisition loop (lines 413 or 464 in the code
> >>>>>>> shipped with xenomai 2.5.1).
> >>>>>>>
> >>>>>>> I do not understand why we have to set the primary mode at every
> >>>>>>> iteration, when we set it before for the task (line 380).
> >>>>>>>
> >>>>>>> Is it because the dump_function() uses system calls that can make the
> >>>>>>> task to switch to secondary mode, or there is a deeper reason I'm missing?
> >>>>>>>
> >>>>>> You are right. The dumping routine triggers a switch to secondary mode.
> >>>>>> That is why, the program switches back to primary mode after.
> >>>>> This is wrong. The Xenomai core will switch your real-time thread to
> >>>>> primary mode automatically when running a4l_insn* calls that end up
> >>>>> invoking rt_dev_ioctl(), since you did declare a real-time entry point
> >>>>> for this one.
> >>>>>
> >>>> I don't understand. I thought that rt_dev_ioctl() triggered an
> >>>> __rtdm_ioctl syscall, which, according to the rtdm systab, is declared
> >>>> with the flags "__xn_exec_current | __xn_exec_adaptive".
> >>>>
> >>>> So as __rt_dev_ioctl (the kernel handler behind the ioctl syscall) will
> >>>> return -ENOSYS neither in RT nor in NRT mode (because analogy declares
> >>>> both RT and NRT fops entries), I thought there was no automatic
> >>>> mode-switching.
> >>> The point is that your ioctl_nrt handler should return -ENOSYS when it
> >>> detects that the current request should be processed by the converse
> >>> domain, to trigger the switch to primary mode. This is why the adaptive
> >>> tag is provided in the first place.
> >> The problem is that rtdm does not provide any function to know whether
> >> the thread is shadowed. We just have rtdm_in_rt_context() which tells us
> >> whether the thread is RT or not. If it is NRT, we cannot distinguish a
> >> Linux thread from a Xenomai one.
> >>
> >> I thought with a little patch like this in ksrc/skins/rtdm/core.c, we 
> >> could force -ENOSYS if the calling thread was a Xenomai NRT thread:
> >>
> >>   diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
> >> index 8677c47..cc0cfe9 100644
> >> --- a/ksrc/skins/rtdm/core.c
> >> +++ b/ksrc/skins/rtdm/core.c
> >> @@ -423,6 +423,9 @@ do {									\
> >>   									\
> >>   	if (rtdm_in_rt_context())					\
> >>   		ret = ops->operation##_rt(context, user_info, args);	\
> >> +	else if (xnshadow_thread(user_info) != NULL &&			\
> >> +		 ops->operation##_rt != (void *)rtdm_no_support)	\
> >> +		ret = -ENOSYS;						\
> >>   	else								\
> >>   		ret = ops->operation##_nrt(context, user_info, args);	\
> >>   									\
> > 
> > No, this would be a half-working kludge. But I think you have pinpointed
> > a more general issue with RTDM: syscalls should be tagged as both
> > adaptive and conforming, instead of bearing the __xn_exec_current bit.
> > Actually, we do want the current domain to change when it is not the
> > most appropriate, which __xn_exec_current prevents so far.
> > 
> > What we rather want is to have shadows migrating to primary mode when
> > running rtdm_ioctl, since this is the preferred mode of operation for
> > Xenomai threads, so that ioctl_rt is always invoked first when present,
> > giving an opportunity to forward the request to secondary mode by
> > returning -ENOSYS. Conforming calls always enforce the preferred runtime
> > mode, i.e. primary for Xenomai shadows, secondary for plain Linux tasks.
> > That logic applies to all RTDM syscalls actually.
> > 
> > __xn_exec_current allows application code to infer that the RTDM driver
> > might behave differently depending on the current runtime mode of the
> > calling thread, which is very much error-prone, and likely not what was
> > envisioned initially.
> 
> Argh.... The switchtest driver is relying on __xn_exec_current to have
> context switches occur precisely in the mode we want.

The switchtest driver is aimed at testing that some processing do work
reliably in all runtime modes and execution domains, for that reason, it
_has to_ control the current mode, and why that code has to understand
the inner working of the Xenomai core to trigger exactly what it wants
to observe. But this is hardly what a normal application wants to deal
with.

>  __xn_exec_adaptive
> introduce more context switches around which we can not place separate
> checks for fpu context, so, in short, breaks it badly. Fixing this
> requires turning the switchtest driver into a skin with its own syscalls.
> 

Forget about switchtest when discussing the exec/adaptive bits, really.
The real issue is with the conforming bit actually. This app is one of a
kind, and exactly at the opposite of the normal use case we want to
follow the principle of least surprise.

switchtest is broken now because it used to rely on an anti-feature that
used to break application code. The sad truth is that by fixing the case
for the normal application usage, we broke switchtest. But this is at
least more acceptable.

> Note the sequence which occurs when a shadowed thread running in
> secondary mode calls an ioctl for which only an nrt implementation occurs:
> the thread is hardened to handle the ioctl
> ioctl_rt is called which returns -ENOSYS
> the thread is relaxed
> ioctl_nrt is called
> 

Yes, and that is to be expected and acceptable. In most drivers, how
many calls are implemented as secondary mode _only_, to be fired by rt
threads, that would trigger such double-switch? E.g. how many syscalls
do require to migrate to secondary because they rely on regular Linux
kernel services and may also be called by rt threads? 1%?
And of course, none of them can guarantee any real-time behaviour, so
you won't invoke them in your time-critical code, which means that one
context switch more in this case is not a serious issue.

So, it remains that in the overwhelming number of cases, people calling
a real-time driver want the driver to do, well, real-time things. And if
they don't in some instances, well, they just don't care about one
context switch more, to allow real-time threads to downgrade to the
proper mode, if this is what really bugs you.

> It boils down to putting an rt_task_set_mode(PRIMARY) before each rtdm
> syscall made by a thread with a shadow, and in fact seems to result in
> as bad a result. Is it really what we want? The __xn_exec_current bit
> resulted in a more lazy behaviour.
> 

switchtest wants to be lazy. Normal applications don't care a dime, they
are mainly dealing with real-time code, that requires real-time mode,
and as such a conforming call.

__xn_exec_current is actually carrying a MASSIVE bug potential:
- stick __xn_current to your favourite syscall, and implement two
versions of that syscall, depending on the current calling mode for the
shadow thread.
- let people think that they should control the current mode of that
thread using rt_task_set_mode() and this freaking horror monster called
T_PRIMARY, before calling the syscall in question, to get either
implementation A or B.
- run the stuff, and surprise, get a linux signal between
rt_task_set_mode and the syscall. Your thread is now NRT. Too bad, you
wanted the RT side to run. You are toast.

Besides, you could not even debug your application under GDB sanely in
that case, because tracing downgrades the caller to secondary, and
__xn_exec_current does not force migration.

> Also note that, at least when using the posix skin, almost all threads
> have shadows, and only the priority makes the difference between a
> really critical thread, and non critical threads with the null priority.
> So, this will happen all the time.
> 

Mmm. Is your point that most RTDM drivers out there are implementing
mostly linux mode calls to be run in time-critical tight loops?

-- 
Philippe.



