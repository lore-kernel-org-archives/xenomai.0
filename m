Message-ID: <4DBA9AFB.4030401@domain.hid>
Date: Fri, 29 Apr 2011 13:03:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=T7CtZUhLzbU2bz4Z8Ph=N=_Bs=g@domain.hid>
In-Reply-To: <BANLkTi=T7CtZUhLzbU2bz4Z8Ph=N=_Bs=g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: martin mangard <martin@domain.hid>
Cc: xenomai@xenomai.org

martin mangard wrote:
> Hello,
> 
> I installed xenomai Version 2.5.6 on a x86 machine. I use dlopen in
> order to use the xenomai libraries.
> 
> 
>     hXenomai=dlopen("/usr/lib/libxenocalls-2.5.6.so",RTLD_NOW);
>     if(!hXenomai)
> 	{
>         fprintf (stderr, "%s\n", dlerror());
>         fflush(stderr);
> 	}
> 
> 
> dlopen aborts with the error: "/usr/lib/libnative.so.3: undefined
> symbol: xeno_current_mode_key"
> 
> I configured xenomai with the option " --enable-dlopen-skins "
> 
> What do I have to change in order be able to dlopen the libnative.so.3 library?

xeno_current_mod_key is defined in the libxenomai.so library. So, we
have two solutions:

either we make explicit the dependence between libnative.so and
libxenomai.so, as in the following patch:

index 3497f90..23beb50 100644
--- a/src/skins/native/Makefile.am
+++ b/src/skins/native/Makefile.am
@@ -2,6 +2,8 @@ lib_LTLIBRARIES = libnative.la
 
 libnative_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 3:0:0 -lpthread
 
+libnative_la_LIBADD = ../common/libxenomai.la
+
 libnative_la_SOURCES = \
 	alarm.c \
 	buffer.c \
diff --git a/src/skins/native/Makefile.in b/src/skins/native/Makefile.in
index 2775661..011f380 100644
--- a/src/skins/native/Makefile.in
+++ b/src/skins/native/Makefile.in
@@ -58,7 +58,7 @@ am__strip_dir = `echo $$p | sed -e 's|^.*/||'`;
 am__installdirs = "$(DESTDIR)$(libdir)"
 libLTLIBRARIES_INSTALL = $(INSTALL)
 LTLIBRARIES = $(lib_LTLIBRARIES)
-libnative_la_LIBADD =
+libnative_la_DEPENDENCIES = ../common/libxenomai.la
 am_libnative_la_OBJECTS = libnative_la-alarm.lo libnative_la-buffer.lo \
 	libnative_la-cond.lo libnative_la-event.lo \
 	libnative_la-heap.lo libnative_la-init.lo libnative_la-intr.lo \
@@ -249,6 +249,7 @@ top_builddir = @top_builddir@
 top_srcdir = @top_srcdir@
 lib_LTLIBRARIES = libnative.la
 libnative_la_LDFLAGS = @XENO_DLOPEN_CONSTRAINT@ -version-info 3:0:0 -lpthread
+libnative_la_LIBADD = ../common/libxenomai.la
 libnative_la_SOURCES = \
 	alarm.c \
 	buffer.c \

I am not sure it will not break the parallel build though it does not
seem to break on a core i7 (make -j 8).

Or you explicitly dlopen libxenomai.so with RTLD_GLOBAL before dlopening
libnative.so. The drawback being that you pollute the process namespace
with libxenomai symbols.

-- 
                                                                Gilles.

