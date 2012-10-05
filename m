Message-ID: <506EACBD.8090307@wanadoo.fr>
Date: Fri, 05 Oct 2012 11:47:41 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] nanosleep and clock_nanosleep increase MSW counter
	without SIGXCPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

My config is linux-3.2.21+xenomai-2.6.1 ; ipipe-core-3.2.21-arm-1.patch,
on qemu-system-arm ; versatile express. I have CONFIG_SMP to NO

My test case is quite simple.
The main process is as such:

-----------------

int main ( ......


pthread_set_name_np(pthread_self(), "MAIN PROCESS");

if (pthread_set_mode_np(0, PTHREAD_WARNSW) != 0)
{
    LOG("pthread_set_mode_np FAILED\n");
    exit(0);
}

for (;;)
{
    struct timespec delay = { 10, 0 };
    nanosleep(&delay,NULL);
}

----------

The MSW counter keeps increasing, whereas no SIGXCPU is delivered:

[root@buildroot ~]# cat /proc/xenomai/stat 
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          1131       0     00500080   99.6  ROOT
  0  717    95         189        0     00b40184    0.0  MAIN PROCESS
  0  0      0          381587     0     00000000    0.4  IRQ34: [timer]


The build command:

arm-linux-gcc -fmessage-length=0 -pipe -Wall -Werror -g -DNOT_USE_DYNAMIC_LOADING 
-I/home/tbultel/workspace/Buildroot/output/host/usr/arm-unknown-linux-gnueabi/sysroot/usr/include/xenomai 
-D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
-I/home/tbultel/workspace/Buildroot/output/host/usr/arm-unknown-linux-gnueabi/sysroot/usr/include/xenomai/posix 
-c /home/tbultel/workspace/agv/linux/simerimcan/sim_agv_can_main.c 
-o /home/tbultel/workspace/agv/linux/simerimcan/build.xenomai/obj/sim_agv_can_main.o 
-MMD -MF/home/tbultel/workspace/agv/linux/simerimcan/build.xenomai/obj/sim_agv_can_main.d 
-I. -I/home/tbultel/workspace/Buildroot/output/host/usr/arm-unknown-linux-gnueabi/sysroot/opt/can/include/canfestival-xenomai 
-I"="/usr/include/xenomai -I"="/usr/include/xenomai/posix


arm-linux-gcc -lrt -lpthread -rdynamic 
 -L/home/tbultel/workspace/Buildroot/output/host/usr/arm-unknown-linux-gnueabi/sysroot/usr/lib 
-lxenomai -lpthread_rt 
-Wl,@/home/tbultel/workspace/Buildroot/output/host/usr/arm-unknown-linux-gnueabi/sysroot/usr/lib/posix.wrappers 
-o /home/tbultel/workspace/agv/../bin/arm/sim_agv_can-xenomai 
/home/tbultel/workspace/agv/linux/simerimcan/build.xenomai/obj/sim_agv_can_main.o 
/home/tbultel/workspace/agv/linux/simerimcan/build.xenomai/obj/sim_agv_can_bus.o 
/home/tbultel/workspace/agv/linux/simerimcan/build.xenomai/obj/sim_erim_can_log.o


Thanks
Thierry

