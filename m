Message-ID: <e325d110607130737j3011b167wef31d2bf8fa6fd42@domain.hid>
Date: Thu, 13 Jul 2006 15:37:00 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
Subject: Re: [Xenomai-help] RT timer help
In-Reply-To: <17590.14655.583084.480317@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e325d110607130503k37a4e648p1ae581e7b984abb4@domain.hid>
	<17590.14655.583084.480317@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Sorry for my stupid mistake.

i have changed my program to use rt_timer_ns2ticks(1000000000) but it
tooks approximate 10 seconds for each looping.

Console output:
Hello!! count_1 k_time_1152791787119305408
Hello!! count_2 k_time_1152791788119303732
Hello!! count_3 k_time_1152791789119302894
Hello!! count_4 k_time_1152791790119302894
Hello!! count_5 k_time_1152791791119302894
Hello!! count_6 k_time_1152791792119302894
Hello!! count_7 k_time_1152791793119303732
Hello!! count_8 k_time_1152791794119302894
Hello!! count_9 k_time_1152791795119302894

my program...
#include <signal.h>
#include <sys/mman.h>
#include <native/task.h>

int count=0;

void demo(void *arg)
{
   int err = rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(1000000000));
   RTIME k_time;
   while (count<10) {
       rt_task_wait_period(NULL);
       /* real-time jobs */
	k_time = rt_timer_read();
	printf("Hello!! count_%d k_time_%llu\n",++count,k_time);
   }
}

void catch_signal(int sig) {
	printf("In ::catch_signal(), sig == %d\n",sig);
}

int main(int argc, char* argv[])
{
   RT_TASK demo_task;
   signal(SIGINT, catch_signal);
   mlockall(MCL_CURRENT|MCL_FUTURE);
   rt_task_create(&demo_task, "mydemo", 0, 99, 0);
   rt_task_start(&demo_task, &demo, NULL);
   pause();
   rt_task_delete(&demo_task);
   return 0;
}

May i know is 1ns system clock time equal to 1ns real world time?

Regards,
Kim Chuan.

