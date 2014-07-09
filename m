Message-ID: <53BCF270.3010303@xenomai.org>
Date: Wed, 09 Jul 2014 09:42:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53A3E8FE.5020005@xenomai.org>
 <1403519510.94410.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1403555262.58217.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1404233289.69461.YahooMailNeo@web171605.mail.ir2.yahoo.com>
In-Reply-To: <1404233289.69461.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FreeRTOS skin #2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/01/2014 06:48 PM, Matthias Schneider wrote:
> Please find enclosed another calling the check_processors() only when starting
> the scheduler and remembering its output. It is also adapted to the latest changes.
> Any comments will be appreciated.
>

- clusters allowing key dups are available using the *_dup() call form
- vTaskEndScheduler() can be simplified, and should not panic if it 
cannot lock a vanishing thread pulled from the task list.

commit 9239281e4badb56a2449723e0204c597ed3743b1
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Wed Jul 9 09:26:55 2014 +0200

     freertos: use cluster with duplicate key support

diff --git a/lib/freertos/task.c b/lib/freertos/task.c
index f7d99a5..d201711 100644
--- a/lib/freertos/task.c
+++ b/lib/freertos/task.c
@@ -407,7 +407,6 @@ static signed portBASE_TYPE 
__xTaskGenericCreate(struct freertos_task *task,
  	struct corethread_attributes cta;
  	struct threadobj_init_data idata;
  	int ret, cprio;
-	size_t i = 0, id_pos;

  	cprio = convert_freertos_task_priority(uxPriority);

@@ -427,24 +426,7 @@ static signed portBASE_TYPE 
__xTaskGenericCreate(struct freertos_task *task,

  	generate_name(task->name, (const char *)name, &task_namegen);

-	/* since cluster entries must have unique names, we try to append
-	   names that seem to exist already with an id. */
-	for (i = 0; i < TASK_DUPLICATED_NAME_MAX_ID; ++i) {
-		ret = cluster_addobj(&freertos_task_table, task->name, &task->cobj);
-		if (ret != -EEXIST)
-			break;
-		if (i == 0) {
-			id_pos = strlen(task->name);
-			id_pos = (id_pos > TASK_DUPLICATED_NAME_MAX_ID_MAX_POS)
-				? TASK_DUPLICATED_NAME_MAX_ID_MAX_POS
-				: id_pos;	
-		}
-		sprintf(task->name + id_pos, "%1d", i);
-	}
-	if (ret == -EEXIST) {
-		warning("duplicate task name: %s (used > %d times)",
-			task->name, TASK_DUPLICATED_NAME_MAX_ID);
-	}
+	ret = cluster_addobj_dup(&freertos_task_table, task->name, &task->cobj);
  	if (__bt(ret)) {
  		threadobj_uninit(&task->thobj);
  		return pdFALSE;

commit c867515edfd63ce7abc0b76095e0613ceb8f7f22
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Wed Jul 9 09:21:03 2014 +0200

     freertos: fix vTaskEndScheduler()

diff --git a/lib/freertos/task.c b/lib/freertos/task.c
index 0af799a..f7d99a5 100644
--- a/lib/freertos/task.c
+++ b/lib/freertos/task.c
@@ -445,8 +445,7 @@ static signed portBASE_TYPE 
__xTaskGenericCreate(struct freertos_task *task,
  		warning("duplicate task name: %s (used > %d times)",
  			task->name, TASK_DUPLICATED_NAME_MAX_ID);
  	}
-	if (ret) {
-		__bt(ret);
+	if (__bt(ret)) {
  		threadobj_uninit(&task->thobj);
  		return pdFALSE;
  	}
@@ -781,35 +780,33 @@ void vTaskStartScheduler(void) {
  	CANCEL_RESTORE(svc);
  }

-void vTaskEndScheduler(void) {
+void vTaskEndScheduler(void)
+{
  	struct service svc;
-	struct freertos_task *task, *tmp, *current;
+	struct freertos_task *task, *current;

  	CANCEL_DEFER(svc);
-	threadobj_lock_sched();

+	current = freertos_task_current();
  	__RT(pthread_mutex_lock(&freertos_scheduler.tasklist_lock));
  	freertos_scheduler.state = taskSCHEDULER_SUSPENDING;
-	__RT(pthread_mutex_unlock(&freertos_scheduler.tasklist_lock));

-	current = freertos_task_current();
-	if (!pvlist_empty(&freertos_task_list)) {
-		pvlist_for_each_entry_safe(task, tmp, &freertos_task_list, next) {
-			if (task == current)
-				continue;
-
-			if (get_freertos_task(task))
-				threadobj_cancel(&task->thobj);
-			else
-				panic("could not lock task %s", task->name);
-        	}
+	while (!pvlist_empty(&freertos_task_list)) {
+		task = pvlist_pop_entry(&freertos_task_list,
+					struct freertos_task, next);
+		if (task == current)
+			continue;
+		__RT(pthread_mutex_unlock(&freertos_scheduler.tasklist_lock));
+		if (get_freertos_task(task))
+			threadobj_cancel(&task->thobj);
+		__RT(pthread_mutex_lock(&freertos_scheduler.tasklist_lock));
  	}

-	threadobj_unlock_sched();
-	CANCEL_RESTORE(svc);
-
+	__RT(pthread_mutex_unlock(&freertos_scheduler.tasklist_lock));
  	threadobj_lock(&current->thobj);
  	threadobj_cancel(&current->thobj);
+
+	CANCEL_RESTORE(svc);
  }

  portBASE_TYPE xTaskGetSchedulerState(void)

-- 
Philippe.

