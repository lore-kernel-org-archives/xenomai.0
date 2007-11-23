Message-ID: <2ff1a98a0711230617s27d1a330i8c88976bc1607e7f@domain.hid>
Date: Fri, 23 Nov 2007 15:17:56 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2F8EE677D406514ABE53EF9C0934A666042ABDF6@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2F8EE677D406514ABE53EF9C0934A666042ABDF6@domain.hid>
Subject: Re: [Xenomai-help] Communications between Threads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Laurent.POYART@fr.thalesgroup.com
Cc: xenomai@xenomai.org

On Nov 23, 2007 3:04 PM,  <Laurent.POYART@fr.thalesgroup.com> wrote:
> Dear all,
>
> I'm new in using xenomai and I'd like to use it for an embedded application in which I have standard linux drivers and RTDM drivers. I plan to use real-time threads for critical activities and regular linux threads soft real-time activites. Some real-time threads will communicate with regular linux threads (events and/or time notifications for example). As a part of my system, I could have a regular linux thread dynamically configured by another regular linux thread and notified of events by a real-time thread.
> I'd like to put in place a framework which encapsulate, among other things,thread communications mechanism and in this way I'd like to avoid multiple mechanisms to communicates between threads (nonRT<->nonRT  / nonRT<->RT) as I could do with a RTOS, but I don't know exactly what is possible to do with xenomai:
> *       Is it possible to use a single mechanism to communicate between threads (standard posix message queues, xenomai message pipe, others)? What kind of mechanism?
> *       Is it possible to use a standard posix message queue within a real-time thread and how do I affect the real-time thread behaviour?

It is possible to use a standard posix message queue within a
real-time thread, but your real-time thread will then switch to
secondary mode, which means it would no longer be real-time.
There is no communication mean which is indpendent from the thread type.

The usual answer to your question is to create the threads with non
real-time duties as well, and let them switch to primary mode when
they use real-time services, and switch to secondary mode when they
use non real-time services. Since these threads are not real-time,
they should use the SCHED_OTHER scheduling policy.

Another solution is to use native skin message pipes, which allow
communication between real-time and non real-time thread. But a
real-time thread reading or writing to the non real-time end of a
message pipe will switch to secondary mode, that is why you can not
use them for communication between real-time threads.

-- 
                                               Gilles Chanteperdrix

