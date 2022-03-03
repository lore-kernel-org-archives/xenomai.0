Message-ID: <6e6af75b-dc2e-ca94-3fba-d5c3785edf7e@siemens.com>
Date: Thu, 3 Mar 2022 07:25:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] Add --with-kernelshark option
Content-Language: en-US
References: <20220302025721.9354-1-hongzhan.chen@intel.com>
 <20220302025721.9354-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220302025721.9354-2-hongzhan.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 02.03.22 03:57, Hongzhan Chen wrote:
> option to build kernelshark plugin
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  Makefile.am         |  4 ++++
>  configure.ac        | 16 ++++++++++++++++
>  tracing/Makefile.am |  3 ++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 604644277..bd3e4bfb1 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -18,6 +18,9 @@ SUBDIRS += 		\
>  	testsuite
>  endif
>  
> +SUBDIRS +=		\
> +	tracing
> +
>  EXTRA_DIST = kernel debian
>  
>  DIST_SUBDIRS =		\
> @@ -26,6 +29,7 @@ DIST_SUBDIRS =		\
>  	doc		\
>  	include		\
>  	lib 		\
> +	tracing		\
>  	scripts		\
>  	testsuite	\
>  	utils
> diff --git a/configure.ac b/configure.ac
> index 16cffd8f8..b8e9ca143 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -826,6 +826,20 @@ AC_ARG_WITH(demodir,
>      ], [XENO_DEMO_DIR=$demodir])
>  AC_MSG_RESULT($XENO_DEMO_DIR)
>  
> +xeno_build_kernelshark=false
> +AC_MSG_CHECKING(build kernelshark plugins)
> +AC_ARG_WITH(kernelshark,
> +    AS_HELP_STRING([--with-kernelshark],[build kernelshark related plugins]),
> +    [
> +	case "$withval" in
> +	"" | y | ye | yes) xeno_build_kernelshark=true;;
> +	n | no) xeno_build_kernelshark=false;;
> +	esac
> +    ], [xeno_build_kernelshark=false])
> +AC_MSG_RESULT($xeno_build_kernelshark)
> +
> +AM_CONDITIONAL([BUILD_KERNELSHARK], [test x$xeno_build_kernelshark = xtrue])
> +
>  AC_MSG_CHECKING([for test source generation])
>  AC_RUN_IFELSE([AC_LANG_PROGRAM([[ ]], [[ ]])],
>      [AC_MSG_RESULT(ok)], [AC_MSG_RESULT(failed)], [AC_MSG_RESULT(untestable)])
> @@ -943,6 +957,8 @@ AC_CONFIG_FILES([ \
>  	scripts/Makefile \
>  	scripts/xeno-config:scripts/xeno-config-$rtcore_type.in \
>  	scripts/xeno \
> +	tracing/Makefile \
> +	tracing/kernelshark/Makefile \
>  	lib/Makefile \
>  	lib/boilerplate/Makefile \
>  	lib/boilerplate/init/Makefile \
> diff --git a/tracing/Makefile.am b/tracing/Makefile.am
> index 8bdf1f906..7925ae9c6 100644
> --- a/tracing/Makefile.am
> +++ b/tracing/Makefile.am
> @@ -1,6 +1,7 @@
> -
> +if BUILD_KERNELSHARK
>  SUBDIRS =		\
>  	kernelshark
> +endif
>  
>  DIST_SUBDIRS = 		\
>  	kernelshark

Seems you lost the AC_PROG_CXX - things do not build now.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

