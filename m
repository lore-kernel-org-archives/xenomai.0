From: Norbert Lange <nolange79@gmail.com>
Date: Mon, 23 Apr 2018 16:24:19 +0200
Message-Id: <20180423142420.5429-2-norbert.lange@andritz.com>
In-Reply-To: <20180423142420.5429-1-norbert.lange@andritz.com>
References: <20180423142420.5429-1-norbert.lange@andritz.com>
Subject: [Xenomai] [PATCH 2/3] add xenomai_init_fetchargv function to xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

this routine was previously linked into every
xenomai-application.

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 include/xenomai/init.h  |  3 ++
 lib/boilerplate/setup.c | 62 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/xenomai/init.h b/include/xenomai/init.h
index 1cffa6f17..2a241aa3b 100644
--- a/include/xenomai/init.h
+++ b/include/xenomai/init.h
@@ -31,6 +31,9 @@ void xenomai_init_dso(int *argcp, char *const **argvp);
 
 int xenomai_bootstrap_getargv(int *argc, char *const** argv);
 
+int xenomai_init_fetchargv(int *argcp, char *const **argvp);
+#define _XENOMAI_INIT_HASFETCHARGV
+
 int xenomai_main(int argc, char *const argv[]);
 
 void xenomai_usage(void);
diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 7c83dc9fe..6cd035134 100644
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
@@ -708,3 +709,64 @@ __cold_section const char *get_program_name(void)
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
+		fd = __STD(open("/proc/self/cmdline", O_RDONLY));
+		if (fd < 0)
+			return -1;
+
+		arglist = __STD(malloc(len));
+		if (arglist == NULL) {
+			__STD(close(fd));
+			return -1;
+		}
+
+		ret = __STD(read(fd, arglist, len));
+		__STD(close(fd));
+
+		if (ret < 0) {
+			__STD(free(arglist));
+			return -1;
+		}
+
+		if (ret < len)
+			break;
+
+		__STD(free(arglist));
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
+	v = __STD(malloc((n + 1) * sizeof(char *)));
+	if (v == NULL) {
+		__STD(free(arglist));
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
2.17.0


