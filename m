Subject: Re: [Xenomai-help] Results of xenomai's latency test vs. RTAI's
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <15328399.1162222490427.JavaMail.ngmail@domain.hid>
References: <1162219241.5188.21.camel@domain.hid> <1162208265.4955.17.camel@domain.hid>
	<21364954.1162202747823.JavaMail.ngmail@domain.hid>
	<16802252.1162217706570.JavaMail.ngmail@domain.hid>
	<15328399.1162222490427.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 30 Oct 2006 18:44:22 +0100
Message-Id: <1162230262.5188.111.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-10-30 at 16:34 +0100, M. Koehrer wrote:
> Hi everybody,
>=20
> I have repeated the test using a parallel stress test (dd if=3D/dev/sda=
 of=3D/dev/null, I have
> a SATA harddisk).
> The results are that my RTAI latency of 4=B5s is not valid, here the la=
tency is about 26=B5s.
> However, xenomai shows a higher latency of about 40=B5s.
> The interesting thing is, that without load RTAI seems to run very long=
 in a very=20
> low latency region, at the same setup xenomai shows large latencies ear=
lier.
>=20

It has always been the case. A possible explanation could be the
immediate impact of the full interrupt/event virtualization Adeos
performs for Xenomai. The first contribution I once made to the RTAI
project back in late 2002, was to port the 24.1.x release over
Adeos/x86, in order to replace the former RTHAL. Doing so, I noticed
that when running over Adeos, RTAI quickly reached its latency
peak/worst-case after some time, but usually exhibited a lower variance
of the mean latency. The RTHAL had shorter latencies (5-10%) which
tended to converge close to the Adeos figures after a longer time (and
hours of debugging), but had higher variance figures on average.

Since the RTAI project has decided to go back to the RTHAL approach
circa 3.2 instead of using the vanilla Adeos support anymore, this
phenomenon is likely to have re-appeared when comparing a pure
Adeos-based implementation (i.e. Xenomai), and a raw/direct interrupt
handling from the x86 IDT to the RTOS innards.

>=20
> Well, I have repeated these tests on a different PC that has a server m=
ainboard and=20
> a Pentium D 4 (real dual core) CPU.
> The results (measured under load) are much better here:
> RTAI shows a latency of about 6=B5s
> Xenomai shows a latency of about 10=B5s.
> Both values are acceptable, however I wonder where the difference comes=
 from?
>=20

Again, it's difficult to discuss this matter without figures and
instrumentation at hand, but some facts are known. Among those, there is
more code traversed in the Xenomai case, from the receipt of an IRQ, to
the actual scheduling of the processing task, and the I-cache penalty is
larger for Xenomai, which benefits less from code locality than RTAI
does when it comes to measuring the performances using a basic latency
test.

Basically, the code in question implements the "abstract RTOS", Xenomai
APIs run over. For instance, each Xenomai API having to block a thread
calls a particular function into the abstract core to do so (i.e.
xnpod_suspend_thread()), and this is the one and only way to suspend a
thread (i.e. the API never accesses the scheduler innards directly). By
contrast, each synchronization/scheduling primitive RTAI defines
directly manages the scheduler internals on its own (e.g. sema4, queue,
fifos, any IPC in general, and the task management services, all fiddle
with the scheduler's data structures locally in the body of their own
routines).
A possible explanation for the (reasonably small) slowdown is that
Xenomai's abstract RTOS code:

- 1) needs to handle more situations since it could be called from many
more contexts, than a particular RTAI service could expect; this
directly translates into more complexity and CPU cycles. The good news
is that we don't have to fix core issues into each and every API when
the weather gets rainy, but only once in the abstract RTOS if needed
(e.g. think of something weird happening in the priority inheritance
code).
- 2) relies on a strict functional layering, which must have some impact
on the code locality at the very least, as more internal interfaces are
involved. On the other hand, the advantage is that Xenomai has been
successfully ported over five new architectures in less than two years,
all being maintained at the very same functional level (i.e. full kernel
and user-space support, tight integration within the Linux programming
model).
- 3) deals with the vanilla Linux kernel as a partner, not as an enemy.
For instance, an additional level of complexity is induced in order to
properly manage regular Linux signals. This is what it takes to be able
to gracefully end any RT application running in user-space through ^C,
or debugging it over GDB, without the box jumping of out the window,
screaming. This "integration with Linux" part does have an indirect cost
in terms of footprints, but from the user POV, it's worth the handful of
microseconds spent ensuring this. And to achieve that reliably over a
co-kernel technology, we need the Adeos model. Deeply.

Said differently, both projects have radically different views on key
key aspects:

- RTAI wants to eliminate Linux from the picture (so it uses radical
sideways to do so), Xenomai wants to share the picture with it (so it
conforms to all Linux semantics when integration is an issue, e.g.
signals).
- RTAI promotes its own API, Xenomai is API-agnostic because it was born
as a portability platform from traditional RTOSes to Linux (so we must
rely on some RTOS abstraction, not to reinvent the wheel each time we
add a new interface/emulator).
- RTAI is fundamentally tied to a co-kernel technology, because of #1.
Xenomai is not, because of #1, since the real-time enabling layer is
isolated from the RTOS that needs its services to operate the various
APIs properly.

All this translates in microseconds, because nothing is for free,
especially a design choice. This said, a margin of improvement still
exists, but reliability will always have precedence over raw latency
figures.

> Thanks for all the feedback on that issue!
>=20
> Regards
>=20
> Mathias
> > > I have rebuild my system using V2.2.4 of xenomai.
> > > Also, I had a look to reuse the kernel configuration from the 2.4.3=
3 RTAI
> > system.
> > > However, the results are more or less the same.
> > > The only kernel module I have loaded is the "tg3" network driver, t=
he
> > chipset of the=20
> > > PC (ICH6) is supported by the SMI detection and it is activated.
> > >=20
> >=20
> > On such hw, you may want to enable the following:
> > CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> > CONFIG_BLK_DEV_IDEDMA=3Dy
> > CONFIG_IDEDMA_AUTO=3Dy
> >=20
> > > I have enclosed my kernel configuration, perhaps this can help to i=
dentify
> > an issue.
> > > I do not have X11 running, it is a text-mode only system that is
> > controlled via telnet from
> > > another PC.
> > >=20
> > > I'll try to do a stress test on the RTAI system as well.
> > >=20
> >=20
> > You could try running RTAI 3.3 over 2.6.17 with the very same config
> > file too (Xenomai opts aside, of course), so you could rule out any
> > configuration problem if the gap still exists.
>=20
>=20
--=20
Philippe.



