Date: Tue, 25 Sep 2012 14:59:46 +0200 (CEST)
From: hahnchristopher@arcor.de
Message-ID: <743819185.213171.1348577986595.JavaMail.ngmail@webmail24.arcor-online.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Segmentation fault in RT_TASK with too big arrays?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I tried to create an int array with big size (up to 160k), but all sizes over 4096 throws segmentation faults!
That FAQ for POSIX skin tells me, that there is a variable thread stack size. Is there a equivalent native call for pthread_attr_setstacksize() ?
Or do I have an other problem?

here is my code:

#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>
#include <native/task.h>
#include <rtdk.h>

RT_TASK task;

void taskOne(void *arg)
{
	rt_printf("starting task1\n");
    int i;
    int IWORK[160000];

    for (i = 0; i < 20; i++) {

    	IWORK[i] = 0;

    }
    rt_printf("finished task1\n");
}

void startup()
{
	rt_timer_set_mode(0);
    rt_task_create(&task, "task1", 0, 50, 0);
    rt_task_start(&task, taskOne, 0);

}

void init_xenomai() {
	mlockall(MCL_CURRENT|MCL_FUTURE);
	rt_print_auto_init(1);
}

int main(int argc, char* argv[])
{
  init_xenomai();

  startup();

  pause();
}

