MIME-Version: 1.0
From: Nicolas SCHURANDO <schurann@ext.essilor.com>
Date: Thu, 14 Jan 2016 10:22:44 +0100
Message-ID: <CA+CJOCxoqmA1r0sGb_LwqvsXPzMG485YqUmR83hsfT2mTD6xnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] VxWorks API on Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone,

In an attempt to migrate from Xenomai 2.6.4 on a Raspberry Pi 1 to Xenomai
3.0.1 on a Raspberry Pi 2, I get an error when trying to spawn a VxWorks
task in a fairly simple test program. Here is the output :

   0"000.064| WARNING: [main] Xenomai compiled with full debug enabled,
>                               very high latencies expected
> [--enable-debug=full]
>  [i] [main] Hello, launching root task ...
>  200"747.521| BUG in wind_task_normalize_priority():


The corresponding code is :

int main(int argc, char *argv[]) {


> /* Hello world */
> printf(" [i] [%s] Hello, launching root task ...\r\n", __FUNCTION__);


> /* Spawn root task */
> taskSpawn("root_task", 100, 0, 16 * 1024, (FUNCPTR) &root_task, 0, 0, 0,
> 0, 0, 0, 0, 0, 0, 0);


> [...]


> }


I've tracked down the problem to threadobj_high_prio being equal to 0,
hence the following function expecting priorities from -1 to 0. I however
have no idea where threadobj_high_prio gets its value from.

__weak int wind_task_normalize_priority(int wind_prio)
> {
> /*
> * SCHED_FIFO priorities are always 1-based regardless of the
> * underlying real-time core. We remap the lowest VxWorks
> * priority to the lowest available level in the SCHED_FIFO
> * policy.
> */
> if (wind_prio > threadobj_high_prio - 1)
> panic("current implementation restricts VxWorks "
>      "priority levels to range [%d..0]",
>      threadobj_high_prio - 1);



/* Map a VxWorks priority level to a SCHED_FIFO one. */
> return threadobj_high_prio - wind_prio - 1;
> }


Here is if needed the output produced by --dump-config :

based on Xenomai/cobalt v3.0 -- #5f6b32f (2015-10-31 20:57:40 +0100)
> CONFIG_MMU=1
> CONFIG_SMP=1
> CONFIG_XENO_BUILD_ARGS=" '--with-core=cobalt' '--enable-debug=full'
> '--enable-smp' '--disable-doc-install'
> '--host=arm-bcm2708hardfp-linux-gnueabi' 'CFLAGS=-mcpu=cortex-a7
> -mfpu=neon-vfpv4 -mfloat-abi=hard' 'LDFLAGS=-mcpu=cortex-a7
> -mfpu=neon-vfpv4 -mfloat-abi=hard'
> 'host_alias=arm-bcm2708hardfp-linux-gnueabi'"
> CONFIG_XENO_BUILD_STRING="i686-pc-linux-gnu"
> CONFIG_XENO_COBALT=1
> CONFIG_XENO_COMPILER="gcc version 4.7.1 20120402 (prerelease)
> (crosstool-NG 1.15.2) "
> CONFIG_XENO_DEBUG=1
> CONFIG_XENO_DEBUG_FULL=1
> CONFIG_XENO_DEFAULT_PERIOD=1000000
> CONFIG_XENO_FORTIFY=1
> CONFIG_XENO_HOST_STRING="arm-bcm2708hardfp-linux-gnueabi"
> CONFIG_XENO_LORES_CLOCK_DISABLED=1
> CONFIG_XENO_PREFIX="/usr/xenomai"
> CONFIG_XENO_RAW_CLOCK_ENABLED=1
> CONFIG_XENO_REVISION_LEVEL=0
> CONFIG_XENO_SANITY=1
> CONFIG_XENO_TLSF=1
> CONFIG_XENO_TLS_MODEL="initial-exec"
> CONFIG_XENO_UAPI_LEVEL=14
> CONFIG_XENO_VERSION_MAJOR=3
> CONFIG_XENO_VERSION_MINOR=0
> CONFIG_XENO_VERSION_NAME="Exact Zero"
> CONFIG_XENO_VERSION_STRING="3.0"
> CONFIG_XENO_X86_VSYSCALL=1
> ---
> CONFIG_XENO_ASYNC_CANCEL is OFF
> CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
> CONFIG_XENO_LIBS_DLOPEN is OFF
> CONFIG_XENO_MERCURY is OFF
> CONFIG_XENO_PSHARED is OFF
> CONFIG_XENO_REGISTRY is OFF
> CONFIG_XENO_REGISTRY_ROOT is OFF
> CONFIG_XENO_VALGRIND_API is OFF
> CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
> ---
> PTHREAD_STACK_DEFAULT=65536


Any help would be appreciated,

Thanks,

Nicolas
