Message-ID: <52233D18.9040706@laposte.net>
Date: Sun, 01 Sep 2013 15:11:52 +0200
From: Marc Le Douarain <marc.le-douarain@laposte.net>
MIME-Version: 1.0
References: <52232BE0.6050400@laposte.net> <522337CF.2010402@xenomai.org>
In-Reply-To: <522337CF.2010402@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai]
 =?utf-8?b?RXJyb3IgImZpZWxkIOKAmHBzZTUxX3Np4oCZIGhhcyBp?=
 =?utf-8?q?ncomplete_type=22_in_syscall=2Eh_after_upgrading_Ubuntu_Distrib?=
 =?utf-8?q?_to_13=2E04?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Le 01/09/2013 14:49, Gilles Chanteperdrix a écrit :
> On 09/01/2013 01:58 PM, Marc Le Douarain wrote:
>> Hello everybody,
>>
>> I have an application using Xenomai that do no more compile after I have
>> recently upgraded from Ubuntu 12.10 to 13.04
>>
>> Here the error I have in one one file including "phread.h" :
>> gcc -c tasks.c -o tasks.o -march=i486 ...(custom defines)...
>> `xeno-config --skin posix --cflags`
>> In file included from /usr/xenomai/include/asm/xenomai/syscall.h:23:0,
>>                    from /usr/xenomai/include/nucleus/trace.h:52,
>>                    from /usr/xenomai/include/nucleus/system.h:27,
>>                    from /usr/xenomai/include/asm/xenomai/system_32.h:137,
>>                    from /usr/xenomai/include/asm/xenomai/system.h:2,
>>                    from /usr/xenomai/include/nucleus/types.h:41,
>>                    from /usr/xenomai/include/nucleus/thread.h:25,
>>                    from /usr/xenomai/include/posix/pthread.h:136,
>>                    from tasks.c:34:
>> /usr/xenomai/include/asm-generic/xenomai/syscall.h:78:17: erreur: field
>> ‘pse51_si’ has incomplete type
>> make: *** [tasks.o] Erreur 1
>>
>> gcc installed on this version is 4.7.3
>> My project based on Linux kernel 2.6.38.8 and Xenomai 2.5.6
>>
>> any one have an idea, on something that could be done...?
>> else I'm thinking to install an older version in virtual machine to no
>> more encounter bad surprises with upgrades !
> You are probably lacking a #include, add the missing include and it
> should be fine. Also, Xenomai 2.5.6 and Linux 2.6.38 are really old,
> updating is recommended.
>
>
Thank for the tip, but I've exactly the same error, with an old little 
"hello" example,
directly at the bottom of this message.
Example using native tasks, and that was compiling correctly before 
distrib upgrade...

Bye, bye.

gcc hello_test.c -march=i486 -O2 -fno-omit-frame-pointer 
`/usr/xenomai/bin/xeno-config --skin=native --cflags` -march=i486 -O2 
`/usr/xenomai/bin/xeno-config --skin=native --ldflags` -o hello_test
In file included from /usr/xenomai/include/asm/xenomai/syscall.h:23:0,
                   from /usr/xenomai/include/nucleus/trace.h:52,
                   from /usr/xenomai/include/nucleus/system.h:27,
                   from /usr/xenomai/include/asm/xenomai/system_32.h:137,
                   from /usr/xenomai/include/asm/xenomai/system.h:2,
                   from /usr/xenomai/include/nucleus/types.h:41,
                   from /usr/xenomai/include/nucleus/thread.h:25,
                   from /usr/xenomai/include/nucleus/sched.h:31,
                   from /usr/xenomai/include/native/task.h:25,
                   from hello_test.c:7:
/usr/xenomai/include/asm-generic/xenomai/syscall.h:78:17: erreur: field 
‘pse51_si’ has incomplete type
make: *** [all] Erreur 1


Here directly the files :

********************
*** hello_test.c ***
********************

#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/timer.h>

RT_TASK task_desc;

static void task(void *arg)
{

     RTIME now,previous;

     rt_task_set_periodic( NULL, TM_NOW, 1000000000 );
     previous = rt_timer_read( );

     while( 1 )
     {
         rt_task_wait_period( NULL );
         now = rt_timer_read( );

           printf("Hello world xenomai test! %ld.%06ld ms\n", 
(long)(now-previous)/1000000, (long)(now-previous)%1000000 );

   /* Outch... printf accesses a Linux ressource so we are now
      in secondary mode */
     }
}

void catch_signal( int sig )
{
}

int main (void)
{
     int err;

printf("starting...\n");

   signal( SIGTERM,catch_signal );
   signal( SIGINT,catch_signal );

   /* disable memory swap */
   mlockall( MCL_CURRENT | MCL_FUTURE );

   err = rt_task_create( &task_desc, "demo_task", 0, 99, 0 );
   if (err!=0 )
   {
     printf("rt_task_create error : %d\n",err);
     return 1;
   }

   err = rt_task_start( &task_desc, &task, NULL );
   if (err!=0 )
   {
     printf("rt_task_start error : %d\n",err);
     return 1;
   }

   printf("running!\n");
   pause( );

   rt_task_delete( &task_desc );
   return 0;
}

********************
*** Makefile ***
********************

CFLAGS = -march=i486 -O2 -fno-omit-frame-pointer
LDFLAGS = -march=i486 -O2

CFLAGS += `/usr/xenomai/bin/xeno-config --skin=native --cflags`
LDFLAGS += `/usr/xenomai/bin/xeno-config --skin=native --ldflags`


all:
     gcc hello_test.c $(CFLAGS) $(LDFLAGS) -o hello_test

cflags:
     echo $(CFLAGS)

ldflags:
     echo $(LDFLAGS)






