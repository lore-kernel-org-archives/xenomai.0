From: Henning Schild <henning.schild@siemens.com>
Date: Fri, 16 Feb 2018 14:13:34 +0100
Message-Id: <50189b79cf4e7416a270b804b6e5218435d50195.1518786423.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518786423.git.henning.schild@siemens.com>
References: <cover.1518786423.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518786423.git.henning.schild@siemens.com>
References: <cover.1518786423.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 4/5] smokey/dlopen: introduce a new testcase
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This commit introduces a new testcase into the smokey framework. The
test covers some aspects of adding xenomai-functionality to applications
with dlopen(). It also tests initialization and tunables.
This test also shows a bug in xenomai, so the test will actually fail.
The next commit will fix that again.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 configure.ac                              |  2 +
 testsuite/smokey/Makefile.am              |  4 ++
 testsuite/smokey/dlopen/Makefile.am       | 63 ++++++++++++++++++++++
 testsuite/smokey/dlopen/dlopen.c          | 44 ++++++++++++++++
 testsuite/smokey/dlopen/dlopentest.c      | 88 +++++++++++++++++++++++++++++++
 testsuite/smokey/dlopen/libalchemy-test.c | 65 +++++++++++++++++++++++
 testsuite/smokey/dlopen/libposix-test.c   | 32 +++++++++++
 7 files changed, 298 insertions(+)
 create mode 100644 testsuite/smokey/dlopen/Makefile.am
 create mode 100644 testsuite/smokey/dlopen/dlopen.c
 create mode 100644 testsuite/smokey/dlopen/dlopentest.c
 create mode 100644 testsuite/smokey/dlopen/libalchemy-test.c
 create mode 100644 testsuite/smokey/dlopen/libposix-test.c

diff --git a/configure.ac b/configure.ac
index bb239a9f2..330c7664f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -717,6 +717,7 @@ else
 	AC_DEFINE_UNQUOTED(CONFIG_XENO_TLS_MODEL,"initial-exec",[TLS model])
 	XENO_LIB_LDFLAGS="-Wl,-z -Wl,nodlopen"
 fi
+AM_CONDITIONAL(CONFIG_XENO_LIBS_DLOPEN,[test x$CONFIG_XENO_LIBS_DLOPEN = xy])
 
 AC_MSG_CHECKING(whether to enable TLS support)
 AC_ARG_ENABLE([tls],
@@ -911,6 +912,7 @@ AC_CONFIG_FILES([ \
 	testsuite/spitest/Makefile \
 	testsuite/smokey/Makefile \
 	testsuite/smokey/arith/Makefile \
+	testsuite/smokey/dlopen/Makefile \
 	testsuite/smokey/sched-quota/Makefile \
 	testsuite/smokey/sched-tp/Makefile \
 	testsuite/smokey/setsched/Makefile \
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index ae60a441a..c6fe70bb5 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -31,6 +31,10 @@ COBALT_SUBDIRS = 	\
 	vdso-access 	\
 	xddp
 
+if CONFIG_XENO_LIBS_DLOPEN
+COBALT_SUBDIRS += dlopen
+endif
+
 MERCURY_SUBDIRS =
 
 DIST_SUBDIRS = $(COBALT_SUBDIRS) $(MERCURY_SUBDIRS)
diff --git a/testsuite/smokey/dlopen/Makefile.am b/testsuite/smokey/dlopen/Makefile.am
new file mode 100644
index 000000000..b8c3ab34a
--- /dev/null
+++ b/testsuite/smokey/dlopen/Makefile.am
@@ -0,0 +1,63 @@
+testdir = @XENO_TEST_DIR@
+
+test_LTLIBRARIES = libalchemy-test.la libposix-test.la
+
+libalchemy_test_la_LDFLAGS =	\
+	$(XENO_POSIX_WRAPPERS)	\
+	@XENO_LIB_LDFLAGS@	\
+	-version-info 0:0:0
+
+libalchemy_test_la_LIBADD =					\
+	@XENO_CORE_LDADD@					\
+	@XENO_USER_LDADD@					\
+	../../../lib/boilerplate/init/libbootstrap-pic.la	\
+	../../../lib/alchemy/libalchemy.la			\
+	../../../lib/copperplate/libcopperplate.la
+
+libalchemy_test_la_SOURCES = libalchemy-test.c
+
+libalchemy_test_la_CPPFLAGS =	\
+	@XENO_USER_CFLAGS@	\
+	-I$(top_srcdir)/include
+
+libposix_test_la_LDFLAGS =	\
+	$(XENO_POSIX_WRAPPERS)	\
+	@XENO_LIB_LDFLAGS@	\
+	-version-info 0:0:0
+
+libposix_test_la_LIBADD =					\
+	@XENO_CORE_LDADD@					\
+	@XENO_USER_LDADD@					\
+	../../../lib/boilerplate/init/libbootstrap-pic.la	\
+	../../../lib/copperplate/libcopperplate.la
+
+libposix_test_la_SOURCES = libposix-test.c
+
+libposix_test_la_CPPFLAGS =	\
+	@XENO_USER_CFLAGS@	\
+	-I$(top_srcdir)/include
+
+test_PROGRAMS = dlopentest
+
+dlopentest_SOURCES = dlopentest.c
+
+dlopentest_CPPFLAGS =				\
+	@XENO_USER_CFLAGS@			\
+	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'	\
+	-I$(top_srcdir)/include
+
+dlopentest_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
+
+dlopentest_LDADD =		\
+	@XENO_CORE_LDADD@	\
+	@XENO_USER_LDADD@	\
+	-ldl
+
+noinst_LIBRARIES = libdlopen.a
+
+libdlopen_a_SOURCES = dlopen.c
+
+libdlopen_a_CPPFLAGS =				\
+	@XENO_USER_CFLAGS@			\
+	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'	\
+	-I$(top_srcdir)
diff --git a/testsuite/smokey/dlopen/dlopen.c b/testsuite/smokey/dlopen/dlopen.c
new file mode 100644
index 000000000..282dbbe20
--- /dev/null
+++ b/testsuite/smokey/dlopen/dlopen.c
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) Siemens AG, 2018
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining
+ * a copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include <error.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <smokey/smokey.h>
+
+smokey_test_plugin(dlopen,
+		   SMOKEY_NOARGS,
+		   "Check dlopen()/dlclose() functionality."
+);
+
+static int run_dlopen(struct smokey_test *t,
+			  int argc, char *const argv[])
+{
+	/*
+	 * exec the actual program, which should be a xenomai-free
+	 * application that gains xenomai functionality with dlopen()
+	 */
+	return smokey_fork_exec(XENO_TEST_DIR "/dlopentest", "");
+}
diff --git a/testsuite/smokey/dlopen/dlopentest.c b/testsuite/smokey/dlopen/dlopentest.c
new file mode 100644
index 000000000..43f00e2c2
--- /dev/null
+++ b/testsuite/smokey/dlopen/dlopentest.c
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) Siemens AG, 2018
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining
+ * a copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include <assert.h>
+#include <errno.h>
+#include <dlfcn.h>
+#include <error.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <limits.h>
+
+static void *my_dlopen(char *name)
+{
+	void *handle;
+	char buf[PATH_MAX];
+	int flags = RTLD_LAZY|RTLD_GLOBAL;
+
+	handle = dlopen(name, flags);
+	if (!handle) {
+		// no matter what the error was (errno not set) try it again
+		// with absolute path, the first one is there to enable
+		// LD_LIBRARY_PATH
+		snprintf(buf, PATH_MAX, "%s/%s", XENO_TEST_DIR, name);
+		handle = dlopen(buf, flags);
+		if (!handle)
+			error(1, errno, dlerror());
+	}
+	return handle;
+}
+
+static int my_dlcall(char *lname, char *fname, void **handle)
+{
+	int (*func)(void);
+	char *errstr;
+
+	*handle = my_dlopen(lname);
+	func = dlsym(*handle, fname);
+	errstr = dlerror();
+	if (errstr)
+		error(1, errno, "%s", errstr);
+
+	return func();
+}
+
+int main(int argc, char *const argv[])
+{
+	void *handlea, *handlep;
+	int ret;
+
+	ret = my_dlcall("libalchemy-test.so", "libalchemy_func", &handlea);
+	if (ret)
+		error(1, errno, "libalchemy_func: %s", strerror(-ret));
+
+	ret = my_dlcall("libposix-test.so", "libposix_func", &handlep);
+	if (ret)
+		error(1, errno, "libposix_func: %s", strerror(-ret));
+
+	if (dlclose(handlep))
+		fprintf(stderr, "%s", dlerror());
+	if (dlclose(handlea))
+		fprintf(stderr, "%s", dlerror());
+
+	setenv("XENO_TEST_DLOPEN_NO_INIT", "1", 1);
+	ret = my_dlcall("libalchemy-test.so", "libalchemy_func", &handlea);
+	assert(ret == ENOMEM);
+
+	return 0;
+}
diff --git a/testsuite/smokey/dlopen/libalchemy-test.c b/testsuite/smokey/dlopen/libalchemy-test.c
new file mode 100644
index 000000000..4784e2b1d
--- /dev/null
+++ b/testsuite/smokey/dlopen/libalchemy-test.c
@@ -0,0 +1,65 @@
+/*
+ * Copyright (C) Siemens AG, 2018
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining
+ * a copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include <alchemy/queue.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <xenomai/init.h>
+#include <xenomai/tunables.h>
+
+static int ran_init = 0;
+static size_t def_mem_pool_size = SIZE_MAX;
+
+static int alchemy_tune(void)
+{
+	if (getenv("XENO_TEST_DLOPEN_NO_INIT") || ran_init)
+		return 0;
+	def_mem_pool_size = get_config_tunable(mem_pool_size);
+	set_config_tunable(mem_pool_size, 2*def_mem_pool_size);
+	ran_init = 1;
+	return 0;
+}
+
+static struct setup_descriptor alchemy_setup = {
+	.name = "setup-name",
+	.tune = alchemy_tune,
+};
+
+user_setup_call(alchemy_setup);
+
+int libalchemy_func(void);
+
+int libalchemy_func(void)
+{
+	RT_QUEUE queue;
+	int ret;
+
+	ret = rt_queue_create(&queue, "q0", def_mem_pool_size,
+			      Q_UNLIMITED, Q_FIFO);
+	if (ret)
+		return ret;
+	ret = rt_queue_delete(&queue);
+
+	return ret;
+}
diff --git a/testsuite/smokey/dlopen/libposix-test.c b/testsuite/smokey/dlopen/libposix-test.c
new file mode 100644
index 000000000..fda01a533
--- /dev/null
+++ b/testsuite/smokey/dlopen/libposix-test.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) Siemens AG, 2018
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining
+ * a copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sublicense, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *  
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+ * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+ * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
+ * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
+ * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include <time.h>
+#include <stdio.h>
+
+int libposix_func(void);
+
+int libposix_func(void)
+{
+	struct timespec now;
+	return clock_gettime(CLOCK_REALTIME, &now);
+}
-- 
2.16.1


