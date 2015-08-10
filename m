MIME-Version: 1.0
Date: Mon, 10 Aug 2015 08:01:59 -0500
Message-ID: <CAJ-wHnbT+=x0JLZDbpipGOuuTWA9CFhKrtPZqTXtcTLW+YGS9Q@mail.gmail.com>
From: Timothy Duncan <tduncan5149@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] fix_alignment trap returns nan on PowerPC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

I'm getting not a numbers on floating point unaligned access. I have
traced it down to where it converts double to float in the
fix_alignment function in arch/powerpc/kernel/align.c. I cannot
reproduce the issue on vanilla kernel.

preempt_disable();
enable_kernel_fp();
>cvt_df(&data.dd, (float *)&data.v[4], &current->thread);
preempt_enable();

The double value is sometimes not converted correctly. I am guessing
it gets interrupted by a higher priority task that is also doing
floating point.

I am on an older version of everything and wondering if anyone
remembers there being and issue/fix for something along these lines.

I'm using the ipipe version 2.10-03 patch that was bundled with Xenomai 2.5.4
on Linux 2.6.33.5.

I have created this application to demonstrate the issue. If I run it
twice one time aligned and one time unaligned the unaligned will get
failures. Unaligned by itself works fine.

#include <stdio.h>
#include <string.h>
#include <pthread.h>

static pthread_t other_task;
static pthread_attr_t other_task_attr;
struct sched_param par;
void* other_task_entry(void*);

int i;
int off;
float tmp, expected;
char data[] = {0x00, 0x00, 0x01, 0x00, 0x10, 0x00, 0x00, 0x00};

int main(int argc, char **argv)
{
   off = atoi(argv[1]);

   memcpy(&expected, &data[off], sizeof(float));

   printf("checking for %g\n", expected);

   pthread_attr_init(&other_task_attr);
   pthread_attr_setstacksize(&other_task_attr, 0x1<<16);
   pthread_attr_setdetachstate(&other_task_attr, PTHREAD_CREATE_DETACHED);
   pthread_attr_getschedparam(&other_task_attr, &par);
   par.sched_priority = 95;
   pthread_attr_setschedparam(&other_task_attr, &par);
   pthread_attr_setschedpolicy(&other_task_attr, SCHED_FIFO);
   pthread_attr_setinheritsched(&other_task_attr, PTHREAD_EXPLICIT_SCHED);

   if(pthread_create(&other_task, &other_task_attr, &other_task_entry,
NULL) != 0)
      return 1;

   while(1)
   {
      sleep(10);
   }

   return 0;
}

void* other_task_entry(void* arg)
{
   while(1)
   {
      for(i = 0; i < 100000; i++)
      {
         if((tmp = (*(volatile float*)(&data[off])*15.8f)) != (expected*15.8f))
            printf("err %g:%02x%02x%02x%02x\n", tmp,
                  ((char*)&tmp)[0],
                  ((char*)&tmp)[1],
                  ((char*)&tmp)[2],
                  ((char*)&tmp)[3]);
      }
      usleep(1000);
   }
}

Any help would be appreciated. I am going to start looking at going to
a more recent version of everything, but that may take some time as I
will have to update some drivers that we wrote our board.

