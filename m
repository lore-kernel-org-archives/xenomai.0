From: Registrierungen <regist@bmwedler.de>
Message-ID: <565C2BAD.2040909@bmwedler.de>
Date: Mon, 30 Nov 2015 11:57:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Alchemy periodic task and timer overruns
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

i've got a problem using the periodic tasks.
I am using the alchemy tasks running 10kHz and i get a lot of  (up ~ 
10)  timer overruns / sek calling rt_task_wait_period. (each overrung 
has an amount of 1 ).

I extracted the task to a test program. In this example he is doing 
nothing between the rt_task_wait_period calls.
Ironically i get more (up ~ 100) timer overruns / sek calling 
rt_task_wait_period.

I am running a AMD-G Series, x86_64 with SMP.
I tested on xenomai 3rc2 and xenomai 3.0.1 (with optimized kernel, 
following the documentation) with same results.

Any idea, what is going wrong?
How can i find out where is the problem?

--Source--
using namespace std;

#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <bitset>
#include <sys/io.h>

#include <task.h>

#define Timing_10000Hz 100000
#define Timing_1000Hz 1000000
#define Timing_100Hz 10000000
#define Timing_10Hz    100000000
#define Timing_1Hz 1000000000

void TestTaskDispatcher(void *arg) {
     unsigned long No;
     rt_task_set_periodic(NULL, TM_NOW, Timing_10000Hz);
     while (1)
       {
       int err = rt_task_wait_period(&No);
       if (err)
           rt_printf("Error on rt_task_wait_period %d %s %d\n",err, 
strerror(-err), No);

       rt_task_wait_period(NULL);
       }
}

int main(int argc, char *argv[])
{
     RT_TASK TestTask;
     cpu_set_t aCPU;
     CPU_ZERO(&aCPU);
     CPU_SET(0, &aCPU);
     rt_task_create(&TestTask,"TestTask",0,99,0);
     rt_task_set_affinity(&TestTask,&aCPU);
     rt_task_start(&TestTask, &TestTaskDispatcher, 0);
     pause();

}


-- Makefile--
prefix := $(shell xeno-config --prefix)
ifeq ($(prefix),)
$(error Please add <xeno-install-path>/bin to your PATH variable)
  FLAGS=-ggdb -Wall -O2  -lpthread -I/usr/xenomai/include 
-L/usr/xenomai/lib -lnative  -Xlinker -rpath -Xlinker /usr/xenomai/lib 
-lmuparser -L/usr/local/lib -I/usr/include/libxml2
  CC = g++
else
   CFLAGS := $(shell xeno-config --skin alchemy --cflags)
   LDFLAGS :=  $(shell xeno-config --skin alchemy --ldflags)

   FLAGS :=  $(CFLAGS) $(LDFLAGS) -O2  -ggdb
   CC := g++
endif

all: rtprocess

rtprocess: rtprocess.cpp $(MODS) $(GLOBS)
     $(CC) -o /Entwicklung/Runtime/rttest rttest.cpp   $(FLAGS)

------

regards,

   Sascha



