Message-ID: <51372B12.2030400@mitrol.it>
Date: Wed, 06 Mar 2013 12:40:02 +0100
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Sporadic problem : rt_task_sleep locked after debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi to all.
I'm Paolo Minazzi and we use a port of xenomai on our arm Marvel mv78100 
board.
We use kernel 2.6.31.8 and xenomai 2.5.6.
All works well.
We have developed an application that use the xenomai features.
We can debug it with gdb, native or gdb client/server ver 6.8a.

I have tried also other gdb version, also the new 7.5.1.

Sometimes *** during debugging ***  we can generate a very strange problem.
When the realtime tasks execute the rt_task_sleep(), the rt_task_sleep() 
does not return anymore !
When we enter in this strange condition, the system is usable, linux 
works normally, but the realtime features do not works.

The problem is not easily reproducible.
I have tried in a lot of way to write a simple program for generating 
the problem, but I am not able to do it.

When I can reach the bug conditionm, If I run a simple xenomai test 
program with
- 20 realtime tasks
- 1 irq external line (generated every 2ms from a Fujitsu microcontroller)

     #include <...>

     #define N 20

     void tsk(void *arg)
     {
         struct data_task_struct *p = arg;
         while (1)
         {
             rt_task_sleep(p->delay);
             cnt++;
         }
     }

     int main(int argc, char* argv[])
     {
         mlockall(MCL_CURRENT|MCL_FUTURE);

         rt_timer_set_mode ( 0 );
         rt_task_set_mode(0, 0, NULL);

         MapRegistersARM();

         InitIrq();
         enable_irq_fujitsu();

         for (i=0; i<N; i++)
         {
             char s[1024];
             sprintf(s,"demo%d",i);
             data_task[i].cnt = 0;
             data_task[i].delay = 1000000 * (1+i);
             rt_task_create(&data_task[i].tsk, s, 0, i, T_JOINABLE);
             rt_task_start(&data_task[i].tsk, &tsk, &data_task[i]);
         }

         while(1)
         {
             int i;
             printf("[ %4d ]    ",cnt2ms);
             for (i=0; i<N; i++)
                 printf("%3d ",data_task[i].cnt);
             usleep(10000);
             printf("\n");
         }
     }

I can get the following information :

[========================= cat /proc/xenomai/sched 
==============================]
     CPU  PID    CLASS  PRI      TIMEOUT     TIMEBASE   STAT       NAME
       0  0      idle    -1      -           master     R          ROOT
       0  2746   rt     257      -           master     W          Irq2ms
       0  2747   rt       0      159ms591us  master     D          demo0
       0  2748   rt       1      160ms689us  master     D          demo1
       0  2749   rt       2      162ms19us   master     D          demo2
       0  2750   rt       3      163ms350us  master     D          demo3
       0  2751   rt       4      164ms685us  master     D          demo4
       0  2752   rt       5      166ms33us   master     D          demo5
       0  2753   rt       6      167ms359us  master     D          demo6
       0  2754   rt       7      168ms691us  master     D          demo7
       0  2755   rt       8      170ms17us   master     D          demo8
       0  2756   rt       9      171ms341us  master     D          demo9
       0  2757   rt      10      172ms670us  master     D          demo10
       0  2758   rt      11      174ms14us   master     D          demo11
       0  2759   rt      12      175ms347us  master     D          demo12
       0  2760   rt      13      176ms673us  master     D          demo13
       0  2761   rt      14      178ms5us    master     D          demo14
       0  2762   rt      15      179ms332us  master     D          demo15
       0  2763   rt      16      180ms664us  master     D          demo16
       0  2764   rt      17      182ms12us   master     D          demo17
       0  2765   rt      18      183ms338us  master     D          demo18
       0  2766   rt      19      184ms664us  master     D          demo19

     The TIMEOUT values runs correctly.



[========================= cat /proc/xenomai/stat 
==============================]
     CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
       0  0      0          976221     0     00500080   99.9  ROOT
       0  2746   0          68477      0     00300182    0.0  Irq2ms
       0  2747   0          1          0     00300184    0.0  demo0
       0  2748   0          1          0     00300184    0.0  demo1
       0  2749   0          1          0     00300184    0.0  demo2
       0  2750   0          1          0     00300184    0.0  demo3
       0  2751   0          1          0     00300184    0.0  demo4
       0  2752   0          1          0     00300184    0.0  demo5
       0  2753   0          1          0     00300184    0.0  demo6
       0  2754   0          1          0     00300184    0.0  demo7
       0  2755   0          1          0     00300184    0.0  demo8
       0  2756   0          1          0     00300184    0.0  demo9
       0  2757   0          1          0     00300184    0.0  demo10
       0  2758   0          1          0     00300184    0.0  demo11
       0  2759   0          1          0     00300184    0.0  demo12
       0  2760   0          1          0     00300184    0.0  demo13
       0  2761   0          1          0     00300184    0.0  demo14
       0  2762   0          1          0     00300184    0.0  demo15
       0  2763   0          1          0     00300184    0.0  demo16
       0  2764   0          1          0     00300184    0.0  demo17
       0  2765   0          1          0     00300184    0.0  demo18
       0  2766   0          1          0     00300184    0.0  demo19
       0  0      0          2551886    0     00000000    0.0  IRQ8: [timer]
       0  0      0          0          0     00000000    0.0  IRQ44: 
rtdm_eth
       0  0      0          68477      0     00000000    0.0  IRQ58: 
IntFujitsu

     The values in in the CSW column (ROOT, Irq2ms, IRQ8, IRQ58) runs 
correctly.



[========================= cat /proc/xenomai/irq 
==============================]
     IRQ         CPU0
       8:     2584003         [timer]
      44:           0         rtdm_eth
      58:      993694         IntFujitsu
      98:      404350         [virtual]

     The values [timer] and IntFujitsu in the CPU0 columns runs correctly.



[========================= cat /proc/xenomai/timer 
==============================]
     
status=on:setup=455:clock=1863202575863:timerdev=orion_tick:clockdev=orion_clocksource

     The value clock run correctly.



[========================= cat /proc/xenomai/hal 
==============================]
     1.16-02



[========================= date ==============================]
     The date program works correclty.



[========================= cat /proc/xenomai/latency 
==============================]
     4300




[========================= cat /proc/xenomai/timebases 
==============================]
     NAME       RESOLUTION     JIFFIES   STATUS
     master              1         n/a   enabled,set



[========================= cat /proc/xenomai/heap 
==============================]
     size=126976:used=16:pagesz=4096  (global sem heap)
     size=4161536:used=43552:pagesz=512  (main heap)
     size=129536:used=0:pagesz=512  (stack pool)
     size=8192:used=0:pagesz=4096  (private sem heap [2745])




I can generate the problem only debugging with gdb, otherwise there is 
no problem.

Can you help me to undertand what happen ?
Have you got an idea ? do you need other information ?

Thanks for your time.

Paolo Minazzi


