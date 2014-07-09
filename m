Message-ID: <53BCFC3D.30403@xenomai.org>
Date: Wed, 09 Jul 2014 10:24:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1400788012.41259.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <1401734780.6508.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53A3E8FE.5020005@xenomai.org>
 <1403519510.94410.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1403555262.58217.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <1404233289.69461.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53BCF270.3010303@xenomai.org>
In-Reply-To: <53BCF270.3010303@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On 07/09/2014 09:42 AM, Philippe Gerum wrote:
> On 07/01/2014 06:48 PM, Matthias Schneider wrote:
>> Please find enclosed another calling the check_processors() only when 
>> starting
>> the scheduler and remembering its output. It is also adapted to the 
>> latest changes.
>> Any comments will be appreciated.
>>
> 
> - clusters allowing key dups are available using the *_dup() call form

I just noticed that you would need uniquement labels for pushing your tasks to the registry anyway, so the following patch on top of the previous one would likely do:

diff --git a/lib/freertos/task.c b/lib/freertos/task.c
index d201711..d005163 100644
--- a/lib/freertos/task.c
+++ b/lib/freertos/task.c
@@ -426,10 +426,17 @@ static signed portBASE_TYPE __xTaskGenericCreate(struct freertos_task *task,
 
 	generate_name(task->name, (const char *)name, &task_namegen);
 
-	ret = cluster_addobj_dup(&freertos_task_table, task->name, &task->cobj);
-	if (__bt(ret)) {
-		threadobj_uninit(&task->thobj);
-		return pdFALSE;
+	for (;;) {
+		ret = cluster_addobj(&freertos_task_table, task->name, &task->cobj);
+		if (ret == -EEXIST) {
+			generate_name(task->name, NULL, &task_namegen);
+			continue;
+		}
+		if (__bt(ret)) {
+			threadobj_uninit(&task->thobj);
+			return pdFALSE;
+		}
+		break;
 	}
 
 	registry_init_file_obstack(&task->fsobj, &registry_ops);

-- 
Philippe.

