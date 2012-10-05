Message-ID: <506EE0F5.8090006@xenomai.org>
Date: Fri, 05 Oct 2012 15:30:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <506EACBD.8090307@wanadoo.fr> <506ED30E.5050002@xenomai.org>
	<506EDF54.8060009@wanadoo.fr>
In-Reply-To: <506EDF54.8060009@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] nanosleep and clock_nanosleep increase MSW counter
 without SIGXCPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 10/05/2012 03:23 PM, Thierry Bultel wrote:
> Le 05/10/2012 14:31, Gilles Chanteperdrix a écrit :
>> On 10/05/2012 11:47 AM, Thierry Bultel wrote:
>>> Hi,
>>>
>>> My config is linux-3.2.21+xenomai-2.6.1 ; ipipe-core-3.2.21-arm-1.patch,
>>> on qemu-system-arm ; versatile express. I have CONFIG_SMP to NO
>>>
>>> My test case is quite simple.
>>> The main process is as such:
>>>
>>> -----------------
>>>
>>> int main ( ......
>>>
>>>
>>> pthread_set_name_np(pthread_self(), "MAIN PROCESS");
>>>
>>> if (pthread_set_mode_np(0, PTHREAD_WARNSW) != 0)
>>> {
>>>     LOG("pthread_set_mode_np FAILED\n");
>>>     exit(0);
>>> }
>>>
>>> for (;;)
>>> {
>>>     struct timespec delay = { 10, 0 };
>>>     nanosleep(&delay,NULL);
>>> }
>>>
>>> ----------
>>>
>>> The MSW counter keeps increasing, whereas no SIGXCPU is delivered:
>>>
>>> [root@buildroot ~]# cat /proc/xenomai/stat 
>>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>>   0  0      0          1131       0     00500080   99.6  ROOT
>>>   0  717    95         189        0     00b40184    0.0  MAIN PROCESS
>>>   0  0      0          381587     0     00000000    0.4  IRQ34: [timer]
>>>
>>>
>>> The build command:
>>>
>>> arm-linux-gcc -fmessage-length=0 -pipe -Wall -Werror -g -DNOT_USE_DYNAMIC_LOADING 
>>> -I/home/tbultel/workspace/Buildroot/output/host/usr/arm-unknown-linux-gnueabi/sysroot/usr/include/xenomai 
>>> -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
>>> -I/home/tbultel/workspace/Buildroot/output/host/usr/arm-unknown-linux-gnueabi/sysroot/usr/include/xenomai/posix 
>>> -c /home/tbultel/workspace/agv/linux/simerimcan/sim_agv_can_main.c 
>>> -o /home/tbultel/workspace/agv/linux/simerimcan/build.xenomai/obj/sim_agv_can_main.o 
>>> -MMD -MF/home/tbultel/workspace/agv/linux/simerimcan/build.xenomai/obj/sim_agv_can_main.d 
>>> -I. -I/home/tbultel/workspace/Buildroot/output/host/usr/arm-unknown-linux-gnueabi/sysroot/opt/can/include/canfestival-xenomai 
>>> -I"="/usr/include/xenomai -I"="/usr/include/xenomai/posix
>>>
>>>
>>> arm-linux-gcc -lrt -lpthread -rdynamic 
>>>  -L/home/tbultel/workspace/Buildroot/output/host/usr/arm-unknown-linux-gnueabi/sysroot/usr/lib 
>>> -lxenomai -lpthread_rt 
>>> -Wl,@/home/tbultel/workspace/Buildroot/output/host/usr/arm-unknown-linux-gnueabi/sysroot/usr/lib/posix.wrappers 
>>> -o /home/tbultel/workspace/agv/../bin/arm/sim_agv_can-xenomai 
>>> /home/tbultel/workspace/agv/linux/simerimcan/build.xenomai/obj/sim_agv_can_main.o 
>>> /home/tbultel/workspace/agv/linux/simerimcan/build.xenomai/obj/sim_agv_can_bus.o 
>>> /home/tbultel/workspace/agv/linux/simerimcan/build.xenomai/obj/sim_erim_can_log.o
>> In order to know if the link process worked correctly with this funky
>> argument order, I would use arm-linux-nm -s
>>
> 
> 'arm-linux-nm -s' shows :
> 
>          U __wrap_clock_gettime
>          U __wrap_close
>          U __wrap_connect
>          U __wrap_nanosleep
>          U __wrap_printf
>          U __wrap_puts
>          U __wrap_socket
> 
> That gdb also confirms that
> 
> (gdb) r
> Starting program: /root/sim_agv_can-xenomai
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/libthread_db.so.1".
> [New Thread 0x2ac82470 (LWP 1642)]
> [SIMBUS] 03:58:32.955 MLOCKALL DONE
> [SIMBUS] 03:58:32.975 Starting Bus simulator
> [SIMBUS] 03:58:32.977 Alive
> [SIMBUS] 03:58:33.979 Alive
> ^C
> Program received signal SIGINT, Interrupt.
> 0x2ab03ee4 in __wrap_clock_nanosleep () from /usr/lib/libpthread_rt.so.1
> (gdb)
> 
> ...and my MSW still increases
> 
> What link argument order would you advise ?

object firsts, libraries next. Libraries in the "logical" order, so, if
your .o use libpthread_rt, start with libpthread_rt, since libpthread_rt
use libxenomai, libxenomai comes next, since both of them use libtphread
and librt, libpthread and librt come next, etc...

IOW, the order provided by xeno-config.

Anyway, if you did not call pthread_setschedparam in a part of code
which you did not show (which is why we usually ask for a self-contained
test case, with full source, so that we do not have to guess what you
could have done or not), the main thread is running with SCHED_OTHER
policy, and automatically returns to secondary domain after having
switched to primary domain during nanosleep.

-- 
					    Gilles.

