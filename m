Content-Type: text/plain; charset="us-ascii"
Date: Tue, 24 Jun 2008 14:36:02 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
Message-ID: <20080624123602.114820@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] error creating a task with rt_task_spawn
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I'm trying to create and start a new thread via rt_task_spawn() but I always get error -3. ("Unknown error: -3")

Any idea?


Thanks in advance
Karl





#include "main.h"

#include <stdio.h>
#include <signal.h>
#include <native/task.h>
#include <native/timer.h>
#include <native/mutex.h>
#include <sys/mman.h>

int i,j,x;
RT_TASK *rx_tsk;

int ret1;
int ret2;

void rx_task(void *cookie);
void cleanup(int dummy);

int main (int argc, char* argv[])
{
	i = 0;
   
   if ( -1 == mlockall (MCL_CURRENT | MCL_FUTURE) ) {
        perror("mlockall: ");
        return -1;
   }

	ret1 = rt_task_spawn(rx_tsk, "rx_task", 0, 1, T_FPU|T_CPU(1), &rx_task, NULL);
	if( ret1 != 0 )
	{
      switch(ret1)
      {
         case -ENOMEM: printf("no memory!\n");
            break;
         case -EEXIST: printf("already registered!\n");
            break;
         case -EPERM: printf("asychron context!\n");
            break;
         default: printf("Unknown error: %i\n", ret1);
            break;
      }
      return -2;
	}

	for(;i<10000;)
	{
		x=i/23%2;
		i++;
		
	}
		
	ret2 = rt_task_delete(rx_tsk);
	if( 0 != ret2 )
	{
		printf("delete error: %i\n", ret2);
      return -3;
	}

	return 0;
}

void rx_task(void *cookie)
{
	j=0;
	j++;
	while(1);
}

-- 
von Karl Reichert


