From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B9EC305.4060707@domain.hid>
References: <4B97BA0C.9000702@domain.hid>  <4B9AD0DE.4020103@domain.hid>
	<1268472523.27899.135.camel@domain.hid>
	<4B9BB9B1.5050003@domain.hid>
	<1268498034.27899.167.camel@domain.hid>
	<4B9C2100.6090806@domain.hid>
	<1268584465.27899.197.camel@domain.hid>
	<4B9DE6BF.2000409@domain.hid> <4B9EC305.4060707@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Mar 2010 21:35:07 +0100
Message-ID: <1268944507.27899.386.camel@domain.hid>
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
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Tue, 2010-03-16 at 00:30 +0100, Alexis Berlemont wrote:
> Hi,
> 
> Jan Kiszka wrote:
> > Philippe Gerum wrote:
> >> On Sun, 2010-03-14 at 00:34 +0100, Alexis Berlemont wrote:
> >>> Philippe Gerum wrote:
> >>>> On Sat, 2010-03-13 at 17:13 +0100, Alexis Berlemont wrote:
> >>>>> Hi,
> >>>>>
> >>>>> Philippe Gerum wrote:
> >>>>>> On Sat, 2010-03-13 at 00:40 +0100, Alexis Berlemont wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> Sorry for answering so late. I took a few days off far from any internet
> >>>>>>> connection.
> >>>>>>>
> >>>>>>> It seems you sent many mails related with Analogy. Many thanks for your
> >>>>>>> interest. I have not read all of them yet. However, I am beginning by
> >>>>>>> this one (which seems unanswered). The answer is quick and easy :)
> >>>>>>>
> >>>>>>> Daniele Nicolodi wrote:
> >>>>>>>> Hello. I'm looking into the analogy cmd_write example.
> >>>>>>>>
> >>>>>>>> I'm not sure I understand the reason for the rt_task_set_mode() function
> >>>>>>>> call into the data acquisition loop (lines 413 or 464 in the code
> >>>>>>>> shipped with xenomai 2.5.1).
> >>>>>>>>
> >>>>>>>> I do not understand why we have to set the primary mode at every
> >>>>>>>> iteration, when we set it before for the task (line 380).
> >>>>>>>>
> >>>>>>>> Is it because the dump_function() uses system calls that can make the
> >>>>>>>> task to switch to secondary mode, or there is a deeper reason I'm missing?
> >>>>>>>>
> >>>>>>> You are right. The dumping routine triggers a switch to secondary mode.
> >>>>>>> That is why, the program switches back to primary mode after.
> >>>>>> This is wrong. The Xenomai core will switch your real-time thread to
> >>>>>> primary mode automatically when running a4l_insn* calls that end up
> >>>>>> invoking rt_dev_ioctl(), since you did declare a real-time entry point
> >>>>>> for this one.
> >>>>>>
> >>>>> I don't understand. I thought that rt_dev_ioctl() triggered an
> >>>>> __rtdm_ioctl syscall, which, according to the rtdm systab, is declared
> >>>>> with the flags "__xn_exec_current | __xn_exec_adaptive".
> >>>>>
> >>>>> So as __rt_dev_ioctl (the kernel handler behind the ioctl syscall) will
> >>>>> return -ENOSYS neither in RT nor in NRT mode (because analogy declares
> >>>>> both RT and NRT fops entries), I thought there was no automatic
> >>>>> mode-switching.
> >>>> The point is that your ioctl_nrt handler should return -ENOSYS when it
> >>>> detects that the current request should be processed by the converse
> >>>> domain, to trigger the switch to primary mode. This is why the adaptive
> >>>> tag is provided in the first place.
> >>> The problem is that rtdm does not provide any function to know whether
> >>> the thread is shadowed. We just have rtdm_in_rt_context() which tells us
> >>> whether the thread is RT or not. If it is NRT, we cannot distinguish a
> >>> Linux thread from a Xenomai one.
> >>>
> >>> I thought with a little patch like this in ksrc/skins/rtdm/core.c, we 
> >>> could force -ENOSYS if the calling thread was a Xenomai NRT thread:
> >>>
> >>>   diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
> >>> index 8677c47..cc0cfe9 100644
> >>> --- a/ksrc/skins/rtdm/core.c
> >>> +++ b/ksrc/skins/rtdm/core.c
> >>> @@ -423,6 +423,9 @@ do {									\
> >>>   									\
> >>>   	if (rtdm_in_rt_context())					\
> >>>   		ret = ops->operation##_rt(context, user_info, args);	\
> >>> +	else if (xnshadow_thread(user_info) != NULL &&			\
> >>> +		 ops->operation##_rt != (void *)rtdm_no_support)	\
> >>> +		ret = -ENOSYS;						\
> >>>   	else								\
> >>>   		ret = ops->operation##_nrt(context, user_info, args);	\
> >>>   									\
> >> No, this would be a half-working kludge. But I think you have pinpointed
> >> a more general issue with RTDM: syscalls should be tagged as both
> >> adaptive and conforming, instead of bearing the __xn_exec_current bit.
> >> Actually, we do want the current domain to change when it is not the
> >> most appropriate, which __xn_exec_current prevents so far.
> >>
> >> What we rather want is to have shadows migrating to primary mode when
> >> running rtdm_ioctl, since this is the preferred mode of operation for
> >> Xenomai threads, so that ioctl_rt is always invoked first when present,
> >> giving an opportunity to forward the request to secondary mode by
> >> returning -ENOSYS. Conforming calls always enforce the preferred runtime
> >> mode, i.e. primary for Xenomai shadows, secondary for plain Linux tasks.
> >> That logic applies to all RTDM syscalls actually.
> >>
> >> __xn_exec_current allows application code to infer that the RTDM driver
> >> might behave differently depending on the current runtime mode of the
> >> calling thread, which is very much error-prone, and likely not what was
> >> envisioned initially.
> > 
> > Right, this stickiness of RTDM syscalls to the current execution mode
> > conceptually dates back to the days we had users with services provided
> > to both domain. This model is deprecated (e.g. RTnet dropped resources
> > allocation from RT domain, only supports NRT now).
> > 
> > So I've no concerns making the call conforming - but... I guess this
> > would just paper over a design issue (or misunderstanding?) in Analogy.
> > Why does it depend on shadow vs. non-shadow at all? The explanations I
> > read so far were not clarifying the reason. Is there any Analogy service
> > that is provided to both domains (via different implementations)? If
> > yes, why?
> > 
> 
> Analogy provides all the services in both domains:
> - the instructions services are synchronous operations; no explicit
> rescheduling are triggered, consequently, the implementations of the
> various kinds of instructions displays are the same in both mode;
> - the commands services allow asynchronous operations; so the handlers
> behind the read / write fops are the same for RT and NRT entries;
> however, the event management code relies on rtdm_event in one case and
> on rtdm_nrtsig + waitqueues in the other case.
> 

Actually, the issue is not with having rt and regular tasks accept the
very same calls, it is with having the rt tasks potentially run
_different code_ for a very same request, depending on whether it is
running in primary or secondary mode.

That design issue is usually revealed by userland code switching mode
eagerly via rt_task_set_mode(), which means that the next syscall(s) may
be mode-sensitive, for that task. This is what should be fixed, without
implying that you may not define a mode-insensitive API, in order to
allow calls from rt _and_ non-rt tasks.

Provided the rtdm syscalls you need are made conforming, here is the
typical pattern I'm referring to for implementing them:

syscall_rt(...)
{
	/* We must be a shadow thread, since we got there */
	if (cant_provide_service_in_primary_mode())
		/* maybe available from secondary mode? forward it. */
		return -ENOSYS;

	do_service();
}

syscall_nrt(...)
{
	/* We could be a shadow thread unable to process the request in primary
mode, or a plain linux task. */

	do_service();
}



> The main part of the "event" code is located in a4l_wait_sync and 
> a4l_signal_sync.
> 
> Which design issue do you have in mind ?
> 
> Concerning your question: why ?
> 
> Not all the acquisition system users ask for determinism; working with
> real-time tasks may not be mandatory. So all they need to know is the
> Analogy API.
> 
> Furthermore, many acquisition boards have an impressive set of
> configuration parameters which are accessed via the operations described
> above. One may be interested in scripting a part of the user application
> so as to gain development time. I don't want to lose flexibility by
> confining Analogy to real-time tasks.
> 
> > Jan
> > 
> Alexis.


-- 
Philippe.



