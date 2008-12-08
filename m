Message-ID: <493D3E4F.2040206@domain.hid>
Date: Mon, 08 Dec 2008 16:33:35 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <6fca2a340812080606y1ae8def3vb81b9093476d6104@domain.hid>
In-Reply-To: <6fca2a340812080606y1ae8def3vb81b9093476d6104@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] SMP support for two ppc405 cores?
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
To: =?ISO-8859-1?Q?sa=E2dia_dhouib?= <dhouib@domain.hid>
Cc: xenomai@xenomai.org

sa=E2dia dhouib wrote:
> Hi,
> I work on an xilinx development board (xupv2p) which has two ppc405 cores.
> I want to know if xenomai can schedule tasks on the two cores ?

Xenomai depends on Linux to support SMP first.

Since there is no cache coherency on this board, supporting SMP (sort of,
sub-optimal form) is a braindamage albeit possible task, but I doubt the Xi=
linx
kernel tree provides it already. Does it?

So the answer is likely no, Xenomai won't support your board in full dual c=
ore
mode, since Xenomai assumes cache coherency is available in SMP mode.

Now, you could port Xenomai to your board without Linux underneath, but you
would still be hit by the cache coherency issue.

> And is there some document that explains how is SMP implemented in Xenoma=
i.

Well, ... No.

> Thanks a lot
>=20
>=20
> ------------------------------------------------------------------------
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.

