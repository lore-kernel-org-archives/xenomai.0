Date: Mon, 27 Dec 2010 17:53:40 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1293467484.1856.0.camel@domain.hid>
Message-ID: <alpine.DEB.1.10.1012271753280.20479@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012271521010.20479@domain.hid>
	<1293467484.1856.0.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] gdb/gdbserver and pthread_cond_wait (was:
 gdb/gdbserver hangs...)
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai GNA <xenomai@xenomai.org>

Hi,

> The test code creates SCHED_OTHER threads. This is likely not what you
> wanted to do.

It indeed doesn't describe my original problem, but while compacting the test code, I found that it doesn't make a difference. The behaviour is the same (or at least the symptoms are the same) ..

   1. ... with the threads created with prio>0, EXPLICIT_SCHED and SCHED_FIFO
   2. ... with additionally the main thread being set up for SCHED_FIFO too

Kolja


