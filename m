Message-ID: <484312F8.8030902@domain.hid>
Date: Sun, 01 Jun 2008 23:22:00 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <dea601970806011103r24fb6815k7cccbcc4d09f028a@domain.hid>
In-Reply-To: <dea601970806011103r24fb6815k7cccbcc4d09f028a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Xenomai porting
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Aitor Viana <aitorvs@domain.hid>
Cc: xenomai@xenomai.org

Aitor Viana wrote:
> I am new in Xenomai issues. I would like to begin porting Xenomai to the
> LEON2 architecture (sparcv8) but I don't know how to begin from. Is
> there any documentation or so explaining how to port xenomai to support
> another architecture?


There is no cookbook for that, so here are a few hints:

- porting Xenomai to a new Linux architecture means porting Adeos/I-pipe first;
it's a reasonably thin layer patched into the Linux kernel. You may want to read
that document to understand why we need it:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/Life-with-Adeos-rev-B.pdf.
If you want to host Xenomai on bare metal, without Linux underneath, then you
don't need to port Adeos. You only need to start from the next step.

- finally, you need to interface the system and hardware abstraction layers
Xenomai exposes to your environment. Those layers are made of the xnarch_* and
rthal_* routines available from include/asm-* and ksrc/arch/*. You will need to
find out how to do that by looking at an existing port. I usually recommend to
start with the powerpc/ port (include/asm-powerpc). Depending on whether you
interface Xenomai to Linux or not, some of those layers may interact with the
Linux kernel API, or provide the required services on their own (if the latter
applies, see the simulator port in include/asm-sim as an illustration of how to
simulate the hw system on top of purely software components, e.g. event-driven
engine + glibc -- there we don't hook to any kernel interface).

arch-dependent code is exclusively kept under the include/asm-* and ksrc/arch/*
subdirs. No need to look elsewhere.

Last hint, as a typical porting sequence:
- port Adeos (if needed)
- port the arch-dep layers
- make a simple kernel-based Xenomai thread run (see xnpod_init_thread(),
xnpod_start_thread()).
- validate with the klatency test.
- start measuring the typical jitter, and chase long latency spots if any, using
the Adeos tracer (CONFIG_IPIPE_TRACER). The Xenomai website has some hints about
it. Make sure to fix pathological latencies at _this_ stage and _not_ later; it
will allow you to point the finger at user-space support (the next step) for
later latency issues, when you introduce it (and this stuff is prone to create
jittery during the early stages of a port, due to interactions with the regular
Linux kernel).
- make a simple user-space Xenomai thread run (if Linux is underneath). You will
need to have a look at include/asm-*/syscall.h.
- validate with the latency test (i.e. $ ./latency -t0).

> 
> Thanks a lot in advanced.
> 
> Aitor
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

