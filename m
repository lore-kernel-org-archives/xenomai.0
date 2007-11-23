Message-ID: <2F8EE677D406514ABE53EF9C0934A666042ABDF8@domain.hid>
From: Laurent.POYART@fr.thalesgroup.com
Date: Fri, 23 Nov 2007 15:45:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: xenomai@xenomai.org

Hi,


<<It is possible to use a standard posix message queue within a
real-time thread, but your real-time thread will then switch to
secondary mode, which means it would no longer be real-time.>>

Does the thread keep a higher priority compared to a standard linux =
thread?
I don't really feel the effect of the switch from the primary mode to =
the
secondary mode.

Regards.
L.Poyart.



-----Message d'origine-----
De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Envoy=E9 : vendredi 23 novembre 2007 15:18
=C0 : Laurent.POYART@fr.thalesgroup.com
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai-help] Communications between Threads


On Nov 23, 2007 3:04 PM,  <Laurent.POYART@fr.thalesgroup.com> wrote:
> Dear all,
>
> I'm new in using xenomai and I'd like to use it for an embedded
application in which I have standard linux drivers and RTDM drivers. I =
plan
to use real-time threads for critical activities and regular linux =
threads
soft real-time activites. Some real-time threads will communicate with
regular linux threads (events and/or time notifications for example). =
As a
part of my system, I could have a regular linux thread dynamically
configured by another regular linux thread and notified of events by a
real-time thread.
> I'd like to put in place a framework which encapsulate, among other
things,thread communications mechanism and in this way I'd like to =
avoid
multiple mechanisms to communicates between threads (nonRT<->nonRT  /
nonRT<->RT) as I could do with a RTOS, but I don't know exactly what is
possible to do with xenomai:
> *       Is it possible to use a single mechanism to communicate =
between
threads (standard posix message queues, xenomai message pipe, others)? =
What
kind of mechanism?
> *       Is it possible to use a standard posix message queue within a
real-time thread and how do I affect the real-time thread behaviour?

It is possible to use a standard posix message queue within a
real-time thread, but your real-time thread will then switch to
secondary mode, which means it would no longer be real-time.
There is no communication mean which is indpendent from the thread =
type.

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

--=20
                                               Gilles Chanteperdrix

