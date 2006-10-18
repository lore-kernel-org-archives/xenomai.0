Subject: Re: [Xenomai-core] [PATCH] cleanup xeno-config output
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <452A43CC.5010908@domain.hid>
References: <452A4169.9050901@domain.hid>  <452A43CC.5010908@domain.hid>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 10:11:55 +0200
Message-Id: <1161159115.5184.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2006-10-09 at 14:42 +0200, Jan Kiszka wrote:
> Jan Kiszka wrote:
> > Following the discussion in an earlier thread, this patch reduces the
> > CFLAGS and LDFLAGS returned by xeno-config to the required minimum.
> > 
> > Compile tested with several external packages, no regression known
> > (except that one may want to set some of those flags elsewhere now).
> > 
> 
> As usual, while you are hitting "Send": "Hmm did I check... No, I didn't!"
> 
> So here comes -v2, now setting -D__XENO__ also internally again.
> 

Applied, thanks.

> Jan
> plain text document attachment (xeno-config-cleanup-v2.patch)
> ---
>  ChangeLog              |    8 +++++++-
>  configure.in           |   15 +++++++--------
>  scripts/xeno-config.in |    4 ++--
>  3 files changed, 16 insertions(+), 11 deletions(-)
> 
> Index: configure.in
> ===================================================================
> --- configure.in.orig
> +++ configure.in
> @@ -497,21 +497,23 @@ else
>  fi
>  AC_MSG_RESULT([done])
>  
> -XENO_USER_CFLAGS="-D_GNU_SOURCE -D_REENTRANT -D__XENO__"
> +dnl Common CFLAGS and LDFLAGS
> +XENO_USER_CFLAGS="-D_GNU_SOURCE -D_REENTRANT"
>  XENO_USER_LDFLAGS=
>  
> +dnl Exported CFLAGS and LDFLAGS, may be enhanced per-arch below
> +XENO_USER_APP_CFLAGS=$XENO_USER_CFLAGS
> +XENO_USER_APP_LDFLAGS=$XENO_USER_LDFLAGS
> +
>  case $XENO_TARGET_ARCH in
>   i386)
>  	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe -fstrict-aliasing $gcc_w_noalias"
> -	XENO_USER_LDFLAGS="-rdynamic"
>          ;;
>   powerpc)
>  	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe"
> -	XENO_USER_LDFLAGS="-rdynamic"
>          ;;
>   ia64)
>  	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe"
> -	XENO_USER_LDFLAGS="-rdynamic"
>          ;;
>   blackfin)
>  	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe"
> @@ -521,7 +523,6 @@ case $XENO_TARGET_ARCH in
>          ;;
>   arm)
>  	XENO_USER_CFLAGS="$XENO_USER_CFLAGS -Wall -pipe"
> -	XENO_USER_LDFLAGS="-rdynamic"
>          ;;
>  esac
>  
> @@ -531,9 +532,7 @@ else
>     XENO_USER_CFLAGS="-O2 $XENO_USER_CFLAGS"
>  fi
>  
> -XENO_USER_APP_CFLAGS=$XENO_USER_CFLAGS
> -XENO_USER_CFLAGS="$XENO_USER_CFLAGS -D__IN_XENO__ -Wstrict-prototypes"
> -XENO_USER_APP_LDFLAGS=$XENO_USER_LDFLAGS
> +XENO_USER_CFLAGS="$XENO_USER_CFLAGS -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes"
>  
>  AC_MSG_CHECKING([whether ld supports @file])
>  AC_CACHE_VAL(ac_cv_ld_file_option,
> Index: scripts/xeno-config.in
> ===================================================================
> --- scripts/xeno-config.in.orig
> +++ scripts/xeno-config.in
> @@ -12,9 +12,9 @@ XENO_VERSION="@PACKAGE_VERSION@"
>  XENO_PREFIX="${staging}${prefix}"
>  XENO_CC="@CC@"
>  XENO_TARGET_ARCH="@XENO_TARGET_ARCH@"
> -XENO_BASE_CFLAGS="-I. -I${staging}${includedir} @XENO_USER_APP_CFLAGS@"
> +XENO_BASE_CFLAGS="-I${staging}${includedir} @XENO_USER_APP_CFLAGS@"
>  XENO_BASE_LDFLAGS="-L${staging}${libdir} -lpthread @XENO_USER_APP_LDFLAGS@"
> -XENO_POSIX_CFLAGS="-I. -I${staging}${includedir} -I${staging}${includedir}/posix @XENO_USER_APP_CFLAGS@"
> +XENO_POSIX_CFLAGS="-I${staging}${includedir} -I${staging}${includedir}/posix @XENO_USER_APP_CFLAGS@ -D__XENO__"
>  XENO_POSIX_LDFLAGS="-L${staging}${libdir} -lpthread_rt -lpthread -lrt @XENO_USER_APP_LDFLAGS@"
>  XENO_POSIX_WRAPPERS="${staging}${libdir}/posix.wrappers"
>  XENO_POSIX_FAST_WRAPPING="@LD_FILE_OPTION@"
> Index: ChangeLog
> ===================================================================
> --- ChangeLog.orig
> +++ ChangeLog
> @@ -1,3 +1,9 @@
> +2006-10-09  Jan Kiszka  <jan.kiszka@domain.hid>
> +
> +	* configure.in, scripts/xeno-config.in: Reducing CFLAGS and LDFLAGS
> +	return by xeno-config to the required minimum while keeping the
> +	original flags internally.
> +
>  2006-10-08  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
>  
>  	* src/testsuite/*/Makefile.am: Link with libtool libraries, in
> @@ -9,7 +15,7 @@
>  	* include/rtdm/rtdm_driver.h (rtdm_*copy_to/from_user): Fix
>  	return code.
>  
> -	* ksrc/skins/rtdm/drvlib.c (rtdm_strncpy_from_user): Adopt doc to
> +	* ksrc/skins/rtdm/drvlib.c (rtdm_strncpy_from_user): Adapt doc to
>  	actual success return code, the string length.
>  
>  2006-10-08  Wolfgang Grandegger  <wg@domain.hid>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



