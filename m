Message-ID: <4FCD0BD8.70103@laposte.net>
Date: Mon, 04 Jun 2012 21:26:16 +0200
From: Marc Le Douarain <marc.le-douarain@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] "illegal instruction",
 then "rt_task_start()" error -38 (on a 486/no fpu)
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

I've some difficulties to run Xenomai with a little 'hello' example 
(that create/start a task)
on a target 486 processor (without fpu).

I successfully compiled the Linux kernel 2.6.38.8 with 
adeos-ipipe-2.6.38.8-x86-2.11-02.patch (Xenomai version is 2.5.6)
(modify file xenomai-2.5.6/include/asm-x86/calibration.h 
"current_cpu_data"->"cpu_info" were required)

dmesg extract:
[    0.000000] I-pipe 2.11-02: pipeline enabled.
...
[    0.140008] CPU: Cyrix Cx486SLC
...
[    1.440804] Xenomai: hal/i386 started.
[    1.448804] Xenomai: scheduling class idle registered.
[    1.452804] Xenomai: scheduling class rt registered.
[    1.488806] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
[    1.496807] Xenomai: starting native API services.
[    1.500807] Xenomai: starting POSIX services.
[    1.504807] Xenomai: starting RTDM services.

After compiling user-space Xenomai part with
./configure --disable-x86-sep --disable-x86-tsc / make / sudo make install
and copy /usr/xenomai/lib on the target
I've got "illegal instruction" with my little 'hello test' example that 
create/start a task.

Then I've tried to add flag to set 486 instruction set to gcc...
For that, to compile user-space this time I used :
./configure CFLAGS="-march=i486" LDFLAGS="-march=i486" --disable-x86-sep 
--disable-x86-tsc / make / sudo make install
Now, at rt_task_start, I've got an error code -38 !

Any one have an idea on the trouble ?
(at start thinking on the fpu missing, but seems not to be used !? no 
libm dependance)

Many thanks.



Here my little hello_test example code used :
============================
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

   /* wait for task function termination */
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

And the Makefile :
===========
CFLAGS = -march=i486 -O2
LDFLAGS = -march=i486 -O2

CFLAGS += `/usr/xenomai/bin/xeno-config --skin=native --cflags`
LDFLAGS += `/usr/xenomai/bin/xeno-config --skin=native --ldflags`

all:
     gcc hello_test.c $(CFLAGS) $(LDFLAGS) -o hello_test

cflags:
     echo $(CFLAGS)

ldflags:
     echo $(LDFLAGS)




