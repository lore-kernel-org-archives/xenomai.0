Date: Thu, 28 Nov 2013 14:31:52 +0100
From: Bukuli Norbert <norbert.bukuli@mediso.hu>
Message-ID: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] test suite programs crash with Illegal instruction on
	MPC5200
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello!

I am having a little problem with some programs from the Xenomai test
suite. The clocktest, cyclictest and switchtest crashes with "Illegal
instruction":

~ # /usr/xenomai/bin/clocktest 
== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  0.0            0.000          0            0.0
Illegal instruction


When I turn the debug.exception-trace kernel option on,
and run the clocktest, I have got the following kernel message:

clocktest[243]: unhandled signal 4 at 0fdf4e74 nip 0fdf4e74 lr 0ffd8af8
code 30001

I have read in a previous messages on this list, that the
CONFIG_XENO_HW_UNLOCKED_SWITCH option should be turned off, but
unfortunately this did not help.

I am using the following versions:
Linux kernel: 3.8.13
Xenomai: 2.6.3
Toolchain: ELDK-5.4

Significant kernel options:
$ cat .config | egrep '_XENO_|_IPIPE_' | grep -v ^\#
CONFIG_XENO_GENERIC_STACKPOOL=y
CONFIG_XENO_FASTSYNCH=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_MAP=y
CONFIG_XENO_OPT_VFILE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=256
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=128
CONFIG_XENO_OPT_SEM_HEAPSZ=12
CONFIG_XENO_OPT_GLOBAL_SEM_HEAPSZ=12
CONFIG_XENO_OPT_STATS=y
CONFIG_XENO_OPT_SHIRQ=y
CONFIG_XENO_OPT_SELECT=y
CONFIG_XENO_OPT_HOSTRT=y
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMING_VIRTICK=1000
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
CONFIG_XENO_OPT_TIMER_LIST=y
CONFIG_XENO_HW_FPU=y
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
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_OPT_POSIX_PERIOD=0
CONFIG_XENO_OPT_POSIX_SHM=y
CONFIG_XENO_OPT_POSIX_SELECT=y
CONFIG_XENO_OPT_DEBUG_POSIX=y
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128
CONFIG_XENO_OPT_RTDM_SELECT=y
CONFIG_XENO_DRIVERS_CAN=m
CONFIG_XENO_DRIVERS_CAN_DEBUG=y
CONFIG_XENO_DRIVERS_CAN_LOOPBACK=y
CONFIG_XENO_DRIVERS_CAN_RXBUF_SIZE=1024
CONFIG_XENO_DRIVERS_CAN_MAX_DEVICES=4
CONFIG_XENO_DRIVERS_CAN_MAX_RECEIVERS=16
CONFIG_XENO_DRIVERS_CAN_VIRT=m
CONFIG_XENO_DRIVERS_CAN_MSCAN=m
CONFIG_XENO_DRIVERS_RTIPC=m
CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
CONFIG_XENO_DRIVERS_RTIPC_IDDP=y
CONFIG_XENO_OPT_IDDP_NRPORT=32
CONFIG_XENO_DRIVERS_RTIPC_BUFP=y
CONFIG_XENO_OPT_BUFP_NRPORT=32
CONFIG_IPIPE_LEGACY=y
CONFIG_IPIPE_CORE=y
CONFIG_IPIPE_CORE_APIREV=2
CONFIG_IPIPE_WANT_APIREV_2=y
CONFIG_IPIPE_TARGET_APIREV=2
CONFIG_IPIPE_HAVE_HOSTRT=y
CONFIG_IPIPE_DELAYED_ATOMICSW=y
CONFIG_IPIPE_HAVE_PREEMPTIBLE_SWITCH=y

Am I using something wrong? Any suggestion would be highly appreciated!

Thank you in advance!

-- 
Norbert Bukuli
software engineer
embedded development

Mediso Ltd.
Tel.: +36 1 3993 030 Fax.: +36 1 3993 040
Mailing address: Hungary, H-1047 Budapest, Baross utca 91-95.
Billing address: Hungary, H-1022 Budapest, Alsotorokvesz 14.
norbert.bukuli@mediso.com
www.mediso.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131128/1f6360dd/attachment.sig>
