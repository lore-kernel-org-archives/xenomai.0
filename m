From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Sat, 10 Jun 2017 19:34:22 +0000
Message-ID: <DB6PR0701MB24569CBFFA2BDB4E246360C8B5CF0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] rt_taks_bind() returns -EAGAIN for existing task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
Xenomai 3.0.5 here on kernel 4.4.68-ti-xenomai-r106 on a AM3358 (BeagleBone=
 Black).

If I create a task with `rt_task_create()`, I can then successfully bind to=
 it using its descriptive name from within the same process that started it=
, e.g.:

rt_task_create(&task, task_name, 0, 40, T_JOINABLE);
rt_task_bind(&task, task_name, TM_NONBLOCK); //this returns 0: success

But, if while this program is running (and I can see the task's stats in /p=
roc/xenomai/sched/stat ), I start another program which tries to rt_task_bi=
nd() to the same task, the latter's call fails with `Resource temporarily u=
navailable(-11).`

Note that I run both programs with --enable-shared and I tried both with --=
skin=3Dnative and --skin=3Dalchemy.

Here is an example of my code: https://github.com/giuliomoro/xenomai-mode-s=
witch-detector

This program checks if a task with a given name exists. If it does exist, i=
t returns the number of modes switches in that task. If it does not exist, =
then it creates and runs the task.

I run the program once, wait for it to display "Run" (so I know the created=
 task is active), then while I leave that running, I run another instance o=
f the program in another terminal. I would expect the second one to success=
fully bind to the first one, but that is not the case (i.e.: this second in=
stance also creates another task with the same name). I can see both runnin=
g tasks in /proc/xenomai/sched/stat
In both programs, the first call to rt_task_bind() fails with "Resource tem=
porarily unavailable(-11)."

A side note: it seems that calling `rt_task_bind()` causes a switch to seco=
ndary mode, as I see the MSW counter increasing for every call to it.

Thanks,
Giulio

Configuration dumps follow:

Output of the --dump-config:

./mode_switches_detector --dump-config
based on Xenomai/cobalt v3.0.5 -- #48b2e57e2 (2017-05-30 09:03:41 +0200)
CONFIG_MMU=3D1
CONFIG_SMP=3D1
CONFIG_XENO_BUILD_ARGS=3D" '--disable-dependency-tracking' '--with-core=3Dc=
obalt' '--enable-pshared' '--host=3Darm-linux-gnueabihf' '--build=3Darm' 'C=
FLAGS=3D-no-pie -fno-pie -march=3Darmv7-a -mfpu=3Dvfp3' 'LDFLAGS=3D-no-pie =
-fno-pie -march=3Darmv7-a -mfpu=3Dvfp3' '--enable-smp' 'build_alias=3Darm' =
'host_alias=3Darm-linux-gnueabihf'"
CONFIG_XENO_BUILD_STRING=3D"arm-unknown-none"
CONFIG_XENO_COBALT=3D1
CONFIG_XENO_COMPILER=3D"gcc version 6.3.0 20170516 (Debian 6.3.0-18) "
CONFIG_XENO_DEFAULT_PERIOD=3D1000000
CONFIG_XENO_FORTIFY=3D1
CONFIG_XENO_HOST_STRING=3D"arm-unknown-linux-gnueabihf"
CONFIG_XENO_LORES_CLOCK_DISABLED=3D1
CONFIG_XENO_PREFIX=3D"/usr/xenomai"
CONFIG_XENO_PSHARED=3D1
CONFIG_XENO_RAW_CLOCK_ENABLED=3D1
CONFIG_XENO_REVISION_LEVEL=3D5
CONFIG_XENO_SANITY=3D1
CONFIG_XENO_TLSF=3D1
CONFIG_XENO_TLS_MODEL=3D"initial-exec"
CONFIG_XENO_UAPI_LEVEL=3D14
CONFIG_XENO_VERSION_MAJOR=3D3
CONFIG_XENO_VERSION_MINOR=3D0
CONFIG_XENO_VERSION_NAME=3D"Sisyphus's Boulder"
CONFIG_XENO_VERSION_STRING=3D"3.0.5"
---
CONFIG_XENO_ASYNC_CANCEL is OFF
CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED is OFF
CONFIG_XENO_DEBUG is OFF
CONFIG_XENO_DEBUG_FULL is OFF
CONFIG_XENO_LIBS_DLOPEN is OFF
CONFIG_XENO_MERCURY is OFF
CONFIG_XENO_REGISTRY is OFF
CONFIG_XENO_REGISTRY_ROOT is OFF
CONFIG_XENO_VALGRIND_API is OFF
CONFIG_XENO_WORKAROUND_CONDVAR_PI is OFF
CONFIG_XENO_X86_VSYSCALL is OFF
---
PTHREAD_STACK_DEFAULT=3D65536
AUTOMATIC_BOOTSTRAP=3D1


Dump of Kernel flags:

$ grep XENO_ /boot/config-4.4.68-ti-xenomai-r106
# CONFIG_XENO_OPT_SCHED_CLASSES is not set
CONFIG_XENO_OPT_STATS=3Dy
# CONFIG_XENO_OPT_SHIRQ is not set
CONFIG_XENO_OPT_RR_QUANTUM=3D1000
CONFIG_XENO_OPT_AUTOTUNE=3Dy
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=3Dy
# CONFIG_XENO_OPT_TIMER_RBTREE is not set
CONFIG_XENO_OPT_HOSTRT=3Dy
CONFIG_XENO_OPT_PIPE=3Dy
CONFIG_XENO_OPT_MAP=3Dy
CONFIG_XENO_OPT_VFILE=3Dy
CONFIG_XENO_OPT_PIPE_NRDEV=3D32
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512
CONFIG_XENO_OPT_SYS_HEAPSZ=3D512
CONFIG_XENO_OPT_PRIVATE_HEAPSZ=3D64
CONFIG_XENO_OPT_SHARED_HEAPSZ=3D64
CONFIG_XENO_OPT_NRTIMERS=3D128
CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0
CONFIG_XENO_OPT_TIMING_KSCHEDLAT=3D0
CONFIG_XENO_OPT_TIMING_IRQLAT=3D0
# CONFIG_XENO_OPT_DEBUG is not set
CONFIG_XENO_OPT_RTDM_COMPAT_DEVNODE=3Dy
CONFIG_XENO_DRIVERS_AUTOTUNE=3Dy
CONFIG_XENO_DRIVERS_16550A=3Dm
# CONFIG_XENO_DRIVERS_16550A_PIO is not set
# CONFIG_XENO_DRIVERS_16550A_MMIO is not set
CONFIG_XENO_DRIVERS_16550A_ANY=3Dy
CONFIG_XENO_DRIVERS_TIMERBENCH=3Dy
CONFIG_XENO_DRIVERS_SWITCHTEST=3Dy
# CONFIG_XENO_DRIVERS_RTDMTEST is not set
# CONFIG_XENO_DRIVERS_CAN is not set
# CONFIG_XENO_DRIVERS_NET is not set
# CONFIG_XENO_DRIVERS_ANALOGY is not set
CONFIG_XENO_DRIVERS_RTIPC=3Dy
CONFIG_XENO_DRIVERS_RTIPC_XDDP=3Dy
CONFIG_XENO_DRIVERS_RTIPC_IDDP=3Dy
CONFIG_XENO_OPT_IDDP_NRPORT=3D32
CONFIG_XENO_DRIVERS_RTIPC_BUFP=3Dy
CONFIG_XENO_OPT_BUFP_NRPORT=3D32
CONFIG_XENO_DRIVERS_UDD=3Dm
CONFIG_XENO_DRIVERS_GPIO=3Dm
# CONFIG_XENO_DRIVERS_GPIO_DEBUG is not set
CONFIG_XENO_ARCH_UNLOCKED_SWITCH=3Dy
CONFIG_XENO_ARCH_WANT_TIP=3Dy
CONFIG_XENO_ARCH_FPU=3Dy
# CONFIG_XENO_ARCH_SYS3264 is not set
CONFIG_XENO_ARCH_OUTOFLINE_XNLOCK=3Dy
CONFIG_XENO_VERSION_MAJOR=3D3
CONFIG_XENO_VERSION_MINOR=3D0
CONFIG_XENO_REVISION_LEVEL=3D5
CONFIG_XENO_VERSION_STRING=3D"3.0.5"
CONFIG_XENO_VERSION_NAME=3D"Sisyphus's Boulder"=

