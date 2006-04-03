Date: Mon, 3 Apr 2006 11:17:03 +0200
From: Jens Niehaus <niehaus@domain.hid>
Message-ID: <20060403111703.593b2b15@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Problem with posix skin and Xenomai 2.1.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I am experiencing problems with xenomai 2.1.0 and pthread_mutex_init. The second initialization in the following program returns with a value of 16 (EBUSY). What is wrong with the code (or with xenomai)?

Thanks in advance,
	Jens


---------------------------------------
#include <pthread.h>
#include <stdio.h>

int main( int argc, char *argv[] )
{
	pthread_mutex_t m1;
	pthread_mutex_t m2;
	int ret;

	if ( (ret = pthread_mutex_init( &m1, NULL ) ) )
	{
		printf("First init failed, ret=%i\n", ret );
		return ret;
	}
	/* sleep(1); */
	if ( ( ret = pthread_mutex_init( &m2, NULL ) ) )
	{
		printf("Second init failed, ret=%i\n", ret );
		return ret;
	}
	printf("Done\n");
	return 0;
}
--------------------------------------

I am using xenomai 2.1.0 and kernel 2.6.15.7 compiled with gcc 3.3.5 (SuSE 9.3).

The program does work
- when using xenomai 2.1-rc2
- when compiling without xenomai
- when sleep(1) is inserted between the calls to pthread_mutex_init

The program does not work
- when using kernel 2.6.14.6
- with mutex initialization after pthread_setschedparam( pthread_self(), SCHED_FIFO, ... );
- with mutex initialization in a newly created, SCHED_FIFO enabled thread
- when using pthread_mutexattr_t structures for initialization
- on different processors: Athlon 64 2800+ (build system) and VIA Samuel 2 533Mhz (target system)


Here is some more information, which might be helpful:

root: cat /proc/cmdline
auto BOOT_IMAGE=xenomai rw root=100 init=/linuxrc ramdisk_size=8196 noapic noacpi noapm

root: grep /configure /usr/src/xenomai-build/config.log
  $ ../xenomai-2.1.0/configure --enable-x86-tsc --enable-debug

root: zcat /proc/config.gz|grep XENO |grep -v "not set"
CONFIG_XENOMAI=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=128
CONFIG_XENO_OPT_STATS=y
CONFIG_XENO_OPT_DEBUG=y
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMING_PERIOD=0
CONFIG_XENO_OPT_TIMING_TIMERLAT=0
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
CONFIG_XENO_OPT_TIMER_LIST=y
CONFIG_XENO_HW_FPU=y
CONFIG_XENO_HW_SMI_DETECT=y
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_SKIN_RTDM=y

Compilation:
gcc -g $(shell xeno-config --posix-cflags) mutextst.c $(shell xeno-config --posix-ldflags) -o mutextstxeno
gcc -g mutextst.c -lpthread -o mutextst

