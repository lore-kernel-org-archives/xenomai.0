MIME-Version: 1.0
Sender: dothemango@domain.hid
In-Reply-To: <4DBA9AFB.4030401@domain.hid>
References: <BANLkTi=T7CtZUhLzbU2bz4Z8Ph=N=_Bs=g@domain.hid>
	<4DBA9AFB.4030401@domain.hid>
Date: Fri, 29 Apr 2011 14:30:04 +0200
Message-ID: <BANLkTi=QFUEdpCyxXM7jtD+URO3sr8V+-A@mail.gmail.com>
From: martin mangard <martin@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] dlopen of libnative fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Wow
That was fast! Thanks a lot!
The patch works for me.

On Fri, Apr 29, 2011 at 1:03 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> martin mangard wrote:
>> Hello,
>>
>> I installed xenomai Version 2.5.6 on a x86 machine. I use dlopen in
>> order to use the xenomai libraries.
>>
>>
>> =A0 =A0 hXenomai=3Ddlopen("/usr/lib/libxenocalls-2.5.6.so",RTLD_NOW);
>> =A0 =A0 if(!hXenomai)
>> =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 fprintf (stderr, "%s\n", dlerror());
>> =A0 =A0 =A0 =A0 fflush(stderr);
>> =A0 =A0 =A0 }
>>
>>
>> dlopen aborts with the error: "/usr/lib/libnative.so.3: undefined
>> symbol: xeno_current_mode_key"
>>
>> I configured xenomai with the option " --enable-dlopen-skins "
>>
>> What do I have to change in order be able to dlopen the libnative.so.3 l=
ibrary?
>
> xeno_current_mod_key is defined in the libxenomai.so library. So, we
> have two solutions:
>
> either we make explicit the dependence between libnative.so and
> libxenomai.so, as in the following patch:
>
> index 3497f90..23beb50 100644
> --- a/src/skins/native/Makefile.am
> +++ b/src/skins/native/Makefile.am
> @@ -2,6 +2,8 @@ lib_LTLIBRARIES =3D libnative.la
>
> =A0libnative_la_LDFLAGS =3D @XENO_DLOPEN_CONSTRAINT@ -version-info 3:0:0 =
-lpthread
>
> +libnative_la_LIBADD =3D ../common/libxenomai.la
> +
> =A0libnative_la_SOURCES =3D \
> =A0 =A0 =A0 =A0alarm.c \
> =A0 =A0 =A0 =A0buffer.c \
> diff --git a/src/skins/native/Makefile.in b/src/skins/native/Makefile.in
> index 2775661..011f380 100644
> --- a/src/skins/native/Makefile.in
> +++ b/src/skins/native/Makefile.in
> @@ -58,7 +58,7 @@ am__strip_dir =3D `echo $$p | sed -e 's|^.*/||'`;
> =A0am__installdirs =3D "$(DESTDIR)$(libdir)"
> =A0libLTLIBRARIES_INSTALL =3D $(INSTALL)
> =A0LTLIBRARIES =3D $(lib_LTLIBRARIES)
> -libnative_la_LIBADD =3D
> +libnative_la_DEPENDENCIES =3D ../common/libxenomai.la
> =A0am_libnative_la_OBJECTS =3D libnative_la-alarm.lo libnative_la-buffer.=
lo \
> =A0 =A0 =A0 =A0libnative_la-cond.lo libnative_la-event.lo \
> =A0 =A0 =A0 =A0libnative_la-heap.lo libnative_la-init.lo libnative_la-int=
r.lo \
> @@ -249,6 +249,7 @@ top_builddir =3D @top_builddir@
> =A0top_srcdir =3D @top_srcdir@
> =A0lib_LTLIBRARIES =3D libnative.la
> =A0libnative_la_LDFLAGS =3D @XENO_DLOPEN_CONSTRAINT@ -version-info 3:0:0 =
-lpthread
> +libnative_la_LIBADD =3D ../common/libxenomai.la
> =A0libnative_la_SOURCES =3D \
> =A0 =A0 =A0 =A0alarm.c \
> =A0 =A0 =A0 =A0buffer.c \
>
> I am not sure it will not break the parallel build though it does not
> seem to break on a core i7 (make -j 8).
>
> Or you explicitly dlopen libxenomai.so with RTLD_GLOBAL before dlopening
> libnative.so. The drawback being that you pollute the process namespace
> with libxenomai symbols.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

