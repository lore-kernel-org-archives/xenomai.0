From: Dario Binacchi <dariobin@libero.it>
Subject: [PATCH v4 1/8] lib/smokey: add smokey_{modprobe,rmmod} helpers
Date: Sun, 12 Dec 2021 12:56:04 +0100
Message-Id: <20211212115611.3036-2-dariobin@libero.it>
In-Reply-To: <20211212115611.3036-1-dariobin@libero.it>
References: <20211212115611.3036-1-dariobin@libero.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Wolfgang Grandegger <wg@grandegger.com>, Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Dario Binacchi <dariobin@libero.it>, Gianluca Falavigna <gianluca.falavigna@inwind.it>

Both functions, implemented and used for the net, are general purpose
and therefore can be useful in other parts of the application with the
application of minimal changes.

Signed-off-by: Dario Binacchi <dariobin@libero.it>

---

Changes in v4:
- Add the patch to the series.

 include/smokey/smokey.h             |  6 +-
 lib/smokey/helpers.c                | 99 +++++++++++++++++++++++++++++
 testsuite/smokey/net_common/setup.c | 68 +-------------------
 3 files changed, 106 insertions(+), 67 deletions(-)

diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
index 185fd3a8b..0ac1e8df4 100644
--- a/include/smokey/smokey.h
+++ b/include/smokey/smokey.h
@@ -254,7 +254,11 @@ int smokey_barrier_timedwait(struct smokey_barrier *b,
 void smokey_barrier_release(struct smokey_barrier *b);
 
 int smokey_fork_exec(const char *path, const char *arg);
-	
+
+int smokey_modprobe(const char *name, bool silent);
+
+int smokey_rmmod(const char *name);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index da84c863c..dc0bb5d0c 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -292,3 +292,102 @@ int smokey_fork_exec(const char *path, const char *arg)
 	return 1;
 
 }
+
+#define SMOKEY_MOD_NUM       32
+static char *smokey_modules[SMOKEY_MOD_NUM];
+
+int smokey_modprobe(const char *name, bool silent)
+{
+	char buffer[128];
+	int err, len, i, midx = -1;
+	FILE *fp;
+
+	fp = fopen("/proc/modules", "r");
+	if (fp == NULL)
+		return -errno;
+
+	len = strlen(name);
+
+	while (fgets(buffer, sizeof(buffer), fp)) {
+		if (strncmp(buffer, name, len) == 0 &&
+		    len < sizeof(buffer) && buffer[len] == ' ') {
+			smokey_trace("%s module already loaded", name);
+			fclose(fp);
+			return 0;
+		}
+	}
+
+	fclose(fp);
+
+	for (i = 0; i < SMOKEY_MOD_NUM; i++) {
+		if (!smokey_modules[i]) {
+			midx = i;
+			break;
+		}
+	}
+
+	if (midx < 0)
+		return -EFAULT;
+
+	smokey_trace("%s module not there: modprobing", name);
+
+	err = smokey_check_errno(
+		snprintf(buffer, sizeof(buffer), "modprobe %s %s", name,
+			 silent ? "2>/dev/null" : ""));
+	if (err < 0)
+		return err;
+
+	err = smokey_check_errno(system(buffer));
+	if (err < 0)
+		return err;
+
+	if (!WIFEXITED(err) || WEXITSTATUS(err) != 0) {
+		if (!silent)
+			smokey_warning("%s: abnormal exit", buffer);
+		return -EINVAL;
+	}
+
+	smokey_modules[midx] = strdup(name);
+	return 0;
+}
+
+int smokey_rmmod(const char *name)
+{
+	char buffer[128];
+	int i, midx = -1, err;
+
+	if (!name)
+		return -EINVAL;
+
+	for (i = 0; i < SMOKEY_MOD_NUM; i++) {
+		if (smokey_modules[i] && !strcmp(smokey_modules[i], name)) {
+			midx = i;
+			break;
+		}
+	}
+
+	if (midx < 0) {
+		smokey_trace("%s module was there on entry, keeping it", name);
+		return 0;
+	}
+
+	smokey_trace("unloading %s module", name);
+
+	err = smokey_check_errno(
+		snprintf(buffer, sizeof(buffer), "rmmod %s", name));
+	if (err < 0)
+		return err;
+
+	err = smokey_check_errno(system(buffer));
+	if (err < 0)
+		return err;
+
+	if (!WIFEXITED(err) || WEXITSTATUS(err) != 0) {
+		smokey_warning("%s: abnormal exit", buffer);
+		return -EINVAL;
+	}
+
+	free(smokey_modules[midx]);
+
+	return err;
+}
diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
index 44a0cb24b..f97c14823 100644
--- a/testsuite/smokey/net_common/setup.c
+++ b/testsuite/smokey/net_common/setup.c
@@ -28,7 +28,6 @@
 struct module {
 	int option;
 	const char *name;
-	bool loaded;
 };
 
 #define TIMEOUT 10
@@ -141,81 +140,18 @@ static int do_down(const char *intf)
 static int smokey_net_modprobe(int modid, bool silent)
 {
 	struct module *m = modules + modid;
-	char buffer[128];
-	int err, len;
-	FILE *fp;
 
 	if (modid < 0)
 		return -EINVAL;
 
-	fp = fopen("/proc/modules", "r");
-	if (fp == NULL)
-		return -errno;
-
-	len = strlen(m->name);
-
-	while (fgets(buffer, sizeof(buffer), fp)) {
-		if (strncmp(buffer, m->name, len) == 0 &&
-		    len < sizeof(buffer) && buffer[len] == ' ') {
-			smokey_trace("%s module already loaded", m->name);
-			fclose(fp);
-			return 0;
-		}
-	}
-
-	fclose(fp);
-
-	smokey_trace("%s module not there: modprobing", m->name);
-
-	err = smokey_check_errno(
-		snprintf(buffer, sizeof(buffer), "modprobe %s %s", m->name,
-			 silent ? "2>/dev/null" : ""));
-	if (err < 0)
-		return err;
-
-	err = smokey_check_errno(system(buffer));
-	if (err < 0)
-		return err;
-
-	if (!WIFEXITED(err) || WEXITSTATUS(err) != 0) {
-		if (!silent)
-			smokey_warning("%s: abnormal exit", buffer);
-		return -EINVAL;
-	}
-
-	m->loaded = true;
-
-	return err;
+	return smokey_modprobe(m->name, silent);
 }
 
 static int smokey_net_rmmod(int modid)
 {
 	struct module *m = modules + modid;
-	char buffer[128];
-	int err;
-
-	if (!m->loaded) {
-		smokey_trace("%s module was there on entry, keeping it", m->name);
-		return 0;
-	}
 
-	smokey_trace("unloading %s module", m->name);
-
-	err = smokey_check_errno(
-		snprintf(buffer, sizeof(buffer), "rmmod %s", m->name));
-	if (err < 0)
-		return err;
-
-	err = smokey_check_errno(system(buffer));
-	if (err < 0)
-		return err;
-
-	if (!WIFEXITED(err) || WEXITSTATUS(err) != 0) {
-		smokey_warning("%s: abnormal exit", buffer);
-		return -EINVAL;
-	}
-
-	return err;
+	return smokey_rmmod(m->name);
 }
 
 static int smokey_net_setup_rtcfg_client(const char *intf, int net_config)
-- 
2.17.1


