MIME-Version: 1.0
Date: Wed, 08 Jun 2016 14:12:51 +0200
From: Mathieu KOWALEWSKI <matthieu.kowalewski@smile.eu>
Message-ID: <d00bbb2d634101853ccee292203bef44@smile.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Activate a task with an alarm
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

 

Hey, 

I'm trying to create a alarm that can activate a alarm
handler or a task ... 

But when my handler spawn a task, it returns an
EINVAL error. 

I use Alchemy (Native) API and the Cobalt kernel on
Xenomai 3.0.2 with x86 architecture. 

I don't know if it's an
implementation will, to disallow the call of spawning/starting a task in
an alarm handler, or just a bug. 

Here the sample code, a main task
runs an alarm, every 2 sec this alarm tries to start a task: 

#include
<stdio.h>
#include <stdlib.h>
#include <copperplate/traceobj.h>
#include
<alchemy/task.h>
#include <alchemy/alarm.h>

static struct traceobj
trobj;

static int tseq[] = {
 5, 6, 8,
 1, 4, 1, 4, 1,
 2, 3,
7
};

static RT_TASK t_main;
static RT_TASK t_2;

static RT_ALARM
alrm;

static void task_2(void *arg)
{

 printf("Task 2
runn");

}

static void alarm_handler(void *arg)
{
 static int hits;

int ret;

 traceobj_assert(&trobj, arg == &alrm);


traceobj_mark(&trobj, 1);
 ret = rt_task_spawn(&t_2, "task_2", 0, 50, 0,
task_2, NULL);
 traceobj_check(&trobj, ret, 0);

 traceobj_mark(&trobj,
2);

 if (++hits >= 3) {

 ret = rt_alarm_stop(&alrm);

traceobj_check(&trobj, ret, 0);

 traceobj_mark(&trobj, 3);
 ret =
rt_task_resume(&t_main);
 traceobj_check(&trobj, ret, 0);
 return;

}
}

static void main_task(void *arg)
{
 RT_TASK *p;
 int ret;

printf("Task main runn");
 traceobj_enter(&trobj);
 p = rt_task_self();

traceobj_assert(&trobj, p != NULL && rt_task_same(p, &t_main));


traceobj_mark(&trobj, 4);
 ret = rt_alarm_create(&alrm, "ALARM",
alarm_handler, &alrm);
 traceobj_check(&trobj, ret, 0);


traceobj_mark(&trobj, 5);
 ret = rt_alarm_start(&alrm, 2000000000ULL,
200000000ULL);
 traceobj_check(&trobj, ret, 0);

 traceobj_mark(&trobj,
6);
 ret = rt_task_suspend(&t_main);
 traceobj_check(&trobj, ret, 0);


traceobj_mark(&trobj, 7);
 ret = rt_alarm_delete(&alrm);

traceobj_check(&trobj, ret, 0);

 traceobj_exit(&trobj);
}

int main(int
argc, char *const argv[])
{
 int ret;

 traceobj_init(&trobj, argv[0],
sizeof(tseq) / sizeof(int));

 traceobj_mark(&trobj, 0);
 ret =
rt_task_spawn(&t_main, "main_task", 0, 40, 0, main_task, NULL);

traceobj_check(&trobj, ret, 0); 

 traceobj_join(&trobj);


//traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));


exit(0);
} 

And the error from the spawn return: 

BUG in
__traceobj_check_abort(): [main] wrong return status:
 alarm-1.c:36 =>
EINVAL (want OK)

Thanks 

Matthieu Kowalewski 

 
