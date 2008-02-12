Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Feb 2008 06:42:25 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376B4D@slcmail.slc.mew.int>
In-Reply-To: <47B1A023.8090009@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376B33@domain.hid>	<47B14FF9.8010207@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376B4B@slcmail.slc.mew.int>
	<47B1A023.8090009@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

> I'm not saying this. I'm saying that periodic task _timers_ fire
anyway,
> independent of the task waiting for them. So you should try to make
them
> fire at the same slots. That reduces the IRQ prologue/epilogue
overhead
> to 1, not n.

This makes sense, but if I simply disable the periodic timer then it
should have 0 timer overhead, and then I turn it periodic when I need
the task. The task timer won't fire if the periodic timer is disabled,
right?

> A fair comparison could be a non-real-time Linux benchmark that
consumes
> all the remaining CPU resources. Measure its execution time and you
have
> a reasonable metric for comparing the overall overhead. (The ROOT
thread
> CPU share with latest Xenomai should provide the same number, though.)

I should really get the old flash and take some measurements as
comparison.

> Lock nestings on a real-time system should be avoided, nesting levels
>=3D
> 2 can generally be considered as a fatal design mistake. Just imagine
> what the worst-case waiting time for your task is if all those locks
are
> contended! Maybe it is also worth thinking about some lock-less sync
> patterns for some of your scenarios.

Actually I disagree in this case. The reason is that each of the three
levels aren't interlocked. So, level 1 is the core, level 2 is something
that uses the core, and level 3 is something that uses something that
uses the core. Each one takes a little longer than the one below it, but
there is a very small worst case time for each that is deterministic. As
this time is (or should be!) much smaller than the base timer period
(125us) then things should be ok. They were, after all, just fine on the
RTAI version of this app. I was very pleased with the jitter and
response even on a crappy non-realtime friendly Geode.

I am starting to think about certain things, though, in order to keep
the syscalls to a minimum. We'd like to use Xenomai mainly for the
debugging capabilities that RTAI lacked. Having everything all in one
context makes for easy development. Obviously the sound driver is in the
kernel space, but that's small and simple.

Steven


