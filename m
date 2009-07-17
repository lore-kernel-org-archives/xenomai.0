Message-ID: <4A607BA8.9020505@domain.hid>
Date: Fri, 17 Jul 2009 15:24:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] native: Align documentation to code
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

(probably stable stuff, too)

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/skins/native/task.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/ksrc/skins/native/task.c b/ksrc/skins/native/task.c
index 161bc1c..ef10eb1 100644
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -180,7 +180,7 @@ void __native_task_pkg_cleanup(void)
  * substituted.
  *
  * @param prio The base priority of the new task. This value must
- * range from [1 .. 99] (inclusive) where 1 is the lowest effective
+ * range from [0 .. 99] (inclusive) where 0 is the lowest effective
  * priority.
  *
  * @param mode The task creation mode. The following flags can be
@@ -816,10 +816,10 @@ int rt_task_wait_period(unsigned long *overruns_r)
  *
  * @param task The descriptor address of the affected task.
  *
- * @param prio The new task priority. This value must range from [1
- * .. 99] (inclusive) where 1 is the lowest effective priority.
+ * @param prio The new task priority. This value must range from [0
+ * .. 99] (inclusive) where 0 is the lowest effective priority.
 
- * @return 0 is returned upon success. Otherwise:
+ * @return Upon success, the previously set priority is returned. Otherwise:
  *
  * - -EINVAL is returned if @a task is not a task descriptor, or if @a
  * prio is invalid.
@@ -2155,7 +2155,7 @@ int rt_task_reply(int flowid, RT_TASK_MCB *mcb_s)
  * substituted.
  *
  * @param prio The base priority of the new task. This value must
- * range from [1 .. 99] (inclusive) where 1 is the lowest effective
+ * range from [0 .. 99] (inclusive) where 0 is the lowest effective
  * priority.
  *
  * @param mode The task creation mode. The following flags can be
@@ -2258,7 +2258,7 @@ int rt_task_reply(int flowid, RT_TASK_MCB *mcb_s)
  * enabled for indexing the created task.
  *
  * @param prio The base priority which will be set for the current
- * task. This value must range from [1 .. 99] (inclusive) where 1 is
+ * task. This value must range from [0 .. 99] (inclusive) where 0 is
  * the lowest effective priority.
  *
  * @param mode The task creation mode. The following flags can be

