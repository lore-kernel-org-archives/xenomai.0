Message-ID: <502BB311.6000303@ifak.eu>
Date: Wed, 15 Aug 2012 16:32:49 +0200
From: Marco Meier <marco.meier@ifak.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE
	disabled.
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

i tried to install xenomai-2.6.1 with a linux-3.2.21 kernel. patching
and installing the kernel was successful according to the following
dmesg output:

[    1.704456] I-pipe: head domain Xenomai registered.
[    1.704499] Xenomai: hal/x86_64 started.
[    1.704517] Xenomai: scheduling class idle registered.
[    1.704519] Xenomai: scheduling class rt registered.
[    1.706145] Xenomai: real-time nucleus v2.6.1 (Light Years Away) loaded.
[    1.706147] Xenomai: debug mode enabled.
[    1.706319] Xenomai: starting native API services.
[    1.706322] Xenomai: starting POSIX services.
[    1.706356] Xenomai: starting RTDM services.

i cross compiled the userspace tools with
./configure --enable-x86-sep --host=i686-linux --enable-smp
CFLAGS='-m32 -O2' LDFLAGS='-m32'

after installing the tools on the target machine, i tried to link a
simple test program which actually does nothing against the xenomai libs

gcc $(xeno-config --skin native --cflags ) $(xeno-config --skin native
--ldflags) -Wl,-rpath=/usr/xenomai/lib test.c

running ./a.out gives the following output:
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)

xeno_native is built into the kernel:

zcat /proc/config.gz  | grep XENO_SKIN
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_SKIN_POSIX=y

as well as CONFIG_XENO_OPT_PERVASIVE:

zcat /proc/config.gz  | grep XENO_OPT_PERVASIVE CONFIG_XENO_OPT_PERVASIVE=y

what am i missing?

Thanks,

M. Meier

