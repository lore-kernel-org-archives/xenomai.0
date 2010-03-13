From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B9BB9B1.5050003@domain.hid>
References: <4B97BA0C.9000702@domain.hid>  <4B9AD0DE.4020103@domain.hid>
	<1268472523.27899.135.camel@domain.hid>
	<4B9BB9B1.5050003@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 13 Mar 2010 17:33:54 +0100
Message-ID: <1268498034.27899.167.camel@domain.hid>
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
Cc: xenomai@xenomai.org

On Sat, 2010-03-13 at 17:13 +0100, Alexis Berlemont wrote:
> Hi,
> 
> Philippe Gerum wrote:
> > On Sat, 2010-03-13 at 00:40 +0100, Alexis Berlemont wrote:
> >> Hi,
> >>
> >> Sorry for answering so late. I took a few days off far from any internet
> >> connection.
> >>
> >> It seems you sent many mails related with Analogy. Many thanks for your
> >> interest. I have not read all of them yet. However, I am beginning by
> >> this one (which seems unanswered). The answer is quick and easy :)
> >>
> >> Daniele Nicolodi wrote:
> >>> Hello. I'm looking into the analogy cmd_write example.
> >>>
> >>> I'm not sure I understand the reason for the rt_task_set_mode() function
> >>> call into the data acquisition loop (lines 413 or 464 in the code
> >>> shipped with xenomai 2.5.1).
> >>>
> >>> I do not understand why we have to set the primary mode at every
> >>> iteration, when we set it before for the task (line 380).
> >>>
> >>> Is it because the dump_function() uses system calls that can make the
> >>> task to switch to secondary mode, or there is a deeper reason I'm missing?
> >>>
> >> You are right. The dumping routine triggers a switch to secondary mode.
> >> That is why, the program switches back to primary mode after.
> > 
> > This is wrong. The Xenomai core will switch your real-time thread to
> > primary mode automatically when running a4l_insn* calls that end up
> > invoking rt_dev_ioctl(), since you did declare a real-time entry point
> > for this one.
> > 
> 
> I don't understand. I thought that rt_dev_ioctl() triggered an
> __rtdm_ioctl syscall, which, according to the rtdm systab, is declared
> with the flags "__xn_exec_current | __xn_exec_adaptive".
> 
> So as __rt_dev_ioctl (the kernel handler behind the ioctl syscall) will
> return -ENOSYS neither in RT nor in NRT mode (because analogy declares
> both RT and NRT fops entries), I thought there was no automatic
> mode-switching.

The point is that your ioctl_nrt handler should return -ENOSYS when it
detects that the current request should be processed by the converse
domain, to trigger the switch to primary mode. This is why the adaptive
tag is provided in the first place.

If the above can't be done, this means that such ioctl request has a
different implementation for a real-time task, depending on whether it
runs in primary or secondary mode, which would turn out to be the basic
issue: this would be ambiguous and very much error-prone. This is where
relying on rt_task_set_mode() may reveal design issues.

> 
> So, for me, an RT task running in secondary mode, which triggers an RTDM
> ioctl, stays in the current mode (NRT mode) if the RTDM IOCTL NRT
> handler is available. For me, switching back to primary mode if the RT
> handler is available is not the current behaviour.
> 
> What did I miss ?
> 
> > Let's summarize the whole point of forcing primary mode through
> > rt_task_set_mode(): it's bad, it's wrong, it's counter-productive
> > CPU-wise, it usually reveals a design issue in the calling code in most
> > cases.
> > 
> > The only application-level use case where switching to primary mode
> > eagerly this way might make sense, is when the code first switches to
> > secondary, then runs an awful lot of CPU-intensive code without issuing
> > any syscall, one might want to keep un-preempted from Linux IRQs. In
> > such a case, the question which arises immediately is: why the hell does
> > one ever tolerate switching to secondary mode initially, if strict
> > timely behavior is wanted later on? 
> > 
> > That crap is a freaking mistake of mine, when I exported such
> > anti-feature via the native API mindlessly, to provide a work-around for
> > rare situations some internal Xenomai code might benefit from. I should
> > have provided an internal syscall instead, to hide this monster deep
> > into the abyssal zone it should never have left.
> > 
> > In short: DO NOT USE THIS.
> 
> I will remove it in cmd_read and cmd_write.
> 
> > 
> >> Almost all the Analogy programs (cmd_read, cmd_write, insn_read,
> >> insn_write, insn_bits) are just demonstration examples. That is why the
> >> code is so linear, lengthy and repetitive. Furthermore, the code was not
> >> meant to be efficient. I just wanted to test the RT and NRT entries.
> >>
> >> By the way, I started to improve them. One change (which is still
> >> missing) is the use of rtdk.
> >>
> >>> Thanks. Cheers,
> >> Alexis.
> >>
> >> _______________________________________________
> >> Xenomai-help mailing list
> >> Xenomai-help@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-help
> > 
> > 
> 
> Alexis.


-- 
Philippe.



