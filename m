Message-ID: <4AEA590E.9070701@domain.hid>
Date: Thu, 29 Oct 2009 22:10:06 -0500
From: Jeff Weber <jweber@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] unable to load nucleus module: unknown symbol
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

I've built the xeno_nucleus as a module.  Neither depmod, nor modprobe
can resolve the symbol "find_task_by_pid_ns":

depmod:
WARNING:
/lib/modules/2.6.31.5-xenomai-2.4.10/kernel/kernel/xenomai/nucleus/xeno_nuc=
leus.ko
needs unknown symbol find_task_by_pid_ns

modprobe [dmesg]:
[  426.728630] xeno_nucleus: Unknown symbol find_task_by_pid_ns

Curiously, this symbol is in both my build System.map, and the kernel

bash # grep find_task_by_pid_ns System.map
c102ecf6 T find_task_by_pid_ns

bash # cat /proc/kallsyms | grep find_task_by_pid_ns
c102ecf6 T find_task_by_pid_ns

so this symbol should be publicly available.  I also noticed there is no
EXPORT_SYMBOL() for find_task_by_pid_ns in the kernel code.

Any ideas what's keeping my xeno_nucleus.ko module from loading?

My config:
linux-2.6.31.5 (current stable)
xenomai-2.4.10
adeos-ipipe-2.6.31.1-x86-2.4-06.patch

thanks,
Jeff
=93This e-mail message and any attachments are confidential and may be priv=
ileged.=20
If you are not the intended recipient please notify American Superconductor=
 Corporation=20
immediately by replying to this message or by sending a message to postmast=
er@domain.hid
and destroy all copies of this message and any attachments.=20
Thank you.=94


