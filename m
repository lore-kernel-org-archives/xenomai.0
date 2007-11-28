Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Nov 2007 09:43:43 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2AE3BEFE@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <18252.36930.625870.462352@domain.hid>
From: <Roderik.Wildenburg@domain.hid>
Subject: Re: [Xenomai-help] Compatibility of Xenomai-Versions
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

Thank you for your explanations!

Sorry for the following stupid questions but till now I wasn=B4t aware =
of the ABI revisions.
How do I, as a simple user of xenomai, recognize when the ABI changed ?

Is the following true ?

Xenomai Version : a.b.c

a changed : change of the API =3D> rework your source code
b changed : change of the ABI =3D> recompile your application=20
            and libraries, replace your Xenomai libraries
c changed : no change in application,libraries necessary


Best regards
Roderik

> -----Urspr=FCngliche Nachricht-----
> Von: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von Gilles=20
> Chanteperdrix
> Gesendet: Dienstag, 27. November 2007 22:47
> An: Wildenburg, Roderik RAEK3 MRA
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-help] Compatibility of Xenomai-Versions
>=20
> Roderik.Wildenburg@domain.hid wrote:
>  > How compatible are the different Xenomai-Versions ?=20
>  >=20
>  > - E.g. can I use a 2.3.2 application (compiled and linked=20
> against 2.3.2
>  > Libraries) on an 2.4.x kernel (kernel with a 2.4.x Xenomai) without
>  > recompiling the application ?=20
>=20
> Xenomai has a notion of ABI revision, which has been increased in
> 2.4.x. So, no, if you update Xenomai kernel-space support, you have to
> update Xenomai user-space support. The ABI revision was=20
> increased for a
> good reason: some system calls implementation changed, so running with
> mixed version would cause random errors.
>=20
> Xenomai libraries are also versioned, so you will get a=20
> loader error if
> you try to run an old application with a newer library.
>=20
>  > - Can I link a 2.4.x-application (linked and compiled against 2.4.x
>  > libraries) with an xenomai vendor libriary (e.g. some=20
> realtime functions
>  > from a vendor) build with an 2.3.x Xenomai version ?
>=20
> It depends on what is in this library. If there is a call to
> xeno_bind_skin, you will get the ABI revision error.
>=20
>  >=20
>  > In my understanding I would say yes, as long as the API=20
> and the header
>  > files did not change (type or number of parameters, constants).
>  > Is this correct ? If yes, is there an documentation where=20
> and when the
>  > API changed in an significant way ?
>=20
> Look for ksrc/skins/*/API.CHANGES. Note that only external API changes
> are documented, internal API changes are not documented though they
> caused an ABI revision increase.
>=20
> --=20
>=20
>=20
> 					    Gilles Chanteperdrix.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20

MAN Roland Druckmaschinen AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle   =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592   =20
USt-Ident-Nr. DE 250200933

