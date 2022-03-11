Message-ID: <9b2a3fdc-ac85-bad8-e45f-e6d082c7222c@siemens.com>
Date: Fri, 11 Mar 2022 14:30:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] build: add options to build plugins of kernelshark
 and libtraceevent
Content-Language: en-US
References: <20220310081513.12314-1-hongzhan.chen@intel.com>
 <20220310081513.12314-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220310081513.12314-2-hongzhan.chen@intel.com>
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org, florian.bezdeka@siemens.com

On 10.03.22 09:15, Hongzhan Chen wrote:
> To build plugins of kernelshark and libtraceevent, add options and
> do necessary configuration.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> 
> diff --git a/configure.ac b/configure.ac
> index afe08b8f2..16c8788a9 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -91,6 +91,8 @@ AC_ARG_WITH(cxx,
>      ])
>  AC_PROG_CXX
>  
> +PKG_PROG_PKG_CONFIG
> +
>  # Do not let autoconf set the default value of CFLAGS
>  if $XENO_EMPTY_CFLAGS; then
>  	CFLAGS=""
> @@ -831,6 +833,40 @@ AC_ARG_WITH(demodir,
>      ], [XENO_DEMO_DIR=$demodir])
>  AC_MSG_RESULT($XENO_DEMO_DIR)
>  
> +kernelshark_plugin=
> +AC_MSG_CHECKING(whether KernelShark plugin should be built)
> +AC_ARG_ENABLE(kernelshark_plugin,
> +	AS_HELP_STRING([--enable-kernelshark-plugin], [build KernelShark plugin]),
> +	[case "$enableval" in
> +	y | yes) kernelshark_plugin=y ;;
> +	/*) kernelshark_plugin=y ;;

These /* matches can be dropped I think. They backdate to the time of
accepting a path here. I'll remove them on merge.

> +	*) unset kernelshark_plugin ;;
> +	esac])
> +AC_MSG_RESULT(${kernelshark_plugin:-no})
> +AM_CONDITIONAL(XENO_KSHARK_PLUGIN, [test x$kernelshark_plugin = xy])
> +
> +libtraceevent_plugin=
> +AC_MSG_CHECKING(whether libtraceevent plugin should be built)
> +AC_ARG_ENABLE(libtraceevent_plugin,
> +	AS_HELP_STRING([--enable-libtraceevent-plugin], [build libtraceevent plugin]),
> +	[case "$enableval" in
> +	y | yes) libtraceevent_plugin=y ;;
> +	/*) libtraceevent_plugin=y ;;
> +	*) unset libtraceevent_plugin ;;
> +	esac])
> +AC_MSG_RESULT(${libtraceevent_plugin:-no})
> +AM_CONDITIONAL(XENO_LIBTRACEEVENT_PLUGIN, [test x$libtraceevent_plugin = xy])
> +
> +if test x$kernelshark_plugin = xy -o x$libtraceevent_plugin = xy; then
> +	PKG_CHECK_MODULES(LIBTRACEEVENT, libtraceevent)
> +	PKG_CHECK_VAR(XENO_LIBTRACEEVENT_INSTALLDIR, libtraceevent, libdir)
> +fi
> +
> +if test x$kernelshark_plugin = xy; then
> +	PKG_CHECK_MODULES(LIBKSHARK, libkshark)
> +	PKG_CHECK_VAR(XENO_KSHARK_INSTALLDIR, libkshark, libdir)
> +fi
> +
>  AC_MSG_CHECKING([for test source generation])
>  AC_RUN_IFELSE([AC_LANG_PROGRAM([[ ]], [[ ]])],
>      [AC_MSG_RESULT(ok)], [AC_MSG_RESULT(failed)], [AC_MSG_RESULT(untestable)])

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

