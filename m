Message-ID: <45D2E86C.2010200@domain.hid>
Date: Wed, 14 Feb 2007 11:46:04 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CONFIG_PREEMPT & irqbench
References: <45D25145.3000407@domain.hid>	<45D2CE27.5040303@domain.hid>
	<45D2DD6E.5030800@domain.hid>
	<45D2E468.3080402@domain.hid>
In-Reply-To: <45D2E468.3080402@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Reply-To: Markus.Franke@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

Jan Kiszka wrote:
> Of course, irqloop runs in *primary* mode to be able to handle the
> events deterministically. So it is not directly affected by CONFIG_PREEMPT.

If I start irqloop in User-Mode, a thread is simply created via Linux
system call pthread_create() which interacts with the
xeno_irqbench-driver via ioctl(). But then I don't understand why
irqloop is running in Primary (Xenomai) Mode? Because of the interaction
with the RTDM-based driver?
I am just wondering because I can't see something like rt_task_create().

> Yes, if you have an RT thread that issues syscalls and wishes to have
> them handled as fast as possible, CONFIG_PREEMPT should be enabled (and
> CONFIG_XENO_OPT_RPIDISABLE should remain off, maybe you even want to
> consider CONFIG_XENO_OPT_ISHIELD then). Such RT application designs are
> tricky to get correct and deterministic, so it's often better to not
> rely on these properties and rather seek a clear separation of pure RT
> threads on the one side and Linux syscall issuing non-RT or RT
> borderline threads (low-prio RT threads that are being switched back and
> forth between primary and secondary mode) on the other.

Ok I understand. So native kernel preemption should only provide better
results if you have realtime-threads issuing linux systemcalls which is
not really convenient.

> Shadowed by CONFIG_DEBUG=n likely.

probably by CONFIG_DEBUG_KERNEL=n

