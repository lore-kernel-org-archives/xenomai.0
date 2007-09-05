From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46DE59D6.1040107@domain.hid>
References: <46DE59D6.1040107@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 05 Sep 2007 11:16:01 +0200
Message-Id: <1188983761.28092.278.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] pb sharing xeno heap data with std kernel module
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
To: =?ISO-8859-1?Q?St=E9phane?= ANCELOT <sancelot@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Wed, 2007-09-05 at 09:25 +0200, St=E9phane ANCELOT wrote:
> Hi,
>=20
> I have setted up a shared heap between a kernel module and an user space
> app.
>=20
> However another "std" kernel model would need a ptr to some data in it .
>=20
> rt_heap are virtual adresses I suppose.
>=20
> Is there a way to give a phys pointer to the other kernel module  ?
>=20

You should rather store offsets to data from the heap start address
instead of pointers, and compose pointers using the (base, offset) pair
when dereferencing data within this space.

> Best Regards
> Steph
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



