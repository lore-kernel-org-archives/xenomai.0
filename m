Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 8 Feb 2008 12:20:04 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376A69@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] BUG fs/buffer.c:1245
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

It's very hard to reproduce. I found via google a bug report about the
same bug, but it turned out to be a patch in the e1000 driver. I'm using
the eepro100 driver. I wonder if the issue is related? I should see if
it's fixed in 2.6.24.

Steven
>=20
> > -----Original Message-----
> > From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid]
> > Sent: Friday, February 08, 2008 11:30 AM
> > To: Steven Seeger
> > Cc: xenomai@xenomai.org
> > Subject: Re: [Xenomai-help] BUG fs/buffer.c:1245
> >
> > Sporadic or deterministic bug? Specifically in case of the latter I
> > would be interested in your .config.
> >
> > Unless the slowdown papers over the actual issue, letting the ipipe
> > tracer run, so that it reports a nice backtrace on the BUG, may help
us
> > tracking down the point where irq_enable is missing (also in
> > non-Xenomai/Ipipe code).
> >
> > Jan


