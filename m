Message-ID: <47D6CD29.4020700@domain.hid>
Date: Tue, 11 Mar 2008 19:19:21 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] What have I misunderstood about condition variables
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Why do I get the following output (Xenomai 2.4.2 / kernel 2.6.24.3):

ABCaAbBCABCcd 3
aAbBCABCcd 5
aAbBCABCcd 7
aAbBCABCcd 9
aAbBCABCcd 11
aAbBCABCcd 13

>From this small program:

#include <native/cond.h>
#include <native/mutex.h>
#include <native/task.h>
#include <native/timer.h>
#include <rtdk.h>
#include <sys/mman.h>

RT_TASK main_task, producer_task, consumer_task;
RT_MUTEX mutex;
RT_COND cond;
int data;

static void producer(void *arg)
{
  while(1) {
    rt_task_set_mode(0, T_PRIMARY, 0);
    rt_printf("A");
    rt_mutex_acquire(&mutex, TM_INFINITE);
    rt_printf("B");
    data++;
    rt_mutex_release(&mutex);
    rt_mutex_acquire(&mutex, TM_INFINITE);
    rt_cond_broadcast(&cond);
    rt_printf("C");
    rt_mutex_release(&mutex);
    rt_task_sleep(100000000L);
  }
}


static void consumer(void *arg)
{
  while(1) {
    int err;

    rt_task_set_mode(T_PRIMARY, 0, 0);
    rt_mutex_acquire(&mutex, TM_INFINITE);
    rt_printf("a");
    rt_task_sleep(1000000000L);
    rt_printf("b");
    err = rt_cond_wait(&cond, &mutex, TM_INFINITE);
    rt_printf("c");
    rt_mutex_release(&mutex);
    rt_printf("d %d\n", data);
  }
}


int main(int argc, char *argv[])
{
  mlockall(MCL_CURRENT|MCL_FUTURE);
  rt_print_auto_init(1);
  rt_task_shadow(&main_task, NULL, 1, T_FPU);
  rt_mutex_create(&mutex, NULL);
  rt_cond_create (&cond, NULL);
  rt_task_create(&producer_task, NULL, 0, 50, 0);
  rt_task_start(&producer_task, &producer, NULL);
  rt_task_create(&consumer_task, NULL, 0, 20, 0);
  rt_task_start(&consumer_task, &consumer, &consumer_task);
  while (1) {
    rt_task_sleep(1000000000L);
  }
  return 0;
}

To me the symptoms indicate that the high priority producer gets the mutex and
signals it before the consumer has properly started to wait on the condition.

Regards

Anders Blomdell


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

