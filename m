From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1012271744460.20479@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012271521010.20479@domain.hid>
	<1293467484.1856.0.camel@domain.hid>
	<alpine.DEB.1.10.1012271744460.20479@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Dec 2010 18:13:10 +0100
Message-ID: <1293469990.1856.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gdb/gdbserver and pthread_cond_wait (was:
 gdb/gdbserver hangs...)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: kawk@domain.hid
Cc: Xenomai GNA <xenomai@xenomai.org>

On Mon, 2010-12-27 at 17:50 +0100, Kolja Waschk wrote:
> Hi,
> 
> > The test code creates SCHED_OTHER threads. This is likely not what you
> > wanted to do.
> 
> It indeed doesn't describe my original problem, but while compacting the test code, I found that it doesn't make a difference. The behaviour is the same (or at least the symptoms are the same) ..
> 
>   1. ... with the threads created with prio>0, EXPLICIT_SCHED and SCHED_FIFO
>   2. ... with additionally the main thread being set up for SCHED_FIFO too

A possible explanation is that we know ptrace() is sending your app
linux signals, particularly with legacy linuxthreads under the hood.
Since your thread relaxes due to printf() as well, the combination of
both events normally bumps the current thread out of real-time mode AND
stops the RPI boost too, which may cause the next thread to preempt.

What happens if you only log the debug info in some global array, and
dump its contents after all threads are joined, instead of issuing
printf() in the thread body?

> 
> Kolja
> 

-- 
Philippe.



