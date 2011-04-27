Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Apr 2011 10:50:21 +0200
Message-ID: <1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid>
In-Reply-To: <1303849652.1961.7.camel@domain.hid>
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz>
	<1303849652.1961.7.camel@domain.hid>
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

> From: xenomai-help-bounces@domain.hid
[mailto:xenomai-help-bounces@domain.hid]
> On Behalf Of Philippe Gerum
> Sent: Tuesday, April 26, 2011 10:28 PM
>=20
> On Tue, 2011-04-26 at 11:48 +0200, dietmar.schindler@domain.hid
> wrote:
> > The documentation of rt_pipe_write() says: "rt_pipe_write() always
> > preserves message boundaries, which means that all data sent through
a
> > single call of this service will be gathered in a single read(2)
> > operation from the special device." Is this supposed to mean also
that
> > data sent through two calls of this service will be gathered in two
> > read(2) operations, or would it be conforming that data sent through
two
> > calls of this service will be gathered in a single read(2)
operation?
>=20
> One read() per rt_pipe_write() operation, always.

Thank you for your answer. Is "One readv() per rt_pipe_write()
operation" supposed to be true also, or is there something special to be
taken into consideration regarding readv(2)?

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

