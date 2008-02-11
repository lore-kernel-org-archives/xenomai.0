Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Feb 2008 13:54:20 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376B0A@slcmail.slc.mew.int>
In-Reply-To: <47B0B5B0.5050402@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376AFD@slcmail.slc.mew.int>
	<47B0ADE8.5060504@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376B02@domain.hid>
	<47B0B1E0.7030701@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376B08@domain.hid>
	<47B0B5B0.5050402@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] irq0
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

I'll give it a try a little later today and post my results then.

Thanks for the advice.

Steven

> -----Original Message-----
> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
> Sent: Monday, February 11, 2008 1:53 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] irq0
>=20
> Steven Seeger wrote:
> > All right. I'll re-use Philippe's patch that disables TSC on geode
and
> > compile the libs for use without TSC. However, this will not help my
> > overhead problems, correct? Won't it make them worse?
>=20
> That depends. If your timer IRQ goes off way more often than it
should,
> you burn much more power than you gain via the TSC short-cut. Plus, a
> broken TSC can have much more evil side effects on your timing.
>=20
> >
> > If xenomai is using tsc, then that's a good thing. The timing is all
> > correct it seems, and the jitter is low.
>=20
> If the TSC is correct, yes. But we cannot tell if it's correct. Only
you
> can try to systematically analyse all the effects you observed, apply
> the tests we suggested, collect more data about what is going on. We
can
> only help with a better picture of your system.
>=20
> Jan


