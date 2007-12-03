Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 3 Dec 2007 14:31:05 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AE66E11@domain.hid>
In-Reply-To: <474FEC18.7040304@domain.hid>
From: <Roderik.Wildenburg@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write strange behaviour ++
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> Does the attached patch trigger any message when your app fails?

Unforunatelly not (there is no message in /var/log/messages (see =
below)).
(see also my mail from 30.11. 13:27)

I still can=B4t see, were refcount can get zero when rt_queue_write is =
used.
Whatever problem occurs, refcount should stay one, as set by =
rt_queue_alloc.
Can you imagine a scenario where refcount gets 0 ? If so, please tell =
me, so I can
build a test case around it.

Many thanks for your help from a very helpless
Roderik


fer1_764_4080605:~ # tail /var/log/messages
Dec  3 15:15:11 (none) user.info kernel: Xenomai: ---- =
xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----
Dec  3 15:15:11 (none) user.info kernel: Xenomai: ---- =
xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----
Dec  3 15:15:11 (none) user.info kernel: Xenomai: ---- =
xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----
Dec  3 15:15:13 (none) user.info kernel: Xenomai: ---- =
xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----
Dec  3 15:15:16 (none) user.info kernel: Xenomai: ---- =
xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----
Dec  3 15:15:20 (none) user.info kernel: Xenomai: ---- =
xnheap_check_block failed =3D> EINVAL (err=3D0 refcount=3D0----

> -----Urspr=FCngliche Nachricht-----
> Von: Philippe Gerum [mailto:philippe.gerum@domain.hid] Im=20
> Auftrag von Philippe Gerum
> Gesendet: Freitag, 30. November 2007 11:55
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] rt_queue_write strange behaviour ++
>=20
> Roderik.Wildenburg@domain.hid wrote:
> > Sorry, but in my last mail (see below) I had forgotten to=20
> tell you my=20
> > Xenomai-Version and architecture.
> > I still use Xenomai 2.3.2 on PPC.
> >=20
> > In the meantime I had a deeper look into the Xenomai source code=20
> > and I would say, the case we observed (msg->refcount =3D=3D 0 ;=20
> see below)
> > isn=B4t possible with rt_queue_write, as this function=20
> implicitly allocate=20
> > its messagebuffer and rt_queue_alloc initilaizes refcount to 1.
> > Immediatelly after this rt_queue_send is called, where the=20
> > plausibility test if( msg->refcount =3D=3D 0) is done and fails.=20
> > So, I can=B4t see a gap where refcount falls back to 0.
>=20
> Does the attached patch trigger any message when your app fails?
>=20
> --=20
> Philippe.
>=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

