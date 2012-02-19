Message-ID: <4F41144E.1020004@domain.hid>
Date: Sun, 19 Feb 2012 16:25:02 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4F3146AA.5070902@domain.hid>
In-Reply-To: <4F3146AA.5070902@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH forge] Fix build for relative invocations
 of	configure
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

On 02/07/2012 04:43 PM, Jan Kiszka wrote:
> This fixes build setups like '../configure'.
>

Merged, thanks.

> Signed-off-by: Jan Kiszka<jan.kiszka@domain.hid>
> ---
>   configure.in |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/configure.in b/configure.in
> index c0a7d17..0bdced8 100644
> --- a/configure.in
> +++ b/configure.in
> @@ -547,7 +547,7 @@ LD_FILE_OPTION=$ac_cv_ld_file_option
>   AC_SUBST(LD_FILE_OPTION)
>
>   if test x$rtcore_type = xcobalt; then
> -   XENO_USER_CFLAGS="-I$srcdir/include/cobalt $XENO_USER_CFLAGS"
> +   XENO_USER_CFLAGS="-I`cd $srcdir&&  pwd`/include/cobalt $XENO_USER_CFLAGS"
>      if [[ $ac_cv_ld_file_option = yes ]]; then
>   	XENO_POSIX_WRAPPERS="-Wl,@`cd $srcdir&&  pwd`/lib/cobalt/posix.wrappers"
>      else


-- 
Philippe.

