Message-ID: <4A0BC53F.5090505@domain.hid>
Date: Thu, 14 May 2009 09:16:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0905131634150.7706@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0905131634150.7706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Encouraging Xenomai test results
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

Martin Shepherd wrote:
> One thing that I don't understand is why whenever I ran my Xenomai
> test program, the Linux clock ran slow, losing about half an hour
> during the hour-long test. My realtime floating-point load task was
> designed to preempt the Linux kernel for about 3 seconds, then go to
> sleep for about 1.2 seconds, to give Adeos time to replay pending
> interrupts to the Linux kernel. Although the realtime interrupt
> strobing task was still running during the 1.2s pauses in the load
> task, it only ran for 30us every 1ms.  So I am wondering why so many
> timer interrupts appear not to have been played back by Adeos? I
> didn't seen any evidence of non-timer interrupts getting lost. Is this
> perhaps a side effect of turning off X86_PM_TIMER and HPET_TIMER, and
> leaving both Linux and Xenomai sharing the sole remaining timer?

Adeos no longer plays back the missed interrupts. It only plays back one
interrupt and let Linux' lost tick compensation algorithms do the rest.
Running real-time tasks for 3 seconds without leaving Linux run is a bad
idea (it is even surprising that it works at all). For Linux to work
correctly, we usually advise people not to let real-time task run for a
period longer than Linux tick period.

-- 
					    Gilles.

