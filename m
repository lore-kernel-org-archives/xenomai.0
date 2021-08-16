Subject: Re: [PATCH v2,2/2] Add --disable-{demo,testsuite} options
References: <20210813150432.3215777-1-fontaine.fabrice@gmail.com>
 <20210813150432.3215777-2-fontaine.fabrice@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9dddf4cd-0540-7b3a-d4d4-6afa7a6c1bad@siemens.com>
Date: Mon, 16 Aug 2021 11:29:17 +0200
MIME-Version: 1.0
In-Reply-To: <20210813150432.3215777-2-fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>, xenomai@xenomai.org

On 13.08.21 17:04, Fabrice Fontaine via Xenomai wrote:
> Allow the user to disable demo and testsuite to decrease compilation
> time and save disk space.
> 
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
>  Makefile.am  | 12 ++++++++++--
>  configure.ac | 12 ++++++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 891e53f66..604644277 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -6,9 +6,17 @@ SUBDIRS = 		\
>  	config		\
>  	include		\
>  	scripts		\
> -	testsuite	\
> -	utils		\
> +	utils
> +
> +if XENO_ENABLE_DEMO
> +SUBDIRS += 		\
>  	demo
> +endif
> +
> +if XENO_ENABLE_TESTSUITE
> +SUBDIRS += 		\
> +	testsuite
> +endif
>  
>  EXTRA_DIST = kernel debian
>  
> diff --git a/configure.ac b/configure.ac
> index bd5fd5ba9..29dfd16e5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -200,6 +200,18 @@ test \! x$debug_mode = x && AC_DEFINE(CONFIG_XENO_DEBUG,1,[config])
>  AM_CONDITIONAL(XENO_DEBUG_FULL,[test x$debug_mode = xfull])
>  test x$debug_mode = xfull && AC_DEFINE(CONFIG_XENO_DEBUG_FULL,1,[config])
>  
> +dnl Demo (default: on)
> +
> +AC_ARG_ENABLE(demo,
> +	AS_HELP_STRING([--disable-demo], [Disable demo]))
> +AM_CONDITIONAL(XENO_ENABLE_DEMO,[test x$enable_demo != xno])
> +
> +dnl Testsuite (default: on)
> +
> +AC_ARG_ENABLE(testsuite,
> +	AS_HELP_STRING([--disable-testsuite], [Disable testsuite]))
> +AM_CONDITIONAL(XENO_ENABLE_TESTSUITE,[test x$enable_testsuite != xno])
> +
>  dnl Low resolution clock (default: off)
>  
>  unset lores_clock
> 

Thanks, applied this one, with minor tuning of --disable-demo help.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

