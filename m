MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18253.13096.802729.471183@domain.hid>
Date: Wed, 28 Nov 2007 10:21:44 +0100
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AE3BEFE@ARVMAIL1.mra.roland-man.biz>
References: <18252.36930.625870.462352@domain.hid>
	<5D63919D95F87E4D9D34FF7748CE2C2AE3BEFE@ARVMAIL1.mra.roland-man.biz>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: Roderik.Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik.Wildenburg@domain.hid wrote:
 > Thank you for your explanations!
 >=20
 > Sorry for the following stupid questions but till now I wasn=B4t aware o=
f the ABI revisions.
 > How do I, as a simple user of xenomai, recognize when the ABI changed ?

Well, when old user-space support no longer works with new kernel-space
support. The bind operation, done at library initialization time,
returns -ENOEXEC.

 >=20
 > Is the following true ?
 >=20
 > Xenomai Version : a.b.c
 >=20
 > a changed : change of the API =3D> rework your source code
 > b changed : change of the ABI =3D> recompile your application=20
 >             and libraries, replace your Xenomai libraries
 > c changed : no change in application,libraries necessary

No, there is no obvious relation between Xenomai versions and ABI/API
versions. Normally, Xenomai libraries versions should get incremented
when the ABI changes.

--=20


					    Gilles Chanteperdrix.

