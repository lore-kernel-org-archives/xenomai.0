Message-ID: <493D5249.8030909@domain.hid>
Date: Mon, 08 Dec 2008 17:58:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200812081707.22246@domain.hid>
	<200812081708.3537@domain.hid>	<200812081709.17083@domain.hid>
	<200812081710.4784@domain.hid>	<200812081711.32480@domain.hid>
	<200812081712.4953@domain.hid>	<200812081713.10238@domain.hid>
	<200812081714.30317@domain.hid> <200812081718.8273@domain.hid>
In-Reply-To: <200812081718.8273@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel panic: not syncing - part 2
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
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Petr Cervenka wrote:
> Hello again,
> I have though, that all my troubles with this kernel panic (see https://mail.gna.org/public/xenomai-help/2008-07/msg00054.html) are over, but suddenly it reappeared.
> The full log is in attachment. I used snapshot of screen, OCR program and manual correction, so expect possible errors in log.
> I haven't seen the error for months, I was believed that it was caused the combination of other two problems (hopefully already solved or evaded). But this kernel panic emerged  during the weekend test, when we tested usability of a new motherboard for our purposes.
> It's perhaps not critical for me, but if you have any advices or questions, I'm listening.

Due to the interrupt deferral the I-pipe enforces, it may well happen that we
log and postpone a timer IRQ while the root stage is stalled during a task
switch, which gets eventually played right after the context switch has taken
place, after a different memory context for the next task is reinstated. The
profiler code then tries to dereference a memory address obtained from the IRQ
stack frame that does not exist in the new context. Too bad.

Ok, we need to think about this.

> Thanks
> Petr
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

