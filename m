Message-ID: <e48eda27-9d11-7caf-48d3-d40b473619fa@siemens.com>
Date: Mon, 7 Mar 2022 12:03:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] libtraceevent: Add xenomai_schedparams plugin for
 libtraceevent
Content-Language: en-US
References: <20220304052140.17196-1-hongzhan.chen@intel.com>
 <20220304052140.17196-3-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220304052140.17196-3-hongzhan.chen@intel.com>
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

On 04.03.22 06:21, Hongzhan Chen wrote:
> For cobalt thread, there is special struct param_ex data stored in
> data record, we need to parse and print its content out correctly
>  to hint user.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  configure.ac                                  |  18 ++
>  tracing/Makefile.am                           |  15 +-
>  tracing/libtraceevent/Makefile.am             |   9 +
>  tracing/libtraceevent/README                  |  30 ++++
>  .../plugin_xenomai_schedparams.c              | 158 ++++++++++++++++++
>  5 files changed, 229 insertions(+), 1 deletion(-)
>  create mode 100644 tracing/libtraceevent/Makefile.am
>  create mode 100644 tracing/libtraceevent/README
>  create mode 100644 tracing/libtraceevent/plugin_xenomai_schedparams.c
> 
> diff --git a/configure.ac b/configure.ac
> index d282009e0..0b19e495b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -846,6 +846,23 @@ AC_MSG_RESULT($xeno_build_kernelshark)
>  
>  AM_CONDITIONAL([BUILD_KERNELSHARK], [test x$xeno_build_kernelshark = xtrue])
>  
> +xeno_build_libtraceevent=false
> +AC_MSG_CHECKING(build libtraceevent plugin)
> +AC_ARG_WITH(libtraceeventdir,
> +    AS_HELP_STRING([--with-libtraceeventdir],[Prefix location of header file for building libtraceevent plugin. For example: /usr/local/include/]),
> +    [
> +	case "$withval" in
> +	"" | y | ye | yes | n | no)
> +	    AC_MSG_ERROR([You must supply an argument to --with-libtraceeventdir])
> +	  ;;
> +	esac
> +	TRACEEVENR_INCLUDS="${withval}/traceevent"
> +	xeno_build_libtraceevent=true
> +    ], [xeno_build_libtraceevent=false])
> +AC_MSG_RESULT($xeno_build_libtraceevent)
> +
> +AM_CONDITIONAL([BUILD_LIBTRACEEVENT], [test x$xeno_build_libtraceevent = xtrue])
> +
>  AC_MSG_CHECKING([for test source generation])
>  AC_RUN_IFELSE([AC_LANG_PROGRAM([[ ]], [[ ]])],
>      [AC_MSG_RESULT(ok)], [AC_MSG_RESULT(failed)], [AC_MSG_RESULT(untestable)])
> @@ -970,6 +987,7 @@ AC_CONFIG_FILES([ \
>  	scripts/xeno \
>  	tracing/Makefile \
>  	tracing/kernelshark/Makefile \
> +	tracing/libtraceevent/Makefile \
>  	lib/Makefile \
>  	lib/boilerplate/Makefile \
>  	lib/boilerplate/init/Makefile \
> diff --git a/tracing/Makefile.am b/tracing/Makefile.am
> index 25c3e033c..8f3d20adf 100644
> --- a/tracing/Makefile.am
> +++ b/tracing/Makefile.am
> @@ -1,6 +1,19 @@
>  if BUILD_KERNELSHARK
>  SUBDIRS = kernelshark
> +
> +if BUILD_LIBTRACEEVENT
> +SUBDIRS +=	 \
> +	libtraceevent
> +endif
> +
> +else
> +
> +if BUILD_LIBTRACEEVENT
> +SUBDIRS = libtraceevent
> +endif
> +
>  endif
>  
>  DIST_SUBDIRS = 		\
> -	kernelshark
> +	kernelshark	\
> +	libtraceevent
> diff --git a/tracing/libtraceevent/Makefile.am b/tracing/libtraceevent/Makefile.am
> new file mode 100644
> index 000000000..d8bf05412
> --- /dev/null
> +++ b/tracing/libtraceevent/Makefile.am
> @@ -0,0 +1,9 @@
> +
> +lib_LTLIBRARIES = libplugin_xenomai_schedparams.la
> +
> +libplugin_xenomai_schedparams_la_SOURCES =	\
> +	plugin_xenomai_schedparams.c
> +
> +libplugin_xenomai_schedparams_la_CPPFLAGS =	\
> +	-I$(TRACEEVENR_INCLUDS)			\
> +	-I$(top_srcdir)/include
> diff --git a/tracing/libtraceevent/README b/tracing/libtraceevent/README
> new file mode 100644
> index 000000000..c15088b02
> --- /dev/null
> +++ b/tracing/libtraceevent/README
> @@ -0,0 +1,30 @@
> +
> +What is it?
> +=============
> +
> +  It is Xenomai plugin on libtracevent to parse struct param_ex
> +  out correctly for trace log.
> +
> +How to compile?
> +================================
> +
> +Preparation:
> +
> +  - GIT clone:
> +
> +      https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git
> +
> +  - build and install libtraceevent:
> +
> +      make;
> +      sudo make install
> +
> +How to use built lib?
> +===============================
> +
> +  Please copy built libplugin_xenomai_schedparams.so to
> +  /usr/local/lib/traceevent/plugins/ or
> +  /usr/local/lib64/traceevent/plugins/ depending on your system.
> +  While libtracevent and its plugins is installed correctly, the plugins
> +  would be loaded automatically by other module such as libtracecmd after
> +  corresponding tracing tool run such as kernelshark or tracecmd.

I should use the changes below to switch to pkg-config - that permits
control over the installation path as well.

In addition, Xenomai should install the plugins properly, into the same 
folders as kernelshark and libtraceevent use.

Jan

diff --git a/configure.ac b/configure.ac
index 0b19e495b2..e005f16873 100644
--- a/configure.ac
+++ b/configure.ac
@@ -826,42 +826,46 @@ AC_ARG_WITH(demodir,
     ], [XENO_DEMO_DIR=$demodir])
 AC_MSG_RESULT($XENO_DEMO_DIR)
 
-xeno_build_kernelshark=false
-AC_MSG_CHECKING(build kernelshark plugins)
-AC_ARG_WITH(kernelsharkdir,
-	    AS_HELP_STRING([--with-kernelsharkdir=<prefix-include-dir>],[Prefix location of header file for building kernelshark related plugins. For example: /usr/local/include/]),
-    [
-	case "$withval" in
-	"" | y | ye | yes | n | no)
-	    AC_MSG_ERROR([You must supply an argument to --with-kernelsharkdir])
-	  ;;
-	esac
-	KS_INCLUDS="${withval}/kernelshark"
-	TRACECMD_INCLUDS="${withval}/trace-cmd"
-	TRACEFS_INCLUDS="${withval}/tracefs"
-	TRACEEVENR_INCLUDS="${withval}/traceevent"
-	xeno_build_kernelshark=true
-    ], [xeno_build_kernelshark=false])
-AC_MSG_RESULT($xeno_build_kernelshark)
-
-AM_CONDITIONAL([BUILD_KERNELSHARK], [test x$xeno_build_kernelshark = xtrue])
-
-xeno_build_libtraceevent=false
-AC_MSG_CHECKING(build libtraceevent plugin)
-AC_ARG_WITH(libtraceeventdir,
-    AS_HELP_STRING([--with-libtraceeventdir],[Prefix location of header file for building libtraceevent plugin. For example: /usr/local/include/]),
-    [
-	case "$withval" in
-	"" | y | ye | yes | n | no)
-	    AC_MSG_ERROR([You must supply an argument to --with-libtraceeventdir])
-	  ;;
-	esac
-	TRACEEVENR_INCLUDS="${withval}/traceevent"
-	xeno_build_libtraceevent=true
-    ], [xeno_build_libtraceevent=false])
-AC_MSG_RESULT($xeno_build_libtraceevent)
+kernelshark_plugin=
+AC_MSG_CHECKING(whether KernelShark plugin should be built)
+AC_ARG_ENABLE(kernelshark_plugin,
+	AS_HELP_STRING([--enable-kernelshark-plugin], [build KernelShark plugin]),
+	[case "$enableval" in
+	y | yes) kernelshark_plugin=y ;;
+	/*) kernelshark_plugin=y ;;
+	*) unset kernelshark_plugin ;;
+	esac])
+AC_MSG_RESULT(${kernelshark_plugin:-no})
+AM_CONDITIONAL(XENO_KSHARK_PLUGIN, [test x$kernelshark_plugin = xy])
+
+libtraceevent_plugin=
+AC_MSG_CHECKING(whether libtraceevent plugin should be built)
+AC_ARG_ENABLE(libtraceevent_plugin,
+	AS_HELP_STRING([--enable-libtraceevent-plugin], [build libtraceevent plugin]),
+	[case "$enableval" in
+	y | yes) libtraceevent_plugin=y ;;
+	/*) libtraceevent_plugin=y ;;
+	*) unset libtraceevent_plugin ;;
+	esac])
+AC_MSG_RESULT(${libtraceevent_plugin:-no})
+AM_CONDITIONAL(XENO_LIBTRACEEVENT_PLUGIN, [test x$libtraceevent_plugin = xy])
 
-AM_CONDITIONAL([BUILD_LIBTRACEEVENT], [test x$xeno_build_libtraceevent = xtrue])
+if test x$kernelshark_plugin = xy -o x$libtraceevent_plugin = xy; then
+	PKG_CHECK_MODULES(LIBTRACEEVENT, libtraceevent)
+fi
+
+if test x$kernelshark_plugin = xy; then
+	PKG_CHECK_MODULES(LIBKSHARK, libkshark)
+	PKG_CHECK_MODULES(LIBTRACECMD, libtracecmd)
+	PKG_CHECK_MODULES(LIBTRACEFS, libtracefs)
+	XENO_KSHARK_PLUGIN_CFLAGS="$LIBKSHARK_CFLAGS $LIBTRACEEVENT_CFLAGS $LIBTRACECMD_CFLAGS $LIBTRACEFS_CFLAGS"
+	XENO_KSHARK_PLUGIN_LDFLAGS="$LIBKSHARK_LIBS $LIBTRACEEVENT_LDFLAGS $LIBTRACECMD_LDFLAGS $LIBTRACEFS_LDFLAGS"
+fi
+
+if test x$libtraceevent_plugin = xy; then
+	XENO_LIBTRACEEVENT_PLUGIN_CFLAGS="$LIBTRACEEVENT_CFLAGS"
+	XENO_LIBTRACEEVENT_PLUGIN_LDFLAGS="$LIBTRACEEVENT_LDFLAGS"
+fi
 
 AC_MSG_CHECKING([for test source generation])
 AC_RUN_IFELSE([AC_LANG_PROGRAM([[ ]], [[ ]])],
@@ -968,6 +972,10 @@ AC_SUBST(XENO_USER_LDADD)
 AC_SUBST(XENO_USER_APP_CFLAGS)
 AC_SUBST(XENO_USER_APP_LDFLAGS)
 AC_SUBST(XENO_FUSE_CFLAGS)
+AC_SUBST(XENO_KSHARK_PLUGIN_CFLAGS)
+AC_SUBST(XENO_KSHARK_PLUGIN_LDFLAGS)
+AC_SUBST(XENO_LIBTRACEEVENT_PLUGIN_CFLAGS)
+AC_SUBST(XENO_LIBTRACEEVENT_PLUGIN_LDFLAGS)
 AC_SUBST(XENO_TEST_DIR)
 AC_SUBST(XENO_DEMO_DIR)
 AC_SUBST(XENO_BUILD_COMPILER)
diff --git a/tracing/Makefile.am b/tracing/Makefile.am
index 8f3d20adfc..da7d979f9a 100644
--- a/tracing/Makefile.am
+++ b/tracing/Makefile.am
@@ -1,17 +1,11 @@
-if BUILD_KERNELSHARK
-SUBDIRS = kernelshark
+SUBDIRS =
 
-if BUILD_LIBTRACEEVENT
-SUBDIRS +=	 \
-	libtraceevent
-endif
-
-else
-
-if BUILD_LIBTRACEEVENT
-SUBDIRS = libtraceevent
+if XENO_KSHARK_PLUGIN
+SUBDIRS += kernelshark
 endif
 
+if XENO_LIBTRACEEVENT_PLUGIN
+SUBDIRS += libtraceevent
 endif
 
 DIST_SUBDIRS = 		\
diff --git a/tracing/kernelshark/Makefile.am b/tracing/kernelshark/Makefile.am
index c8fa7ae8f4..a8337c2704 100644
--- a/tracing/kernelshark/Makefile.am
+++ b/tracing/kernelshark/Makefile.am
@@ -1,13 +1,12 @@
-
 lib_LTLIBRARIES = libplugin_xenomai_cobalt_switch_events.la
 
 libplugin_xenomai_cobalt_switch_events_la_SOURCES =	\
-	CobaltSwitchEvents.cpp			\
-	xenomai_cobalt_switch_events.c		\
+	CobaltSwitchEvents.cpp				\
+	xenomai_cobalt_switch_events.c			\
 	xenomai_cobalt_switch_events.h
 
 libplugin_xenomai_cobalt_switch_events_la_CPPFLAGS =	\
-	-I$(KS_INCLUDS)					\
-	-I$(TRACECMD_INCLUDS)				\
-	-I$(TRACEFS_INCLUDS)				\
-	-I$(TRACEEVENR_INCLUDS)
+	@XENO_KSHARK_PLUGIN_CFLAGS@
+
+libplugin_xenomai_cobalt_switch_events_la_LDFLAGS =	\
+	@XENO_KSHARK_PLUGIN_LDFLAGS@
diff --git a/tracing/libtraceevent/Makefile.am b/tracing/libtraceevent/Makefile.am
index d8bf05412c..b40f40c1d8 100644
--- a/tracing/libtraceevent/Makefile.am
+++ b/tracing/libtraceevent/Makefile.am
@@ -1,9 +1,11 @@
-
 lib_LTLIBRARIES = libplugin_xenomai_schedparams.la
 
 libplugin_xenomai_schedparams_la_SOURCES =	\
 	plugin_xenomai_schedparams.c
 
 libplugin_xenomai_schedparams_la_CPPFLAGS =	\
-	-I$(TRACEEVENR_INCLUDS)			\
+	@XENO_LIBTRACEEVENT_PLUGIN_CFLAGS@	\
 	-I$(top_srcdir)/include
+
+libplugin_xenomai_schedparams_la_LDFLAGS =	\
+	@XENO_LIBTRACEEVENT_PLUGIN_LDFLAGS@

-- 
Siemens AG, Technology
Competence Center Embedded Linux

