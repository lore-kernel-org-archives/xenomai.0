Date: Fri, 2 Dec 2016 16:52:25 +0000 (UTC)
From: Giulio Moro <giuliomoro@yahoo.it>
Message-ID: <884477039.8840647.1480697545181@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <884477039.8840647.1480697545181.ref@mail.yahoo.com>
Subject: [Xenomai] FAILURE rt_thread_body:116: no SIGDEBUG_MIGRATE_PRIOINV
 received on ARM
Reply-To: Giulio Moro <giuliomoro@yahoo.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,
freshly installed Cobalt 3.0.3 on a BeagleBone Black (ARM Cortex-A8) with kernel 4.4.35 (rcn: 
https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-xenomai-4.4.y ).

When runnig xeno-test I get the below error.
Note that latency test works ok (though the values are a bit higher than expected).
Any suggestions?

root@beaglebone ~/xenomai_staging$ /usr/xenomai/bin/xeno-test
Started child 4984: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper /usr/xenomai/bin/xeno-test
++ echo 0
++ testdir=/usr/xenomai/bin
++ /usr/xenomai/bin/smokey --run
arith OK
bufp skipped (no kernel support)
cpu_affinity OK
iddp skipped (no kernel support)
^C
root@beaglebone ~/xenomai_staging$ /usr/xenomai/bin/xeno-test -k
Started child 4989: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper /usr/xenomai/bin/xeno-test -k
++ echo 0
++ testdir=/usr/xenomai/bin
++ /usr/xenomai/bin/smokey --run --keep-going
arith OK
bufp skipped (no kernel support)
cpu_affinity OK
iddp skipped (no kernel support)
leaks OK
net_packet_dgram skipped (no kernel support)
net_packet_raw skipped (no kernel support)
net_udp skipped (no kernel support)
posix_clock OK
posix_cond OK
posix_fork OK
mutex_trylock not supported
posix_mutex OK
posix_select OK
rtdm skipped (no kernel support)
sched_quota skipped (no kernel support)
sched_tp skipped (no kernel support)
FAILURE rt_thread_body:116: no SIGDEBUG_MIGRATE_PRIOINV received



Full Kernel config file is available here http://pastebin.com/raw/XwqZpE5t
XENOMAI configs only:
CONFIG_XENOMAI=y
CONFIG_XENO_OPT_STATS=y
CONFIG_XENO_OPT_RR_QUANTUM=1000
CONFIG_XENO_OPT_AUTOTUNE=y
CONFIG_XENO_OPT_TIMER_LIST=y
CONFIG_XENO_OPT_HOSTRT=y
CONFIG_XENO_OPT_VFILE=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=512
CONFIG_XENO_OPT_PRIVATE_HEAPSZ=64
CONFIG_XENO_OPT_SHARED_HEAPSZ=64
CONFIG_XENO_OPT_NRTIMERS=128
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
CONFIG_XENO_OPT_TIMING_KSCHEDLAT=0
CONFIG_XENO_OPT_TIMING_IRQLAT=0
CONFIG_XENO_OPT_DEBUG=y
CONFIG_XENO_OPT_DEBUG_LOCKING=y
CONFIG_XENO_OPT_WATCHDOG=y
CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=4
CONFIG_XENO_OPT_RTDM_COMPAT_DEVNODE=y
CONFIG_XENO_DRIVERS_AUTOTUNE=y
CONFIG_XENO_DRIVERS_16550A=y
CONFIG_XENO_DRIVERS_16550A_ANY=y
CONFIG_XENO_DRIVERS_TIMERBENCH=y
CONFIG_XENO_DRIVERS_SWITCHTEST=y
CONFIG_XENO_ARCH_UNLOCKED_SWITCH=y
CONFIG_XENO_ARCH_WANT_TIP=y
CONFIG_XENO_ARCH_FPU=y
CONFIG_XENO_ARCH_OUTOFLINE_XNLOCK=y
CONFIG_XENO_VERSION_MAJOR=3
CONFIG_XENO_VERSION_MINOR=0
CONFIG_XENO_REVISION_LEVEL=3
CONFIG_XENO_VERSION_STRING="3.0.3"
CONFIG_XENO_VERSION_NAME="Groovy Cosmic Halo"

