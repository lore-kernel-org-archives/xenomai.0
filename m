From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 24/25] lib/cobalt: add default wrapper to clock_settime()
Date: Thu, 20 May 2021 23:44:34 +0200
Message-Id: <db58a22eb536aaf31599b8d7248033eb286ef01e.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
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

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/wrappers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 860b260201..18c237734f 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -524,6 +524,12 @@ int __real_clock_gettime(clockid_t clk_id, struct timespec *tp)
 	return clock_gettime(clk_id, tp);
 }
 
+__weak
+int __real_clock_settime(clockid_t clk_id, const struct timespec *tp)
+{
+	return clock_settime(clk_id, tp);
+}
+
 __weak
 int __real_sigwait(const sigset_t *set, int *sig)
 {
-- 
2.26.2


