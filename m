From: Norbert Lange <nolange79@gmail.com>
Date: Mon, 23 Apr 2018 16:24:20 +0200
Message-Id: <20180423142420.5429-3-norbert.lange@andritz.com>
In-Reply-To: <20180423142420.5429-1-norbert.lange@andritz.com>
References: <20180423142420.5429-1-norbert.lange@andritz.com>
Subject: [Xenomai] [PATCH 3/3] provide an extended xenomai_init function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This function is a single entrypoint for both
shared libraries and executables.
Futher it allows passing flags as additional argument.

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 include/xenomai/bootstrap-template.h | 19 +++++++++++++
 include/xenomai/init.h               |  2 ++
 lib/boilerplate/setup.c              | 42 +++++++++++++++++++---------
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/include/xenomai/bootstrap-template.h b/include/xenomai/bootstrap-template.h
index d9fb0b313..29eb8e8d6 100644
--- a/include/xenomai/bootstrap-template.h
+++ b/include/xenomai/bootstrap-template.h
@@ -81,6 +81,8 @@
  *                  Set a weak reference to the defined main function
  * _XENOMAI_BOOTSTRAP_DSO
  *                  Should be defined when building shared libraries
+ * _XENOMAI_BOOTSTRAP_INITFLAGS
+ *                  Flags passed to the xenomai_init_ext function
  */
 
 #define _XENOMAI_BOOTSTRAP_GLIBC_CONSTRUCTORS
@@ -256,11 +258,28 @@ __bootstrap_ctor static void xenomai_bootstrap(void)
 		return;
 #endif
 
+
+#if !defined(_XENOMAI_BOOTSTRAP_INITFLAGS)
+	/* prefer previously existing functions for better backwards capability */
 #ifdef _XENOMAI_BOOTSTRAP_DSO
 	xenomai_init_dso(&argc, &argv);
 #else
 	xenomai_init(&argc, &argv);
 #endif
+#else
+	{
+		int isDso = 0;
+		unsigned long long bflags = 0;
+#ifdef _XENOMAI_BOOTSTRAP_DSO
+		isDso = 1;
+#endif
+#ifdef _XENOMAI_BOOTSTRAP_INITFLAGS
+		bflags = _XENOMAI_BOOTSTRAP_INITFLAGS;
+#endif
+		xenomai_init_ext(&argc, &argv, isDso, bflags);
+	}
+#endif
+
 	early_argc = argc;
 	early_argv = argv;
 }
diff --git a/include/xenomai/init.h b/include/xenomai/init.h
index 2a241aa3b..cca3d4c22 100644
--- a/include/xenomai/init.h
+++ b/include/xenomai/init.h
@@ -29,6 +29,8 @@ void xenomai_init(int *argcp, char *const **argvp);
 
 void xenomai_init_dso(int *argcp, char *const **argvp);
 
+void xenomai_init_ext(int *argcp, char *const **argvp, int isDso, unsigned long flags);
+
 int xenomai_bootstrap_getargv(int *argc, char *const** argv);
 
 int xenomai_init_fetchargv(int *argcp, char *const **argvp);
diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 6cd035134..60d37e35e 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -486,7 +486,7 @@ __setup_section static int parse_setup_options(int *argcp, char **uargv,
 	return 0;
 }
 
-__setup_section static void __xenomai_init(int *argcp, char *const **argvp, const char *me)
+static void __xenomai_init(int *argcp, char *const **argvp, const char *me, unsigned long flags)
 {
 	struct setup_descriptor *setup;
 	int ret, base_opt_start;
@@ -641,25 +641,41 @@ fail:
 	early_panic("initialization failed, %s", symerror(ret));
 }
 
-__setup_section void xenomai_init(int *argcp, char *const **argvp)
+static void _xenomai_init_ext(int *argcp, char *const **argvp, int isDso, unsigned long flags)
 {
-	const char *me = get_program_name();
+	const char *me = "DSO";
+	if (isDso)
+	{
+		__xenomai_init(argcp, argvp, me, flags);
+	} else
+	{
+		me = get_program_name();
 
-	if (main_init_done) {
-		early_warning("duplicate call from main program "
-			      "to %s() ignored", __func__);
-		early_warning("(xeno-config --no-auto-init disables implicit call)");
-	}
+		if (main_init_done) {
+			early_warning("duplicate call from main program "
+				      "to %s() ignored", __func__);
+			early_warning("(xeno-config --no-auto-init disables implicit call)");
+		}
 
-	__xenomai_init(argcp, argvp, me);
-	main_init_done = 1;
+		__xenomai_init(argcp, argvp, me, flags);
+		main_init_done = 1;
+	}
 	trace_me("%s bootstrap done", me);
 }
 
-__setup_section void xenomai_init_dso(int *argcp, char *const **argvp)
+void xenomai_init_ext(int *argcp, char *const **argvp, int isDso, unsigned long flags)
+{
+	_xenomai_init_ext(argcp, argvp, isDso, flags);
+}
+
+void xenomai_init(int *argcp, char *const **argvp)
+{
+	_xenomai_init_ext(argcp, argvp, 0, 0);
+}
+
+void xenomai_init_dso(int *argcp, char *const **argvp)
 {
-	__xenomai_init(argcp, argvp, "DSO");
-	trace_me("DSO bootstrap done");
+	_xenomai_init_ext(argcp, argvp, 1, 0);
 }
 
 void __trace_me(const char *fmt, ...)
-- 
2.17.0


