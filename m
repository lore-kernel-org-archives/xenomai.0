MIME-Version: 1.0
In-Reply-To: <49A4209F.60502@domain.hid>
References: <a0e7fce50902240018g6be57617g2c5f14c55685ef24@domain.hid>
	<49A4209F.60502@domain.hid>
Date: Wed, 25 Feb 2009 12:22:27 +0800
Message-ID: <a0e7fce50902242022y2c6304c9lca98e6d981aa4251@domain.hid>
From: yi li <liyi.dev@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] blackfin: build xenomai in FLAT format
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-core@domain.hid

On Wed, Feb 25, 2009 at 12:30 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>
>> 2. =A0libpthread_rt.la should not depend on "lpthread".
>>
>
> Nak. In flat mode, turning the link dependencies order upside down will n=
ot buy
> us anything. Two-phase link is the only way to prevent circular/invalid
> dependencies with a static only format when symbol wrapping is involved.
>

Agree. But "libpthread_rt_la_LDFLAGS" should not include "-lpthread",
otherwise libtool will think libpthread_rt.a depends on libpthread.
I don't think there is such a dependency, isn't it?

-Yi

--- xenomai-2.4.x-clean/src/skins/posix/Makefile.in     2008-06-02
05:32:28.000000000 +0800
+++ xenomai-2.4.x/src/skins/posix/Makefile.in   2009-02-23
17:12:14.000000000 +0800
@@ -239,7 +239,7 @@ target_vendor =3D @target_vendor@
 top_builddir =3D @top_builddir@
 top_srcdir =3D @top_srcdir@
 lib_LTLIBRARIES =3D libpthread_rt.la
-libpthread_rt_la_LDFLAGS =3D -version-info 1:0:0 -lpthread
+libpthread_rt_la_LDFLAGS =3D -version-info 1:0:0
 libpthread_rt_la_SOURCES =3D \
        init.c \
        thread.c \

