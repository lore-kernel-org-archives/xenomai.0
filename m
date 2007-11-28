Message-ID: <474D3A87.8070706@domain.hid>
Date: Wed, 28 Nov 2007 10:53:11 +0100
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2AE3BEFE@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AE3BEFE@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Compatibility of Xenomai-Versions
Reply-To: philippe.gerum@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik.Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik.Wildenburg@domain.hid wrote:
> Thank you for your explanations!
>=20
> Sorry for the following stupid questions but till now I wasn=B4t aware of=
 the ABI revisions.
> How do I, as a simple user of xenomai, recognize when the ABI changed ?
>

Check the shared library versions.

> Is the following true ?
>=20
> Xenomai Version : a.b.c
>=20
> a changed : change of the API =3D> rework your source code
> b changed : change of the ABI =3D> recompile your application=20
>             and libraries, replace your Xenomai libraries
> c changed : no change in application,libraries necessary
>=20

No. Some early a.(b+1).c releases may still run executables compiled for
a.b.c, it really depends on the ABI changes, and we try to avoid them
when possible. The rule of thumb is that no ABI change will ever be made
in a stable branch, such as 2.3.x, so you may expect that any userland
application compiled for 2.3.0 would run over 2.3.5 unmodified. However,
we don't provide any guarantee of such kind to kernel space code. This
is why Xenomai strictly decorrelates userland and kernel supports, i.e.
to provide a stable ABI across releases from any given stable version to
userland programs.

--=20
Philippe.

