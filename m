Message-ID: <33139598.1162206356611.JavaMail.ngmail@domain.hid>
Date: Mon, 30 Oct 2006 12:05:56 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Results of xenomai's latency test vs. RTAI's
	latency
In-Reply-To: <4545D257.3000602@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4545D257.3000602@domain.hid>
	<21364954.1162202747823.JavaMail.ngmail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,

thanks for your reply.

> > I am currently checking XENOMAI (V2.2.3 on a 2.6.17.7 kernel P4) to see=
 if
> I can use it
> > as replacement for a RTAI 3.3-cv application.
> > The first thing I did was to run the latency test in the the xenomai's
> testsuite directory.
> > The results of the worst time latency are really ugly - about 40=B5s!
> > On the very same PC I got a value of about 5=B5s using RTAI 3.3-cv runn=
ing
> the RTAI's
> > user/latency test.
>=20
> I'm _very_ sceptical about your 5 us. Could you elaborate on how you
> load your box and how long those tests ran? See also TROUBLESHOOTING in
> the Xenomai source tree on appropriate load for triggering the worst case=
.

My test setup was the same in both cases.
I connect to the RTAI/Xenomai PC via telnet and let the latency test run fo=
r about 5 minutes.
No other activity happens (well, there are a couple of services running lik=
e
apache, ... - but they should not cause any load).
The strange thing, is that in Xenomai even after a few seconds a latency in=
 the range of the
maximum latency is shown.

I can retry the tests using a background stress situation.



--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

