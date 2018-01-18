From: Dmitriy Cherkasov <dmitriy@oss-tech.org>
Date: Thu, 18 Jan 2018 01:33:20 +0000
Message-Id: <1516239201-24251-3-git-send-email-dmitriy@oss-tech.org>
In-Reply-To: <1516239201-24251-1-git-send-email-dmitriy@oss-tech.org>
References: <1516239201-24251-1-git-send-email-dmitriy@oss-tech.org>
Subject: [Xenomai] [PATCH 2/3] cobalt/kernel: remove usage of GFP_TEMPORARY
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Linux does away with GFP_TEMPORARY starting with 4.14 (see 0ee931c4e31a5).
Update cobalt to use GFP_KERNEL instead.

Signed-off-by: Dmitriy Cherkasov <dmitriy@oss-tech.org>
---
 kernel/cobalt/debug.c         | 2 +-
 kernel/cobalt/posix/process.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index 0f9e5e434..ddfecf813 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -229,7 +229,7 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
 	 * offsets.
 	 */
 
-	tmp = (char *)__get_free_page(GFP_TEMPORARY);
+	tmp = (char *)__get_free_page(GFP_KERNEL);
 	if (tmp == NULL)
 		/*
 		 * The situation looks really bad, but we can't do
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 769fa7559..7c4674124 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -236,7 +236,7 @@ static inline char *get_exe_path(struct task_struct *p)
 	 * which is a heavyweight operation anyway, let's pick the
 	 * memory from the page allocator.
 	 */
-	buf = (char *)__get_free_page(GFP_TEMPORARY);
+	buf = (char *)__get_free_page(GFP_KERNEL);
 	if (buf == NULL)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.14.3


