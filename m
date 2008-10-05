Message-ID: <48E8B91B.1060502@domain.hid>
Date: Sun, 05 Oct 2008 14:54:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1KmEP8-0003wS-5y@domain.hid> <48E8AFB4.4040208@domain.hid>
	<48E8B29D.5040705@domain.hid> <48E8B704.8030403@domain.hid>
In-Reply-To: <48E8B704.8030403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-commits] r4210 - in /trunk:
	ChangeLog	src/skins/native/task.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Author: gch
>>>> Date: Sat Oct  4 23:11:09 2008
>>>> New Revision: 4210
>>>>
>>>> URL: http://svn.gna.org/viewcvs/xenomai?rev=4210&view=rev
>>>> Log:
>>>> Call __real_pthread_setschedparam in order to inform the libc of the scheduling parameters change.
>>> Well, I dropped this idea after realizing that it will kick us out of
>>> primary mode in all cases. This change is an improvement (/wrt Linux
>>> scheduling accuracy) for borderline threads, but it will cause
>>> regressions for primary-only threads. I have no idea right now how to
>>> make both happy, at least without explicit pthread_setschedparam
>>> invocations by the user application.
>> Well, we discussed this on the xenomai mailing list, you did not answer,
>> so we assumed you agreed.
> 
> I do not find any hint in that thread that we agreed on changing the
> implementation. Rather I took back my suggestion to do it like #4210.
> And you proposed to install some signal for syncing glibc /wrt
> priorities. When changing something, then I would say explore this path
> first.

We are used to hear you when you do disagree... So, since you did not
answer Philippe mail who said "it is certainly debatable", we assumed
you agreed. But we certainly were wrong.

> 
> Turning rt_task_set_priority into secondary-mode service is a critical
> change, and only the last resort if we consider its current
> implementation as totally broken - I wouldn't say it is like that. It's
> partially and, unfortunately, silently broken, ie. lacking documentation
> about its limitations. But its perfectly OK for primary-only users.

No, an important invariant of Xenomai is that the priority scales are
synchronized between Xenomai and Linux. So, if Linux does not see the
same priority as Xenomai, the implementation is broken. Imagine for
instance that your primary-only thread posts an NPTL semaphore, knowing
that a switch will not occur so that it will not leave primary mode. If
the glibc does not see the correct priority, then a mode switch may
occur whereas it should not. This is a bit far-fetched, but who knows
what else may happen if the priorities are not synchronized. We
absolutely want the priorities to be synchronized.


-- 
					    Gilles.

