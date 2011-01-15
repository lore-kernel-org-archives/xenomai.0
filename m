Message-ID: <4D31B6C3.5060007@domain.hid>
Date: Sat, 15 Jan 2011 16:01:23 +0100
From: Wong Sheng Chao <wong@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Question on periodic task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


Hi

I'm a newbie in real time programming and I recently came to know of 
Xenomai. After patching the Xenomai to the linux kernel, I ran some 
examples that I found from the Internet to get a better understanding of 
the periodic task. Everything seems to run fine when I start two tasks 
with period of 1s and 2s, but the system freezes when I added more tasks 
( more than 2 tasks). The period is at 1s, 2s and 3s so i think the 
processor has more than enough time to process the tasks.

I also read that the periodic mode is emulated by a software driver 
which uses one-shot mode programming. Thus i did not enable periodic 
timing when I compile the Linux kernel, is this the cause of the problem?

I'm using a system with Core i7, ubuntu 10.04, linux kernel 2.6.32.15, 
xenomai 2.5.4

Do let me know what I did wrong in the code, thanks in advance!!


void demo (void *arg)
{
  //take in argument
  int num = (int *)arg;

  RT_TASK *curtask;
  RT_TASK_INFO curtaskinfo;

  curtask=rt_task_self();
  rt_task_inquire(curtask,&curtaskinfo);

  // task period in seconds
  rt_task_set_periodic(NULL, TM_NOW, (1000000000 * num));

  while(1)
  {
     rt_printf("Task name: %s \n", curtaskinfo.name);
     rt_task_wait_period(NULL);
   }

}

int main(int argc, char **argv)
{
   rt_print_auto_init(1);

   mlockall(MCL_CURRENT|MCL_FUTURE);

   rt_task_create(&demo_task1, "task1", 0, 1, 0);
   rt_task_create(&demo_task2, "task2", 0, 1, 0);
   rt_task_create(&demo_task3, "task3", 0, 1, 0);

   rt_task_start(&demo_task1, &demo, 1);
   rt_task_start(&demo_task2, &demo, 2);
   rt_task_start(&demo_task3, &demo, 3);

   pause();

   return 0;
}


