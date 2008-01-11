Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Jan 2008 10:10:51 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AF3270B@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <2ff1a98a0801100605l1639190eve13def369901f28b@domain.hid>
From: <Roderik.Wildenburg@domain.hid>
Subject: Re: [Xenomai-help] Shared Memory mmap fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

Perfect !
Thank you very much for the super rapid response and solution.

Yours respectfully
Roderik


> -----Urspr=FCngliche Nachricht-----
> Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
> Gesendet: Donnerstag, 10. Januar 2008 15:05
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Shared Memory mmap fails
>=20
>  Jan 10, 2008 9:54 AM,  <Roderik.Wildenburg@domain.hid> wrote:
> > Dear Xenomai Pros,
> >
> > executing the attached code snippet(a very much striped=20
> down satch.c example) results in the following error message.
> >
> > # ./satch
> > mmap(producer_shm): 6
> >
> > This means : "ENXIO, the range [off;off+len) is invalid for=20
> the shared memory region specified by fd;"
> >
> > This problem does not only occur in this small example but=20
> also in my application.
> > Therefore and as I can=B4t see any obvious  mistake in this=20
> example, I think this could be a problem of Xenomai.
> > Could somedbody try to execute this example and validate if=20
> there is a general problem ?
> > I use Xenomai 2.3.5 on a 2.4.25 PPC-kernel.
> >
> > Thank you very much in advance
> > Roderik
>=20
> Could you try the attached patch ?
>=20
> --=20
>                                                Gilles Chanteperdrix
>=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

