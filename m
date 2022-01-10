Message-ID: <ad902f48-d071-a8ad-4ce9-2e9046d1d775@siemens.com>
Date: Mon, 10 Jan 2022 08:49:18 +0100
MIME-Version: 1.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/smokey: Handle built-in modules properly
Content-Language: en-US
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
To: Xenomai <xenomai@xenomai.org>
Cc: Dario Binacchi <dariobin@libero.it>

From: Jan Kiszka <jan.kiszka@siemens.com>

Check again after loading a module if it was actually added. If not but
modprobe returned no error, the module is built-in and must not be
removed on exit - which only fails.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/smokey/helpers.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index 9fc4236ff1..0fc450ff65 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -293,35 +293,48 @@ int smokey_fork_exec(const char *path, const char *arg)
 
 }
 
-#define SMOKEY_MOD_NUM       32
-static char *smokey_modules[SMOKEY_MOD_NUM];
-
-int smokey_modprobe(const char *name, bool silent)
+static bool module_loaded(const char *name)
 {
+	bool result = false;
 	char buffer[128];
-	int err, len, i, midx = -1;
+	int len;
 	FILE *fp;
 
-	if (!name)
-		return -EINVAL;
-
 	fp = fopen("/proc/modules", "r");
 	if (fp == NULL)
-		return -errno;
+		return false;
 
 	len = strlen(name);
 
 	while (fgets(buffer, sizeof(buffer), fp)) {
 		if (strncmp(buffer, name, len) == 0 &&
 		    len < sizeof(buffer) && buffer[len] == ' ') {
-			smokey_trace("%s module already loaded", name);
-			fclose(fp);
-			return 0;
+			result = true;
+			break;
 		}
 	}
 
 	fclose(fp);
 
+	return result;
+}
+
+#define SMOKEY_MOD_NUM       32
+static char *smokey_modules[SMOKEY_MOD_NUM];
+
+int smokey_modprobe(const char *name, bool silent)
+{
+	char buffer[128];
+	int err, i, midx = -1;
+
+	if (!name)
+		return -EINVAL;
+
+	if (module_loaded(name)) {
+		smokey_trace("%s module already loaded", name);
+		return 0;
+	}
+
 	for (i = 0; i < SMOKEY_MOD_NUM; i++) {
 		if (!smokey_modules[i]) {
 			midx = i;
@@ -350,7 +363,9 @@ int smokey_modprobe(const char *name, bool silent)
 		return -EINVAL;
 	}
 
-	smokey_modules[midx] = strdup(name);
+	if (!err && module_loaded(name))
+		smokey_modules[midx] = strdup(name);
+
 	return err;
 }
 
-- 
2.31.1

