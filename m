From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Mon, 15 May 2017 10:04:47 +0000
Message-ID: <DB6PR0701MB2456788DAE300E14759F9646B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] rt_task_bind returns -EINVAL when not using --enable-smp
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
I have a 4.4.61 kernel with Xenomai 3.0.4 on am335x (BeagleBone Black) comp=
iled with=20

CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
CONFIG_HAVE_SMP=3Dy
# CONFIG_SMP is not set
(see XENO flags at the bottom of the email)

When I compile the user-space support with
    /root/xenomai/configure --with-core=3Dcobalt --enable-smp --enable-psha=
red
my program (which uses the Alchemy API) works fine

But when I do it with
    /root/xenomai/configure --with-core=3Dcobalt --enable-pshared
, then calls to rt_task_bind or rt_task_create return -EINVAL.

Given that SMP is not enabled in the kernel, I would expect the latter to b=
e the correct one and possibly the former to fail.

Note that /usr/xenomai/bin/xeno-test and /usr/xenomai/bin/latency work ok i=
n both cases.

Here are the XENO kernel flags
CONFIG_XENOMAI=3Dy
CONFIG_XENO_OPT_STATS=3Dy
CONFIG_XENO_OPT_RR_QUANTUM=3D1000
CONFIG_XENO_OPT_AUTOTUNE=3Dy
CONFIG_XENO_OPT_TIMER_LIST=3Dy
CONFIG_XENO_OPT_HOSTRT=3Dy
CONFIG_XENO_OPT_VFILE=3Dy
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512
CONFIG_XENO_OPT_SYS_HEAPSZ=3D512
CONFIG_XENO_OPT_PRIVATE_HEAPSZ=3D64
CONFIG_XENO_OPT_SHARED_HEAPSZ=3D64
CONFIG_XENO_OPT_NRTIMERS=3D128
CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0
CONFIG_XENO_OPT_TIMING_KSCHEDLAT=3D0
CONFIG_XENO_OPT_TIMING_IRQLAT=3D0
CONFIG_XENO_OPT_RTDM_COMPAT_DEVNODE=3Dy
CONFIG_XENO_DRIVERS_AUTOTUNE=3Dy
CONFIG_XENO_DRIVERS_TIMERBENCH=3Dy
CONFIG_XENO_DRIVERS_SWITCHTEST=3Dy
CONFIG_XENO_ARCH_UNLOCKED_SWITCH=3Dy
CONFIG_XENO_ARCH_WANT_TIP=3Dy
CONFIG_XENO_ARCH_FPU=3Dy
CONFIG_XENO_ARCH_OUTOFLINE_XNLOCK=3Dy
CONFIG_XENO_VERSION_MAJOR=3D3
CONFIG_XENO_VERSION_MINOR=3D0
CONFIG_XENO_REVISION_LEVEL=3D4
CONFIG_XENO_VERSION_STRING=3D"3.0.4"
CONFIG_XENO_VERSION_NAME=3D"Washed Out Harlequin"

Thanks,
Giulio

