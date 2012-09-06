Message-ID: <50483A49.5090100@ebus.com>
Date: Wed, 05 Sep 2012 22:53:13 -0700
From: Doug Brunner <dbrunner@ebus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] Queue corruption from XDDP in Xenomai 2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

It looks like the bug I wrote about back in June still exists in Xenomai =

2.6.1 (with Linux 3.2.21). I ran the same test case (an RT thread opens =

an XDDP socket, then a Linux thread opens its end of the pipe, then the =

RT thread stops, then with the Linux thread still holding its end of the =

pipe another RT thread tries to open an XDDP socket with the same minor =

number). With Xenomai queue and I-pipe debugging enabled, I got a report =

of a corrupted queue. I've attached my config, test case, and serial =

console log.

So far I haven't found anything in the XDDP or underlying xnpipe_* code =

that would suggest why this is happening. However something is =

definitely going wrong, since xnpipe_minor_free should not be called =

until my Linux task closes its end of the pipe, so the call by the =

second RT thread to open the pipe should fail with -EBUSY. Any thoughts =

on why this might be happening?

-- =

     Doug Brunner

-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-3.2.21-ipipe-small-2-ipd.gz
Type: application/x-gzip
Size: 13798 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120905/caa35f0=
2/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: xddp-trycrash.c
Type: text/x-csrc
Size: 6234 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120905/caa35f0=
2/attachment.c>
-------------- next part --------------
Loading Linux 3.2.21-ipipe-small-2-ipd ...

?EXT4-fs (hda1): couldn't mount as ext3 due to feature incompatibilities
EXT4-fs (hda1): couldn't mount as ext2 due to feature incompatibilities

INIT: version 2.88 booting

Using makefile-style concurrent boot in runlevel S.
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...done.
Setting preliminary keymap...done.
Activating swap...done.
Checking root file system...fsck from util-linux-ng 2.17.2
/dev/hda1: clean, 72970/256512 files, 579050/1026048 blocks
done.
Cleaning up ifupdown....
Setting up networking....
Loading kernel modules...done.
Activating lvm and md swap...done.
Checking file systems...fsck from util-linux-ng 2.17.2
done.
Mounting local filesystems...done.
Activating swapfile swap...done.
Cleaning up temporary files....
Configuring network interfaces...done.
Starting portmap daemon....
Starting NFS common utilities: statd.
Cleaning up temporary files....
Setting console screen modes.
=1B]Rcannot (un)set powersave mode
=1B[9;30]=1B[14;30]Skipping font and keymap setup (handled by console-setup=
).
Setting up console font and keymap...done.
Setting sensors limits.
Setting kernel variables ...done.
Loading the saved-state of the serial devices... =

/dev/ttyS0 at 0x03f8 (irq =3D 4) is a 16550A

INIT: Entering runlevel: 2

Using makefile-style concurrent boot in runlevel 2.
Enabling additional executable binary formats: binfmt-supportmount: mount p=
oint /proc/sys/fs/binfmt_misc does not exist
Starting NFS common utilities: statd.
Starting portmap daemon...Already running..
Starting enhanced syslogd: rsyslogd.
Starting anac(h)ronistic cron: anacron.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.
Starting system message bus: dbus.
Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon.
Starting MTA:Starting kerneloops:
 exim4.
Loading cpufreq kernel modules...done (none).
CPUFreq Utilities: Setting ondemand CPUFreq governor...disabled, governor n=
ot available...done.
Starting network connection manager: NetworkManager.
Starting OpenBSD Secure Shell server: sshd.
I-pipe: Detected stalled head domain, probably caused by a bug.
        A critical section may have been left unterminated.

Debian GNU/Linux 6.0 eve-0000 ttyS0

eve-0000 login: root
Password: =

Last login: Wed Sep  5 10:53:59 PDT 2012 on ttyS0
Linux eve-0000 3.2.21-ipipe-small-2-ipd #7 Wed Sep 5 17:45:26 UTC 2012 i586

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root@eve-0000:~# ./xddp-trycrash
Xenomai: corrupted queue, qslot->elems=3D5/5, qslot=3Db065b9c0 at kernel/xe=
nomai/nucleus/heap.c:332

 CPU  PID    PRI      TIMEOUT  STAT      NAME
>  0  0       -1      0        00500080  ROOT
   0  1539     0      0        00b00380  xddp-trycrash
   0  1542     0      0        00b00380  xddp-trycrash
   0  1543    42      0        00300380  xddp-trycrash
Master time base: clock=3D100421966997
