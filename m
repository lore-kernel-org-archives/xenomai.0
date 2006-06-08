Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] xenomai and ppc issues
Date: Thu, 8 Jun 2006 14:45:41 +0200
Message-ID: <756DFD3DE8F1D411A59A00306E06E84704707D06@domain.hid>
In-Reply-To: <448808E2.3050900@domain.hid>
From: "GUARDIOLA-FALCO Sebastien 204282" <Sebastien.GUARDIOLA-FALCO@domain.hid>
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

Thanks, I guess the 2.1.2 release works with 2.4 kernel.

I will post PPC results when I have it, for sure.

Regards,

S=E9bastien.

-----Message d'origine-----
De : jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
Envoy=E9 : jeudi 8 juin 2006 13:24
=C0 : GUARDIOLA-FALCO Sebastien 204282
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai-help] xenomai and ppc issues


GUARDIOLA-FALCO Sebastien 204282 wrote:
> Hello,
>=20
> I'm involved in a real-time project for a PPC mvme2700 target, and I =
need hard real-time tasks that can be executed in user-space. Seems that =
only Xenomai can meet the requirements.
> My first question is to have confirmation that RTAI or LXRT are x86 =
based and can not help me.

RTAI used to support other archs as well, but the situation has changed
AFAIK.

> The second issue is to know how I can install Xenomai (do I need to =
install Adeos kernel first? which version should I download?)

Start with the latest stable release (2.1.2) and follow README.INSTALL.

> and to know how far Xenomai goes in hard real-time (better preemption =
latency that RTAI?).

Cannot comment on this as I do not have comparable numbers for PPC. Once
you have 2.1.2 running, check the testsuite (xeno-test script or
individual tests) to get an impression of what is possible. You are
invited to post results here in order to let other PPC user
cross-check/comment (an automated test with online result database is
under development).

Xenomai constantly improves with respect to worst-case latency and
overall performance. Upcoming version 2.2 will introduce, e.g.,
additional optimisations which can reduce user space scheduling
latencies by ~20%. But, of course, the closer your design requirements
get to the benchmark results, the more careful and intensive your
performance analysis of the final system has to be.

Jan


