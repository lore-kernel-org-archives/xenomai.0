Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Apr 2011 08:30:48 +0200
Message-ID: <1183078C0D064042B3AD2D03E3859EF174E5BC@AREXCH02.mra.roland-man.biz>
In-Reply-To: <1303940558.1932.33.camel@domain.hid>
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz>
	<1303849652.1961.7.camel@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz>
	<1303940558.1932.33.camel@domain.hid>
From: <dietmar.schindler@domain.hid>
Subject: Re: [Xenomai-help] message pipe message boundaries
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Wednesday, April 27, 2011 11:43 PM
>=20
> On Wed, 2011-04-27 at 14:22 +0200, dietmar.schindler@domain.hid
> wrote:
> > ... Wouldn't it be desirable to implement the
> > readv file operation in the rtpipe driver so that the guarantee "One
> > read() per rt_pipe_write()" could cover readv(2) also?
>=20
> No objection to merge this. Patch welcome.

Well, I'll try to come up with one.

> >  (Besides, this
> > would make the phrase "Operates just like read" in the readv(2) man =
page
> > more correct.)
>=20
> Having readv() operate like read() would not give any guarantee wrt
> message boundaries, because it is the real-time write side which makes
> the decision regarding this, not the read side. So you could have
> readv() operate like read() and still have blurred boundaries in case
> rt_pipe_stream() is used instead of rt_pipe_write().

You are of course right, and what you wrote about readv also applies to =
read.

--=20
Dietmar

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

