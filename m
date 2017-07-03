From: =?UTF-8?B?SmnFmcOtIER1xaFlaw==?= <dusek@inova.cz>
Message-ID: <dff5d476-55b9-f609-ec06-07a3f3c88958@inova.cz>
Date: Mon, 3 Jul 2017 15:21:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] High latencies with RT memory heap on xenomai 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

We have experienced high latencies when pushing our application to the 
limits. Debugging led me to the realtime heap. Stress testing realtime 
heap has unexpected results. Stressing realtime heap from one task has 
no latency problem. Stressing realtime heap from two tasks bound to the 
same CPU has no latency problem. Stressing realtimne heap from two tasks 
bound to two distinct CPUs causes high latencies. There is nothing 
obvious like mode switches or errors.

Is this expected behavior of rt_heap_alloc/free? Can we do something to 
prevent this problem?

System: Desktop x86_64 (Intel 2500K quad core, 8GB memory, running 
Ubuntu 12.04)
Linux kernel version: 3.5.7
Xenomai version: 2.6.5
Ipipe patch: 3.5.7-x86-4

Configure flags:
#
# Real-time sub-system
#
CONFIG_XENOMAI=y
CONFIG_XENO_GENERIC_STACKPOOL=y
CONFIG_XENO_FASTSYNCH=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
# CONFIG_XENO_OPT_PRIOCPL is not set
CONFIG_XENO_OPT_PIPELINE_HEAD=y
# CONFIG_XENO_OPT_SCHED_CLASSES is not set
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_VFILE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=512
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=128
CONFIG_XENO_OPT_SEM_HEAPSZ=12
CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
CONFIG_XENO_OPT_SHIRQ=y
CONFIG_XENO_OPT_SELECT=y
CONFIG_XENO_OPT_HOSTRT=y

#
# Timing
#
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_VIRTICK=1000
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0

#
# Scalability
#
CONFIG_XENO_OPT_SCALABLE_SCHED=y
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_RBTREE is not set

#
# Machine
#
CONFIG_XENO_HW_FPU=y

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PERIOD=0
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=1024
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_BUFFER=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
# CONFIG_XENO_OPT_NATIVE_INTR is not set
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_OPT_POSIX_PERIOD=0
CONFIG_XENO_OPT_POSIX_REGISTRY_NRSLOTS=64
CONFIG_XENO_OPT_POSIX_REGISTRY_NRDESCS=128
CONFIG_XENO_OPT_POSIX_NRTIMERS=128
# CONFIG_XENO_OPT_POSIX_SHM is not set
# CONFIG_XENO_OPT_POSIX_INTR is not set
CONFIG_XENO_OPT_POSIX_SELECT=y
# CONFIG_XENO_OPT_DEBUG_POSIX is not set
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_OPT_NOWARN_DEPRECATED is not set
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128
CONFIG_XENO_OPT_RTDM_SELECT=y

cat /proc/xenomai/stat (while rt_heap test is running)
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
   0  0      0          77638423   0     00500088    0.0  ROOT/0
   1  0      0          10566633   0     00500088    0.0  ROOT/1
   2  0      0          0          0     00500080   99.1  ROOT/2
   3  0      0          0          0     00500080   99.2  ROOT/3
   0  8311   5          10         0     00b00188    0.0 display-8310
   0  8312   0          72578      0     00340184   15.3 sampling-8310
   0  8342   1          1          0     00300380    0.0  Task main
   0  8343   0          22147      0     00300180   79.6  Task0
   1  8344   0          1          0     00300180  100.0  Task1
   0  0      0          82709823   0     00000000    6.0  IRQ4368: [timer]
   1  0      0          2945123    0     00000000    0.0  IRQ4368: [timer]
   2  0      0          834376     0     00000000    0.9  IRQ4368: [timer]
   3  0      0          849927     0     00000000    0.8  IRQ4368: [timer]

/usr/xenomai/bin/latency (rt heap test was running several seconds)
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat 
best|--lat worst
RTD|     -2.221|     -2.060|      1.817|       0|     0| -2.221|      1.817
RTD|     -2.282|     -1.973|      1.840|       0|     0| -2.282|      1.840
RTD|     -2.274|     -2.058|      1.390|       0|     0| -2.282|      1.840
RTD|     -2.224|     -2.057|      1.632|       0|     0| -2.282|      1.840
RTD|     -2.313|     -1.933|      2.402|       0|     0| -2.313|      2.402
RTD|     -2.212|     75.708|    919.872|   22445|     0| -2.313|    919.872
RTD|     -2.212|     75.708|    919.872|   22445|     0| -2.313|    919.872
RTD|     -2.212|     75.708|    919.872|   22445|     0| -2.313|    919.872
RTD|     -2.212|     75.708|    919.872|   22445|     0| -2.313|    919.872
RTD|     -2.212|     75.708|    919.872|   22445|     0| -2.313|    919.872
RTD|     -2.212|     75.708|    919.872|   22445|     0| -2.313|    919.872
RTD|     -2.354|     24.889|    404.444|   23808|     0| -2.354|    919.872
RTD|     -2.234|     -2.062|     -0.697|   23808|     0| -2.354|    919.872
RTD|     -2.243|     -2.051|      1.479|   23808|     0| -2.354|    919.872
RTD|     -2.219|     -2.047|      2.302|   23808|     0| -2.354|    919.872
RTD|     -2.287|     -2.011|      1.857|   23808|     0| -2.354|    919.872

Test program:

#include <native/heap.h>
#include <native/task.h>
#include <sys/mman.h>
#include <cstdio>

const int DATA_SIZE = 400;
const int DATA_COUNT = 10000;
const int TASK_COUNT = 2;
const int TASK_PRIORITY = 1;

static void task_main(void *cookie) {
     int res;
     RT_HEAP *heap = (RT_HEAP *) cookie;

     char *testData[DATA_COUNT] = {};

     for (int k = 0; k < 100; ++k) {
         for (int i = 0; i < DATA_COUNT; ++i) {
             res = rt_heap_alloc(heap, DATA_SIZE,
                     TM_NONBLOCK, (void **) &(testData[i]));
             if (res < 0) {
                 printf("rt_heap_alloc() failed, result %d\n", res);
                 testData[i] = NULL;
             } else {
                 for (int j = 0; j < DATA_SIZE; ++j) {
                     // simulate some init of allocated memory
                     testData[i][j] = i*j*k;
                 }
             }
         }

         for (int i = DATA_COUNT - 1; i >= 0; --i) {
             if (testData[i] != NULL) {
                 res = rt_heap_free(heap, testData[i]);
                 if (res < 0) {
                     printf("rt_heap_free() failed, result %d\n", res);
                 }
                 testData[i] = NULL;
             }
         }
     }
}

int main(int argc, char** argv) {
     int res; // xenomai function result
     mlockall(MCL_CURRENT | MCL_FUTURE);

     RT_TASK mainRtTask;
     res = rt_task_shadow(&mainRtTask, "Task main",
             TASK_PRIORITY, T_CPU(0));
     if (res < 0) {
         printf("rt_task_shadow() failed, result %d\n", res);
         return 1;
     }

     RT_HEAP rtHeap;
     res = rt_heap_create(&rtHeap, "RT heap",
             2*DATA_SIZE*DATA_COUNT*TASK_COUNT, H_PRIO | H_MAPPABLE);
     if (res < 0) {
         printf("rt_heap_create() failed, result %d\n", res);
         return 2;
     }

     const char *rtTaskNames[] = {"Task0", "Task1", "Task2", "Task3"};
     RT_TASK rtTasks[TASK_COUNT];
     for (int i = 0; i < TASK_COUNT; ++i) {
         int stackSize = 2 * DATA_COUNT * sizeof(char*) + 1024;
         res = rt_task_create(&rtTasks[i], rtTaskNames[i], stackSize,
                 TASK_PRIORITY, T_JOINABLE | T_CPU(i));
         if (res < 0) {
             printf("rt_task_create() failed, result %d\n", res);
         }
     }

     for (int i = 0; i < TASK_COUNT; ++i) {
         res = rt_task_start(&rtTasks[i], task_main, &rtHeap);
         if (res < 0) {
             printf("rt_task_start() failed, result %d\n", res);
         }
     }

     for (int i = 0; i < TASK_COUNT; ++i) {
         res = rt_task_join(&rtTasks[i]);
         if (res < 0) {
             printf("rt_task_join() failed, result %d\n", res);
         }
     }

     res = rt_heap_delete(&rtHeap);
     if (res < 0) {
         printf("rt_heap_delete() failed, result %d\n", res);
     }

     return 0;
}



