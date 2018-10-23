From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH 1/2] separate bootstrap code to get commandline,
 move it into library
Date: Tue, 23 Oct 2018 17:16:46 +0200
Message-Id: <20181023151647.25508-2-norbert.lange@andritz.com>
In-Reply-To: <20181023151647.25508-1-norbert.lange@andritz.com>
References: <20181023151647.25508-1-norbert.lange@andritz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

to allow fallbacks, define a macro to indicate the function exists
in the library

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 include/xenomai/init.h           |  4 +++
 lib/boilerplate/init/bootstrap.c | 48 ++++++++++++++++---------
 lib/boilerplate/setup.c          | 62 ++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 17 deletions(-)

diff --git a/include/xenomai/init.h b/include/xenomai/init.h
index 598bf5329..7ab5c60bb 100644
--- a/include/xenomai/init.h
+++ b/include/xenomai/init.h
@@ -25,6 +25,10 @@
 extern "C" {
 #endif

+#define _XENOMAI_INIT_HASFETCHARGV
+
+int xenomai_init_fetchargv(int *argcp, char *const **argvp);
+
 void xenomai_init(int *argcp, char *const **argvp);

 void xenomai_init_dso(int *argcp, char *const **argvp);
diff --git a/lib/boilerplate/init/bootstrap.c b/lib/boilerplate/init/bootstrap.c
index 64a11c2d2..8e4fc93d8 100644
--- a/lib/boilerplate/init/bootstrap.c
+++ b/lib/boilerplate/init/bootstrap.c
@@ -17,7 +17,7 @@
  *
  * The above copyright notice and this permission notice shall be included
  * in all copies or substantial portions of the Software.
- *
+ *
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
@@ -44,11 +44,6 @@
  * License along with this library; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
-#include <sys/types.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <string.h>
-#include <fcntl.h>
 #include <xenomai/init.h>

 static int early_argc;
@@ -62,7 +57,7 @@ static char *const *early_argv;
  *   should include a wrapper interposing on the main() routine for
  *   auto-init purpose. Such wrapper is activated when symbol wrapping
  *   is enabled at link time (--wrap).
- *
+ *
  * - in dynamic object form, to be included in a shared library target
  *   which enables the auto-init feature. This form should not include
  *   any wrapper to a main() routine - which does not exist - but only
@@ -94,7 +89,7 @@ int xenomai_main(int argc, char *const argv[])
 {
 	if (early_argc)
 		return __real_main(early_argc, early_argv);
-
+
 	xenomai_init(&argc, &argv);

 	return __real_main(argc, argv);
@@ -107,23 +102,30 @@ static inline void call_init(int *argcp, char *const **argvp)

 #endif /* !__BOOTSTRAP_DSO__ */

-__bootstrap_ctor static void xenomai_bootstrap(void)
+#if !defined(_XENOMAI_INIT_HASFETCHARGV)
+#include <sys/types.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+
+static int xenomai_init_fetchargv(int *argcp, char *const **argvp)
 {
-	char *arglist, *argend, *p, **v, *const *argv;
+	char *arglist, *argend, *p, **v;
 	ssize_t len, ret;
-	int fd, n, argc;
+	int fd, n;

 	len = 1024;

 	for (;;) {
 		fd = __STD(open("/proc/self/cmdline", O_RDONLY));
 		if (fd < 0)
-			return;
+			return -1;

 		arglist = __STD(malloc(len));
 		if (arglist == NULL) {
 			__STD(close(fd));
-			return;
+			return -1;
 		}

 		ret = __STD(read(fd, arglist, len));
@@ -131,7 +133,7 @@ __bootstrap_ctor static void xenomai_bootstrap(void)

 		if (ret < 0) {
 			__STD(free(arglist));
-			return;
+			return -1;
 		}

 		if (ret < len)
@@ -152,7 +154,7 @@ __bootstrap_ctor static void xenomai_bootstrap(void)
 	v = __STD(malloc((n + 1) * sizeof(char *)));
 	if (v == NULL) {
 		__STD(free(arglist));
-		return;
+		return -1;
 	}

 	p = arglist;
@@ -163,8 +165,20 @@ __bootstrap_ctor static void xenomai_bootstrap(void)
 	}

 	v[n] = NULL;
-	argv = v;
-	argc = n;
+	*argcp = n;
+	*argvp = v;
+	return 0;
+}
+#endif
+
+
+__bootstrap_ctor static void xenomai_bootstrap(void)
+{
+	char *const *argv;
+	int argc;
+
+	if (xenomai_init_fetchargv(&argc, &argv) != 0)
+		return;

 	call_init(&argc, &argv);
 	early_argc = argc;
diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 8b363efee..89a8c6841 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -23,6 +23,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <fcntl.h>
 #include <ctype.h>
 #include <memory.h>
 #include <malloc.h>
@@ -705,3 +706,64 @@ const char *get_program_name(void)
 {
 	return basename(__base_setup_data.arg0 ?: "program");
 }
+
+int xenomai_init_fetchargv(int *argcp, char *const **argvp)
+{
+	char *arglist, *argend, *p, **v;
+	ssize_t len, ret;
+	int fd, n;
+
+	len = 1024;
+
+	for (;;) {
+		fd = open("/proc/self/cmdline", O_RDONLY);
+		if (fd < 0)
+			return -1;
+
+		arglist = malloc(len);
+		if (arglist == NULL) {
+			close(fd);
+			return -1;
+		}
+
+		ret = read(fd, arglist, len);
+		close(fd);
+
+		if (ret < 0) {
+			free(arglist);
+			return -1;
+		}
+
+		if (ret < len)
+			break;
+
+		free(arglist);
+		len <<= 1;
+	}
+
+	argend = arglist + ret;
+	p = arglist;
+	n = 0;
+	while (p < argend) {
+		n++;
+		p += strlen(p) + 1;
+	}
+
+	v = malloc((n + 1) * sizeof(char *));
+	if (v == NULL) {
+		free(arglist);
+		return -1;
+	}
+
+	p = arglist;
+	n = 0;
+	while (p < argend) {
+		v[n++] = p;
+		p += strlen(p) + 1;
+	}
+
+	v[n] = NULL;
+	*argcp = n;
+	*argvp = v;
+	return 0;
+}
--
2.19.1


