MIME-Version: 1.0
Date: Sat, 18 Apr 2015 10:52:48 +0800
Message-ID: <CABqyFP9Trq2CVWVQPqvJrwNza1-mTm5NS1T16-Pno5xEY-eOKg@mail.gmail.com>
From: Ruika You <crazylinuxcnc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Error: could not insert module kernel-task.ko: Unknown
	symbol in module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear all,

I just start to explore xenomai with compile a kernel module as simple as
"hello world". After compile successful, sudo insmod kernel-task.ko,
failed, error message as follow:
Error: could not insert module kernel-task.ko: Unknown symbol in module

Dmesg result as belllow:
[52170.262642] kernel_task: Unknown symbol rt_task_create (err 0)
[52170.262688] kernel_task: Unknown symbol rt_task_start (err 0)
[52170.262722] kernel_task: Unknown symbol rt_task_delete (err 0)

Source code:
#include <native/task.h>
#define TASK_PRIO 99 /* Highest RT priority */
#define TASK_MODE T_FPU|T_CPU(0) /* Uses FPU, bound to CPU #0 */
#define TASK_STKSZ 4096 /* Stack size (in bytes) */
RT_TASK task_desc;
void task_body (void *cookie)
{
for (;;) {
/* ... "cookie" should be NULL ... */
}
}
int init_module (void)
{
int err;
/* ... */
err =
rt_task_create(&task_desc,"MyTaskName",TASK_STKSZ,TASK_PRIO,TASK_MODE);
if (!err)
rt_task_start(&task_desc,&task_body,NULL);
return 1;
/* ... */
}
void cleanup_module (void)
{
rt_task_delete(&task_desc);
}

As I analyzed the reason might be :

1. kernel build configure problem ?
2. xenomai userland  configure problem?
3. any xenomai module not loaded? native?
4. have to export all these unknow symbol to kernel?

Please advise!
Thank you very much!
-chengxi
