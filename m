From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] copperplate: Handle errors properly in get_session_label
Message-ID: <9112bf0c-edb0-b162-100d-c425353f02b3@siemens.com>
Date: Thu, 17 Oct 2019 20:01:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

From: Jan Kiszka <jan.kiszka@siemens.com>

strdup may fail. And if we fail otherwise later, session will leak.
The second issue was reported by clang-9 scan-build.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This and the other one were the only issues worth addressing - or even 
valid at all. Even without issues with the API and sycall ABI, scan-
build tends to have quite a few false positives.

 lib/copperplate/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/copperplate/init.c b/lib/copperplate/init.c
index 4ea5e1ade8..5bfccf6062 100644
--- a/lib/copperplate/init.c
+++ b/lib/copperplate/init.c
@@ -155,6 +155,8 @@ static int get_session_label(const char *optarg)
 	int ret;
 
 	session = strdup(optarg);
+	if (!session)
+		return -ENOMEM;
 	grpname = strrchr(session, '/');
 	if (grpname == NULL)
 		goto no_group;
@@ -163,8 +165,10 @@ static int get_session_label(const char *optarg)
 
 	if (isdigit(*grpname)) {
 		gid = (gid_t)strtol(grpname, &p, 10);
-		if (*p)
+		if (*p) {
+			free(session);
 			return -EINVAL;
+		}
 		errno = 0;
 		grp = getgrgid(gid);
 	} else {
@@ -175,6 +179,7 @@ static int get_session_label(const char *optarg)
 	if (grp == NULL) {
 		ret = errno ? -errno : -EINVAL;
 		warning("invalid group %s", grpname);
+		free(session);
 		return ret;
 	}
 
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

