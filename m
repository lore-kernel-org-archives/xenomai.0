MIME-Version: 1.0
In-Reply-To: <4BB53643.2080604@domain.hid>
References: <20100401230843.GF3755@domain.hid>
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>
Date: Fri, 2 Apr 2010 09:58:05 +0200
Message-ID: <j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

We have the same requirement for which we also have no solution. One
of our threads has a configurable priority of which at the lowest
priority the thread should behave like an idle task that is only
scheduled when all xenomai threads are idle and also the Linux domain
is idle. The thread might use rtdm-drivers and xenomai mutexes and
therefore has to be moved to the Xenomai domain. But then it always
has higher priority than any threads scheduled in linux.

Actually, when seen from the first domain, this requirement would be
solved when we could set a first domain priority for the second
domain... Gilles, is that what is meant by the SCHED_IDLE policy for
Linux?


On Fri, Apr 2, 2010 at 2:11 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Jan Kiszka wrote:
>> Andreas Glatz wrote:
>>> Hi Philippe,
>>>
>>> At the Xenomai Users Meeting last year I asked you if Xenomai would off=
er a possibility to lower the priority of certain Xenomai tasks below that =
of Linux. We need this feature since we have tasks in our RT application wh=
ich should only run when Linux is idle (A statistics collection task which =
part of the RT application and hard to isolate from this application).
>>>
>>
>> What prevents using a borderline thread (if you need to interact with
>> blocking Xenomai services) with SCHED_OTHER and a Linux nice level of 19=
?
>
> Well, this does not really guarantee that the thread will run only when
> linux is idle. The thread will eat some cpu time, the nice level is not
> a strict priority, as you know. But in fact, I wonder why Andreas wants
> a new scheduling policy for xenomai, what is needed, is simply a
> SCHED_IDLE (maybe it exists ?!) policy for Linux.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

