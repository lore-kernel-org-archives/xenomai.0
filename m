From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 24 Apr 2018 14:37:44 +0200
Message-Id: <20180424123745.7015-3-henning.schild@siemens.com>
In-Reply-To: <20180424123745.7015-1-henning.schild@siemens.com>
References: <20180424123745.7015-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 2/3] smokey/dlopen: fix testcase
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

The intention of another binary and fork/exec was to have a binary is
not a xenoami-binary already, to actually test dlopen.
Unfortunately a copy-paste mistake in Makefile.am resulted in dlopentest
being a xenomai application already. Therefore the dlopens tested
something they where not supposed to.

Change Makefile.am to make dlopentest a truly non-xenomai binary. And
change what it is testing accordingly. We do not support dlclose so do
not test it anymore.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 testsuite/smokey/dlopen/Makefile.am       | 8 +-------
 testsuite/smokey/dlopen/dlopentest.c      | 9 ---------
 testsuite/smokey/dlopen/libalchemy-test.c | 2 +-
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/testsuite/smokey/dlopen/Makefile.am b/testsuite/smokey/dlopen/Makefile.am
index 70390e589..db5a521d8 100644
--- a/testsuite/smokey/dlopen/Makefile.am
+++ b/testsuite/smokey/dlopen/Makefile.am
@@ -42,16 +42,10 @@ test_PROGRAMS = dlopentest
 dlopentest_SOURCES = dlopentest.c
 
 dlopentest_CPPFLAGS =				\
-	@XENO_USER_CFLAGS@			\
 	-Wno-format-security			\
-	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'	\
-	-I$(top_srcdir)/include
-
-dlopentest_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@ $(XENO_POSIX_WRAPPERS)
+	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'
 
 dlopentest_LDADD =		\
-	@XENO_CORE_LDADD@	\
-	@XENO_USER_LDADD@	\
 	-ldl
 
 noinst_LIBRARIES = libdlopen.a
diff --git a/testsuite/smokey/dlopen/dlopentest.c b/testsuite/smokey/dlopen/dlopentest.c
index 43f00e2c2..cbf9b74d8 100644
--- a/testsuite/smokey/dlopen/dlopentest.c
+++ b/testsuite/smokey/dlopen/dlopentest.c
@@ -75,14 +75,5 @@ int main(int argc, char *const argv[])
 	if (ret)
 		error(1, errno, "libposix_func: %s", strerror(-ret));
 
-	if (dlclose(handlep))
-		fprintf(stderr, "%s", dlerror());
-	if (dlclose(handlea))
-		fprintf(stderr, "%s", dlerror());
-
-	setenv("XENO_TEST_DLOPEN_NO_INIT", "1", 1);
-	ret = my_dlcall("libalchemy-test.so", "libalchemy_func", &handlea);
-	assert(ret == ENOMEM);
-
 	return 0;
 }
diff --git a/testsuite/smokey/dlopen/libalchemy-test.c b/testsuite/smokey/dlopen/libalchemy-test.c
index 4784e2b1d..3e1eb23ea 100644
--- a/testsuite/smokey/dlopen/libalchemy-test.c
+++ b/testsuite/smokey/dlopen/libalchemy-test.c
@@ -33,7 +33,7 @@ static size_t def_mem_pool_size = SIZE_MAX;
 
 static int alchemy_tune(void)
 {
-	if (getenv("XENO_TEST_DLOPEN_NO_INIT") || ran_init)
+	if (ran_init)
 		return 0;
 	def_mem_pool_size = get_config_tunable(mem_pool_size);
 	set_config_tunable(mem_pool_size, 2*def_mem_pool_size);
-- 
2.16.1


