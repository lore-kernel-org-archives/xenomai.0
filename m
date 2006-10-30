Subject: Re: [Xenomai-help] Results of xenomai's latency test vs. RTAI's
	latency test
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <21364954.1162202747823.JavaMail.ngmail@domain.hid>
References: <21364954.1162202747823.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 30 Oct 2006 12:37:44 +0100
Message-Id: <1162208265.4955.17.camel@domain.hid>
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

On Mon, 2006-10-30 at 11:05 +0100, M. Koehrer wrote:
> Hi everybody,
>=20
> I am currently checking XENOMAI (V2.2.3 on a 2.6.17.7 kernel P4) to see=
 if I can use it
> as replacement for a RTAI 3.3-cv application.
> The first thing I did was to run the latency test in the the xenomai's =
testsuite directory.
> The results of the worst time latency are really ugly - about 40=B5s!
> On the very same PC I got a value of about 5=B5s using RTAI 3.3-cv runn=
ing the RTAI's
> user/latency test.
>=20
> My question is now: Why can there be such a huge difference between the=
 two systems on the very same
> hardware??
> Is there a way to improve this value?
>=20
> The RTAI system uses a 2.4.33 kernel, the XENOMAI uses the 2.6.17.7 ker=
nel. Could this
> be an issue?
>=20

Several issues there:

- are you 100% sure that your kernel config file for 2.4.33 is perfectly
recycled for 2.6.17, e.g. are all latency killer options as listed in
the TROUBLESHOOTING file really disabled? P4 configurations are
jitter-prone; some options are know to induce bad latencies.

- worst-case figures do not depend on how fast you get them, the latter
information gives you nothing to interpret from. You may want to stress
test the box for a longer period of time, using things like e.g. a dd
loop, and a compilation in the background (dd if=3D/dev/zero of=3D/somefi=
le
count=3D500 bs=3D1M). "ping" network test is not the worst latency raiser=
,
actually, under some circumstances, it could even hide some latency
issues, basically because it favours the code locality in i-cache. Also
make sure to measure without X-window interaction in both cases; some
graphic card drivers induce latencies, some don't. YMMV.

This said, 40us on a P4 class machine is not an expected value for
Xenomai/x86. To give you some reference figures, I have a uniprocessor
2.8Ghz Xeon box (no HT) performing at 15 us worst-case, and an older
dual 2.4Ghz Xeon SMP which honours 25 us worst-case in SMP mode. Fact is
that to get that, I need to disable a number of ACPI options (except
those which are needed to boot properly in SMP mode), and activate the
SMI work-around.

And above all, a good starting point would be to send your kernel
configuration file, so that we could discuss about facts. Additionally,
you may want to upgrade to 2.2.4; 2.2.3 has a FPU issue on some hw.

> Thanks for any feedback on that issue!
>=20
> Mathias
>=20
>=20
--=20
Philippe.



