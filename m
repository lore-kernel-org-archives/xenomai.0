Message-ID: <4F46B792.8070204@domain.hid>
Date: Thu, 23 Feb 2012 16:02:58 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
References: <4F3BD76C.1040703@domain.hid> <4F3BDC1E.9090707@domain.hid>
In-Reply-To: <4F3BDC1E.9090707@domain.hid>
Content-Type: multipart/mixed; boundary="------------090002000205030700060403"
Subject: [Xenomai-help] Real-time printf in Xenomai 2.6.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090002000205030700060403
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I was happy to see that printf now works from real-time POSIX threads in Xenomai 2.6.0.  Unfortunately, I'm seeing some strange behavior that surfaces when I try to print the string "\n" by itself.  When I run the attached example program, I get:

   $ ./printf_test
   start
   CPU time limit exceeded
   $

IfI replace the two printf calls with rt_printf calls and #include <rtdk.h>,I get the expected result:

   $ ./rt_printf_test
   start
   1
   2
   3
   4
   ^C
   $

The original example also works if these two lines:

         printf("%d", count);
         printf("\n");

are replaced with:

         printf("%d\n", count);

Can someone confirm if this a bug in Xenomai 2.6.0, something specific to my HW/SW installation, or some mistake in my test program?

Thanks,

Jeff

--------------090002000205030700060403
Content-Type: text/x-csrc;
 name="printf_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="printf_test.c"

#include <stdio.h>
#include <pthread.h>
#include <sys/mman.h>
#include <malloc.h>

int count = 0;

void * rt_loop(void * arg)
{
    struct timespec dt_ts;
    dt_ts.tv_sec  = 1;
    dt_ts.tv_nsec = 0;    

    pthread_set_mode_np(0, PTHREAD_WARNSW);

    printf("start\n");

    while (1)
    {
        count++;
        clock_nanosleep(CLOCK_REALTIME, 0, &dt_ts, NULL);
        printf("%d", count);
        printf("\n");
    }
    
    return NULL;
}

int main(void)
{
    pthread_attr_t attr;
    pthread_t rt_thread;
    struct sched_param sparam;
  
    mlockall(MCL_CURRENT | MCL_FUTURE);

    sparam.sched_priority = 16;

    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
    pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
    pthread_attr_setschedparam(&attr, &sparam);
    pthread_create(&rt_thread, &attr, &rt_loop, NULL);
    pthread_attr_destroy(&attr);

    pthread_join(rt_thread, NULL);

    return 0;
}

--------------090002000205030700060403--

