From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 02/11] cobalt/kernel: fix compile error for incompatible
 pointer type
Date: Mon, 26 Oct 2020 12:04:48 +0100
Message-Id: <18ab00b7b0c2c2d0ed1f560cf4fb4161f6e9bde6.1603710297.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1603710297.git.jan.kiszka@siemens.com>
References: <cover.1603710297.git.jan.kiszka@siemens.com>
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
Cc: Fino Meng <fino.meng@linux.intel.com>, Mingliang Hu <mingliang.hu@intel.com>

From: Fino Meng <fino.meng@linux.intel.com>

Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
Signed-off-by: Mingliang Hu <mingliang.hu@intel.com>
[Jan: reformat]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/stat.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/stat.h b/include/cobalt/kernel/stat.h
index b857cd19f3..d252e1429f 100644
--- a/include/cobalt/kernel/stat.h
+++ b/include/cobalt/kernel/stat.h
@@ -58,7 +58,9 @@ do { \
 #define xnstat_exectime_set_current(sched, new_account) \
 ({ \
 	xnstat_exectime_t *__prev; \
-	__prev = (xnstat_exectime_t *)atomic_long_xchg(&(sched)->current_account, (long)(new_account)); \
+	__prev = (xnstat_exectime_t *) \
+		atomic_long_xchg((atomic_long_t *)&(sched)->current_account, \
+				 (long)(new_account)); \
 	__prev; \
 })
 
-- 
2.26.2


