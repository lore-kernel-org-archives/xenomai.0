Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Feb 2008 06:14:17 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376B4B@slcmail.slc.mew.int>
In-Reply-To: <47B14FF9.8010207@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376B33@domain.hid>
	<47B14FF9.8010207@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] pit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

> That makes sense: Periodic timers keep on firing. That would explain
up
> to 16000 IRQ invocations per second. And the other 1000-2000 come from
> Linux?

I have linux set to "tickless" in one setting, and 1000Hz in another.
Weird.

>=20
> As suggested earlier: you can reduce the number of IRQ events by
basing
> your periodic tasks on the same start date. Then both will be woken up
> at the same times and their priority will decide about the execution
order.

The problem here is that many tasks are periodic, but not always
required to run. Having them wake and wait for another period to do
nothing is also overhead.

> Do you need Linux at 1 KHz? You may even want to try NO_HZ.

It's set to "tickles."

> I'm still wondering with what older numbers you compare all the nice
> stats you now generate. Neither older Xenomai nor RTAI provide
> comparable statistics. Are we doing fair comparisons here?

Well, RTAI had that output where it would give load values in 1/10th of
a percent. (IIRC) The comparisons come from that. If, as Philippe says,
RTAI charges that load to the pre-empted context, then I'm not sure
where those numbers were coming from.

I do know that the system worked. I did some more experimenting and
timing functions, and it seems the source of all my woes are syscalls.
Namely, mutexes. There are several different resource sub-systems that
layer off each other in this application. The highest-level one requires
three mutex locks before doing a few IO operations. It takes me about
150 us to lock these three mutexes when nothing else is using them.

Steven


