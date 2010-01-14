Message-ID: <4B4F2F05.1040407@domain.hid>
Date: Thu, 14 Jan 2010 15:49:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <065A7D06F7D4E546A18E80E08D066E18146A3016C3@domain.hid>
	<4B4B64AF.3040704@domain.hid>
	<065A7D06F7D4E546A18E80E08D066E18146A301A0A@ILMA1.IL.NDS.COM>
	<4B4C5EDA.5000703@domain.hid>
	<065A7D06F7D4E546A18E80E08D066E18146A341B1B@ILMA1.IL.NDS.COM>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E18146A341B1B@ILMA1.IL.NDS.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai user app working very slowly - "select"
 issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Landau, Bracha wrote:
> I rebuilt with 2.5.0 and that particular problem is gone.
> However, I see a different behavior between the regular implementation and the xenomai implementation:
> 
> I have a series of identical threads waiting, using select, on one of two message queues. One message queues is waited upon only by that thread, and the other is waited upon by all the threads. When the select returns the thread reads from the queue that has input ready.
> 
> I sent messages to the general queue (i.e., the one waited upon by multiple threads).
> 
> In the regular (non-xenomai) implementation, I see that the messages were processed more-or-less equally among all the waiting threads.
> 
> In the xenomai implementation, all the messages were processed by a single thread.
> 
> Is there any way to make the scheduling done more "fairly" in xenomai?

The SCHED_FIFO policy is the contrary of fairness. Have you try to use
the SCHED_FIFO policy with Linux too?

There is not much point using several thread to select on the same file
descriptor. The point of select is rather the reverse: being able to
wait for several file descriptors with only one thread. If you have

If the thread have different priorities, the woken up thread is always
the thread with the highest priority.

Other than that, I do not really understand what you are talking about,
your description of the problem is rather vague. Please post a test case.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

