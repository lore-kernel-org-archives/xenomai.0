From: Stefan Schaal <sschaal@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Oct 2009 12:10:52 -0700
Message-Id: <E65E9416-A152-4EFE-93C8-31A123514B6E@usc.edu>
Mime-Version: 1.0 (Apple Message framework v1076)
Subject: Re: [Xenomai-core] [PATCH v2] build system: Fix shared
	libs	generation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

I tried the modified configure.in from the xenomai-head.git tree, but  
still the *.so libraries are not generated. This is on a x86 running  
the xenomai-2.5.rc4 under kernel 2.6.29.5.

-Stefan



> Posted by Jan Kiszka on October 29, 2009 - 15:05:
> Philippe Gerum wrote:
>
> On Thu, 2009-10-29 at 12:33 +0100, Jan Kiszka wrote:
>
> This fixes a regression of dbbd33f50d: There must be no
> AC_DISABLE_SHARED without AS_ENABLE_SHARED for the cases where it  
> shall
> remain enabled.
>
>
> Makes sense. Will you queue this in your tree?
>
> Done, it's ready to be pulled.
>
> Jan
>
>
> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> ---
>  configure.in |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
>
> v2: properly rebased against head
>
> diff --git a/configure.in b/configure.in
> index 40683fe..9cce885 100644
> --- a/configure.in
> +++ b/configure.in
> @@ -117,7 +117,6 @@ case "$build_for" in
>          XENO_LINUX_ARCH=nios2
>      XENO_LINUX_INSTALL_TARGET=install
>      CONFIG_XENO_DEFAULT_PERIOD=10000000
> -    AC_DISABLE_SHARED
>          ;;
>   *) echo ""
>     echo "*******************************************"
> @@ -128,9 +127,18 @@ case "$build_for" in
>  esac
>
>  AC_MSG_RESULT([$XENO_TARGET_ARCH])
> -AC_PROG_LIBTOOL
>  AM_CONDITIONAL(XENO_LINUX_ARCH_I386,[test $XENO_LINUX_ARCH = i386])
>
> +case "$XENO_TARGET_ARCH" in
> + nios2)
> +    AC_DISABLE_SHARED
> +    ;;
> + *)
> +    AC_ENABLE_SHARED
> +    ;;
> +esac
> +AC_PROG_LIBTOOL
> +
>  dnl
>  dnl Parse options
>  dnl
>
>
> -- 
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>
>
>

