Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 2 Apr 2008 18:08:57 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD381F9@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] glibcism in src/skins/posix/thread.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
[...]
> Already fixed in trunk, forgot to apply the patch to the v2.4.x
> branch. Note that your patch is slightly incorrect:
> - it runs strstr in an uninitialized string;
> - the result on platforms without _CS_GNU_LIBPTHREAD_VERSION is
> linuxthreads =3D=3D 0 whereas we really want linuxthreads =3D=3D 1.

Gasp, see the code zombie I am :/  I did not even tried to understand
the code, just wanted it to compile since I wasn't using this skin
for this project.

Thanks for the fix!
--=20
Stephane

