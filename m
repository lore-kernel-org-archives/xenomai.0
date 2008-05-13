Message-ID: <48293269.7060201@domain.hid>
Date: Tue, 13 May 2008 08:17:13 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <6132061f0805122051j6854ee1bm20577b53397a6783@domain.hid>
In-Reply-To: <6132061f0805122051j6854ee1bm20577b53397a6783@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] POSIX API
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno Carneiro Pinheiro <brenodee@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Breno Carneiro Pinheiro wrote:
> Hi all, I wanna some help with my application. I'm learning about
> Xenomai POSIX and Native API. I wonder know what is wrong with my code
> below because both don't worked out:
> 
> POSIX:
> 
> #include <sys/mman.h>
> 
> #include <posix/pthread.h>
> #include <posix/time.h>
> 
> #include <stdio.h>
> 
> static pthread_t task_desc;
> void task_body (void *cookie)
>  {
>      struct timespec time;
>      clock_gettime(CLOCK_MONOTONIC, &time);;
>      pthread_make_periodic_np(pthread_self(),&time, 1000000000);
>      while(1) {
>      printf("%s\n","a");
>      }
>  }
>  
> int main (int argc, char *argv[])
>  
>  {
>      int ret;
>      pthread_attr_t thattr;
>  
>      pthread_attr_init(&thattr);
>      pthread_attr_setdetachstate(&thattr, 0);
>      pthread_attr_setstacksize(&thattr, 1024);
>      ret = pthread_create(&task_desc, NULL, &task_body, NULL);
>     
>      if(!ret)
>       pthread_join(task_desc, NULL);
>    
>  }
> 
> and NATIVE
> 
> #include <sys/mman.h>
> #include <native/task.h>
> #include <native/queue.h>
> #include <native/intr.h>
> #include <native/pipe.h>
> 
> #include <stdio.h>
> #define TASK_PRIO  99 /* Highest RT priority */
> #define TASK_MODE  0  /* No flags */
> #define TASK_STKSZ 0  /* Stack size (use default one) */
>  
> RT_TASK task_desc;
> RTIME period_ns =  1000000000llu;
> void task_body (void *cookie)
>  {
>      unsigned long overrun;
>      rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(period_ns));
>      while(1) {
>      rt_task_wait_period(&overrun);
>      printf("%s\n","a");
>      }
>  }
>  
> int main (int argc, char *argv[])
>  
>  {
>      int err;
>      int ret;
>      pthread_attr_t thattr;
>      mlockall(MCL_CURRENT|MCL_FUTURE);
>  
>      err = rt_task_create(&task_desc,
>                           "teste",
>                           TASK_STKSZ,
>                           TASK_PRIO,
>                           TASK_MODE);
>     
>     
>     if (!err)
>          rt_task_start(&task_desc,&task_body,NULL);
>  
>      /* ... */
>  }
> 
>  void cleanup (void)
> 
>  {
>     rt_task_delete(&task_desc);
>  }
> 
> I used the Makefile attached and tried to run on powerpc processor using
> NFS.

Please, don't bother use with obviously incomplete and buggy code.
Start with working examples. As I told you, there are examples on how to
use the native. POSIX and RTDM skin in

  http://www.rts.uni-hannover.de/xenomai/lxr/source/examples/

Can you make and run them on your target?

Wolfgang.

