References: <1971847999.108624.1646393705887.JavaMail.zimbra@nod.at>
 <7cc78732bf4902691e4194f52738ef1380c52ca6.camel@siemens.com>
 <1918812394.108775.1646396125911.JavaMail.zimbra@nod.at>
 <87fsnxr3nc.fsf@xenomai.org>
 <2141336610.110112.1646424555986.JavaMail.zimbra@nod.at>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Questiion on commit: demo/cyclictest: fix time delta calculation
Date: Sun, 06 Mar 2022 18:03:57 +0100
In-reply-to: <2141336610.110112.1646424555986.JavaMail.zimbra@nod.at>
Message-ID: <87y21novsc.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai <xenomai@xenomai.org>


Richard Weinberger <richard@nod.at> writes:

> Philippe,
>
> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Philippe Gerum" <rpm@xenomai.org>
>> Florian pointed in the right direction when mentioning autotune: if the
>> core timer is not calibrated properly, Cobalt might try to compensate
>> for the basic latency of the platform too much, leading to early timer
>> shots. If such an early shot arrives and the test loop wakes up too
>> early, say in the code implementing clock_nanosleep (-n) case, 'next'
>> might actually be later in the timeline than 'now', leading to negative
>> differences in calcdiff().
>
> I did some more experiments. The system was already autotuned.
> But raising the base interval from 1000 (default) to 5000 made the issue
> go away.
>

Does the issue persist at any freq when resetting the clock gravity for
user-space timers to zero instead of (or after) autotuning? e.g.

$ echo "0u" > /proc/xenomai/clock/coreclck

--=20
Philippe.

