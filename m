Message-ID: <21364954.1162202747823.JavaMail.ngmail@domain.hid>
Date: Mon, 30 Oct 2006 11:05:47 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Results of xenomai's latency test vs. RTAI's latency
	test
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

Hi everybody,

I am currently checking XENOMAI (V2.2.3 on a 2.6.17.7 kernel P4) to see if =
I can use it
as replacement for a RTAI 3.3-cv application.
The first thing I did was to run the latency test in the the xenomai's test=
suite directory.
The results of the worst time latency are really ugly - about 40=B5s!
On the very same PC I got a value of about 5=B5s using RTAI 3.3-cv running =
the RTAI's
user/latency test.

My question is now: Why can there be such a huge difference between the two=
 systems on the very same
hardware??
Is there a way to improve this value?

The RTAI system uses a 2.4.33 kernel, the XENOMAI uses the 2.6.17.7 kernel.=
 Could this
be an issue?

Thanks for any feedback on that issue!

Mathias


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

