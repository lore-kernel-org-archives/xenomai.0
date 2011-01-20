Date: Thu, 20 Jan 2011 17:44:36 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D384CC9.2040303@domain.hid>
Message-ID: <alpine.DEB.1.10.1101201702340.1990@domain.hid>
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Pierre.QUELIN@solystic.com

> So, could you describe me exactly the procedure you are following wich
> allows to reproduce this issue?


My attempt to run cond-torture-posix step by step:

1. copy cond-torture-posix as it was built in the blackfin-linux-dist (FDPIC) to target

/opt/uClinux/blackfin-linux-dist/user/xenomai/build-xenomai-2.5.5.2/src/testsuite/unit/.libs/cond-torture-posix

2. first attempt to start cond-torture-posix fails because librt.so.0 was not on my target, so I transferred /opt/uClinux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib/librt.so.0

3. cond-torture-posix standalone passes

4. I start cond-torture-posix on the target with "gdbserver :2222 ./cond-torture-posix"

5. I start bfin-linux-uclibc-gdb and issue the commands

file cond-torture-posix
target remote 10.0.10.9:2222
break main
cont

6. The result is a SEGV on the target as described in https://mail.gna.org/public/xenomai-help/2010-12/msg00088.html  - even before breakpoint main() was reached and without backtrace in gdb.


/usr/bin # gdbserver :2222 ./cond-torture-posix 
Process ./cond-torture-posix created; pid = 240
Listening on port 2222
Remote debugging from host 10.0.10.10
NULL pointer access
Deferred Exception context
CURRENT PROCESS:
COMM=cond-torture-po PID=240  CPU=0
TEXT = 0x01738000-0x0173e214        DATA = 0x016e6214-0x016e6610
  BSS = 0x016e6610-0x016a0000  USER-STACK = 0x016bfe60

return address: [0x01726f10]; contents of:
0x01726ef0:  e42f  0015  0c07  1405  3047  67f8  e628  0015 
0x01726f00:  320e  3044  300d  3014  e50a  003a  5ea2  9153 
0x01726f10: [9159] ac5b  0061  0c07  1404  6000  e628  0015 
0x01726f20:  e801  0000  05a4  0010  e51a  0016  05f4  e800

ADSP-BF537-0.3 533(MHz CCLK) 133(MHz SCLK) (mpu off)
Linux version 2.6.34.7-ADI-2010R1-svn10663 (kawk@domain.hid) (gcc version 4.3.5 (ADI-2010R1-RC4) ) #33 Wed Jan 12 10:02:14 CET 2011

SEQUENCER STATUS:		Not tainted
  SEQSTAT: 00060027  IPEND: 0008  IMASK: ffff  SYSCFG: 0006
   EXCAUSE   : 0x27
   physical IVG3 asserted : <0xffa0076c> { _trap + 0x0 }
  RETE: <0x00000000> /* Maybe null pointer? */ RETN: <0x0161e000> /* kernel
dynamic memory */
  RETX: <0x00000480> /* Maybe fixed code section */
  RETS: <0x01726eda> [ /lib/libpthread.so.0 + 0x6eda ]
  PC  : <0x01726f10> [ /lib/libpthread.so.0 + 0x6f10 ]
DCPLB_FAULT_ADDR: <0x00000000> /* Maybe null pointer? */
...





What I'm actually doing to reproduce the EPERM from pthread_cond_wait in a 
situation where I think it shouldn't occur was with the code I posted. Or,
keeping printfs() etc away from the tasks in which the pthread_cond_wait is
used, the code following at the end might be better suited to serve as an example.

I'd be interested if this example gives the same output on Pierre Quelin's system?


Explanation first - the core loop of each of three threads in the
example is as follows. It just sets bits in an errbits[] variable for each
thread depending on the result of pthread_cond_wait. The main task sleeps a
second, then sets run==0 and broadcasts on cond to stop all threads.


    pthread_mutex_lock(&mutex);
    while (run)
    {
        int r = pthread_cond_wait(&cond, &mutex);
        loopcount[tnum]++;
        switch(r)
        {
            case 0:  errbits[tnum] |= LOG_NOERR; break;
            case 1:  errbits[tnum] |= LOG_EPERM; pthread_yield(); break;
            default: errbits[tnum] |= LOG_OTHER; pthread_yield(); break;
        }
    }
    pthread_mutex_unlock(&mutex);



Not sure if the pthread_yield() was necessary in this version of the code, it
might be a remainder of further experiments with varying priorities for the
threads.


I compile it with

bfin-linux-uclibc-gcc \
   -I/opt/uClinux/blackfin-linux-dist/staging/usr/include \
   -L/opt/uClinux/blackfin-linux-dist/staging/usr/lib \
   -g -fPIC -fmessage-length=0 -mfast-fp -D_GNU_SOURCE -D_REENTRANT \
   -D__XENO__ -Wl,@/opt/uClinux/blackfin-linux-dist/staging/usr/lib/posix.wrappers \
   -lpthread_rt -lxenomai -o try try.c

Then transfer it to the target and run it standalone - the result is

# ./try 
0 1x 0x0010
1 1x 0x0010
2 1x 0x0010

This result means that the loop body in each of three tasks was executed exactly
once and the result of pthread_cond_wait in the loop body was (always) zero (=>
the errbits are set to 0x0010, LOG_NOERR).


In contrast, I tried to run it via gdbserver. The commands were

set verbose on
set solib-absolute-prefix notexistent
set solib-search-path /opt/uClinux/blackfin-linux-dist/staging/usr/lib:/opt/uClinux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib
file try
target remote 10.0.10.9:2222
break main
cont
cont



The result on the target is now

/tmp # gdbserver :2222 ./try
Process ./try created; pid = 281
Listening on port 2222
Remote debugging from host 10.0.10.10
0 3784x 0x0001
1 6686x 0x0001
2 1x 0x0010


The 0x0001 (LOG_EPERM) shown for the first two threads means they always got
EPERM, never success.


By chance, I found that my example succeeds in all three threads (as without
gdbserver) on the target if I omit loading symbols with the "file" command in
gdb and just issue "target remote 10.0.10.9:2222" and "cont".


Here's the full code:



/* 2010-12-27 - test program for pthread_cond_wait */

#include <stdio.h>
#include <string.h>
#include <posix/pthread.h>

#define NUM_THREADS 3

#define LOG_EPERM 0x0001
#define LOG_OTHER 0x0008
#define LOG_NOERR 0x0010

volatile int run;
volatile unsigned errbits[NUM_THREADS];
volatile unsigned loopcount[NUM_THREADS];
pthread_cond_t cond;
pthread_mutex_t mutex;
const struct timespec dt = { 0, 100*1000 };

void* test_thread(void *cookie)
{
     int tnum = *(int*)cookie;

     pthread_mutex_lock(&mutex);
     while (run)
     {
         int r = pthread_cond_wait(&cond, &mutex);
         loopcount[tnum]++;
         switch(r)
         {
             case 0:  errbits[tnum] |= LOG_NOERR; break;
             case 1:  errbits[tnum] |= LOG_EPERM; pthread_yield(); break;
             default: errbits[tnum] |= LOG_OTHER; pthread_yield(); break;
         }
     }
     pthread_mutex_unlock(&mutex);

     return NULL;
}

int main (void)
{
     int r;
     int i;
     int tnum[NUM_THREADS];
     pthread_t tid[NUM_THREADS];

     run = 1;
     r = pthread_cond_init(&cond, NULL); if (r!=0) printf("cond_init: %d\n", r);
     r = pthread_mutex_init(&mutex, NULL); if (r!=0) printf("mutex_init: %d\n", r);

     pthread_attr_t attr;
     r = pthread_attr_init(&attr);
     if (r!=0) printf("attr_init: %d\n", r);

     for (i=0; i<NUM_THREADS; i++)
     {
         tnum[i] = i;
         errbits[i] = 0;
         loopcount[i] = 0;
         r = pthread_create(&(tid[i]), &attr, test_thread, &(tnum[i]));
         if (r!=0) printf("create[%d]: %d\n", i, r);
     }

     sleep(1);

     run = 0;
     r = pthread_cond_broadcast(&cond);
     if (r!=0) printf("cond_broadcast: %d\n", r);

     for (i=0; i<NUM_THREADS; i++)
     {
         void *rp;
         r = pthread_join(tid[i], &rp);
         if (r!=0) printf("join[%d]: %d\n", i, r);
     }

     for (i=0; i<NUM_THREADS; i++)
     {
         printf("%d %dx 0x%04X\n", i, loopcount[i], errbits[i]);
     }

     return r;
}




Kolja

