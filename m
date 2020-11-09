From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 09/15] cobalt/thread: call dovetail_resume_inband instead of
 __ipipe_reenter_root
Date: Mon,  9 Nov 2020 02:50:21 -0500
Message-Id: <20201109075027.14760-9-hongzhan.chen@intel.com>
In-Reply-To: <20201109075027.14760-1-hongzhan.chen@intel.com>
References: <20201109075027.14760-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com, xenomai@xenomai.org

resume inband on dovetail

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/thread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index e2a215703..fc29cc521 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2140,8 +2140,8 @@ void xnthread_relax(int notify, int reason)
 		  "xnthread_relax() failed for thread %s[%d]",
 		  thread->name, xnthread_host_pid(thread));
 
-#warning TODO: nothing to be done?
-	//__ipipe_reenter_root();
+	/* Please refer to evl_switch_inband */
+	dovetail_resume_inband();
 
 	/* Account for secondary mode switch. */
 	xnstat_counter_inc(&thread->stat.ssw);
-- 
2.17.1


