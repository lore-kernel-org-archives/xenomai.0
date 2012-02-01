Message-ID: <4F2957A0.6040806@domain.hid>
Date: Wed, 01 Feb 2012 16:17:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F294E43.7060102@domain.hid>
In-Reply-To: <4F294E43.7060102@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Built-in libxenomai dependency
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On 02/01/2012 03:37 PM, Jan Kiszka wrote:
> Hi,
> 
> don't remember anymore: Is there any subtle reason that prevent a
> change like
> 
> diff --git a/src/skins/native/Makefile.am b/src/skins/native/Makefile.am
> index 39eaaed..4cc8859 100644
> --- a/src/skins/native/Makefile.am
> +++ b/src/skins/native/Makefile.am
> @@ -22,6 +22,9 @@ libnative_la_SOURCES = \
>  	wrappers.c \
>  	wrappers.h
>  
> +libnative_la_LIBADD = \
> +	../common/libxenomai.la
> +
>  libnative_la_CPPFLAGS = \
>  	@XENO_USER_CFLAGS@ \
>  	-I$(top_srcdir)/include
> diff --git a/src/skins/rtdm/Makefile.am b/src/skins/rtdm/Makefile.am
> index 8ad74be..2dc0a90 100644
> --- a/src/skins/rtdm/Makefile.am
> +++ b/src/skins/rtdm/Makefile.am
> @@ -8,6 +8,9 @@ librtdm_la_SOURCES = \
>  	core.c \
>  	init.c
>  
> +librtdm_la_LIBADD = \
> +	../common/libxenomai.la
> +
>  librtdm_la_CPPFLAGS = \
>  	@XENO_USER_CFLAGS@ \
>  	-I$(top_srcdir)/include
> diff --git a/src/testsuite/latency/Makefile.am b/src/testsuite/latency/Makefile.am
> index c772c26..6534df5 100644
> --- a/src/testsuite/latency/Makefile.am
> +++ b/src/testsuite/latency/Makefile.am
> @@ -14,5 +14,4 @@ latency_LDFLAGS = @XENO_USER_LDFLAGS@
>  latency_LDADD = \
>  	../../skins/native/libnative.la \
>  	../../skins/rtdm/librtdm.la \
> -	../../skins/common/libxenomai.la \
>  	-lpthread -lm
> 
> i.e. that we let the skin libraries depend on libxenomai and then remove
> the explicit dependency from our binaries and the xeno-config output?
> Is there some ordering issue again (we have -l<skin> before -lxenomai
> in the ldflags).
> 
> If possible, this would allow for things like dlopen("libnative.so").

It allows xeno-config result to work both with dynamic and static
libraries. Static libraries have no dependency system, so, when linking
a program whith libnative.a for instance, without libtool, you still
have to link it with libxenomai.a.

How come you can not dlopen libnative.so, dlopening libxenomai.so before
does not work?

-- 
					    Gilles.

