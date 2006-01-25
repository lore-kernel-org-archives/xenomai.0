Date: Wed, 25 Jan 2006 16:24:03 -0500
From: Kent Borg <kentborg@domain.hid>
Subject: Re: [Xenomai-help] Signals
Message-ID: <20060125162403.Y17353@domain.hid>
References: <20060118162407.A28495@domain.hid> <43D7DD8C.60306@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D7DD8C.60306@domain.hid>;
	from jan.kiszka@domain.hid on Wed, Jan 25, 2006 at 09:20:28PM +0100
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
Cc: xenomai@xenomai.org

On Wed, Jan 25, 2006 at 09:20:28PM +0100, Jan Kiszka wrote:
> > rt_task_catch() and rt_task_notify()?
> 
> Those function are - in contrast to what to doc states - not yet
> available in userspace.

No wonder information on them is so sparse.

> So far Xenomai is lacking the infrastructure to
> deliver hard-RT signals to userspace threads, only the Linux signals are
> passed as usual.

But they are passed, that is good.

> Signals in multithreaded applications are tricky in general, even
> without Xenomai. You may try to play with pthread_kill and
> pthread_sigmask to control which thread receives a specific signal.

I have a very simple architecture, one thread is launched by regular
means, is launches the RT thread.  It is the parent thread that
registers for the signal and (I think!) it is the one that gets the
interrupt.

> When the signal receiver is a Xenomai thread, the usual things happen:
> blocking on RT-resources is cleared, the thread is migrated to secondary
> mode, and the signal handler is invoked as one expects.

Very interesting.  It sounds like Xenomai is doing cleanup I was
trying to do by hand.  Maybe that is why I crapped the kernel, I am
cleaning up stuff that doesn't exist anymore.  Should I deallocate my
RT fifos?


Thanks,

-kb

