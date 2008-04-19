Message-ID: <480A6D6E.2000208@domain.hid>
Date: Sun, 20 Apr 2008 00:08:46 +0200
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <480A4F99.7040701@domain.hid> <480A57BD.2010905@domain.hid>
In-Reply-To: <480A57BD.2010905@domain.hid>
Content-Type: multipart/mixed; boundary="------------000304030602060008060504"
Subject: Re: [Xenomai-core] Missing manual pages
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000304030602060008060504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Jan Kiszka wrote:
> While nitpicking can sometimes be useful, though...

Thanks for the comments, I'm attaching the patch that integrates the
updated version of the man pages (incl. Makefile.am).

bye,
  Roland

--------------000304030602060008060504
Content-Type: text/x-diff;
 name="xenomai-man.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-man.patch"

diff -ruN xenomai-2.4.3.orig/doc/man/clocktest.man.in xenomai-2.4.3/doc/man/clocktest.man.in
--- xenomai-2.4.3.orig/doc/man/clocktest.man.in	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.4.3/doc/man/clocktest.man.in	2008-04-20 00:03:48.000000000 +0200
@@ -0,0 +1,36 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for clocktest
+.\"
+.\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH CLOCKTEST 1 "2008-04-01" "@PACKAGE_VERSION@" "Xenomai"
+.SH NAME
+clocktest \- Xenomai Clock Test
+.SH SYNOPSIS
+.\" The general command line
+.B clocktest
+.SH DESCRIPTION
+\fBclocktest\fP is part of the Xenomai test suite and tests the Clock. For each
+CPU, it repeatedly prints a time offset (compared to the reference
+gettimeofday()), a drift value, the number of warps and the maximum warp in
+microseconds.
+
+For this program to work, you need to run a suitable Xenomai enabled kernel
+with the respective module (xeno_posix).
+.SH OPTIONS
+\fBclocktest\fP accepts the following options:
+.TP
+.B \-C <clock_id>
+tested clock, default=0 (CLOCK_REALTIME)
+.TP
+.B \-T <test_duration_seconds>
+default=0, so ^C to end
+.SH AUTHOR
+\fBclocktest\fP was written by Jan Kiszka <jan.kiszka@domain.hid>. This man page
+was written by Roland Stigge <stigge@domain.hid>.
diff -ruN xenomai-2.4.3.orig/doc/man/cyclictest.man.in xenomai-2.4.3/doc/man/cyclictest.man.in
--- xenomai-2.4.3.orig/doc/man/cyclictest.man.in	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.4.3/doc/man/cyclictest.man.in	2008-04-20 00:03:48.000000000 +0200
@@ -0,0 +1,70 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for cyclictest
+.\"
+.\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH CYCLICTEST 1 "2008-04-01" "@PACKAGE_VERSION@" "Xenomai"
+.SH NAME
+cyclictest \- Xenomai high resolution timer test
+.SH SYNOPSIS
+.\" The general command line
+.B cyclictest
+.RI [ options ]
+.SH DESCRIPTION
+\fBcyclictest\fP is part of the Xenomai test suite and tests the POSIX skin of Xenomai with a cyclic timer test.
+
+For this program to work, you need to run a suitable Xenomai enabled kernel with the respective module (xeno_posix).
+.SH OPTIONS
+\fBcyclictest\fP accepts the following options:
+.TP
+.B \-b USEC, \-\-breaktrace=USEC
+send break trace command when latency > USEC
+.TP
+.B \-c CLOCK, \-\-clock=CLOCK
+select clock:
+.RS 1.5i
+0 = CLOCK_MONOTONIC (default)
+.P
+1 = CLOCK_REALTIME
+.RE
+.TP
+.B \-d DIST, \-\-distance=DIST
+distance of thread intervals in us default=500
+.TP
+.B \-i INTV, \-\-interval=INTV
+base interval of thread in us default=1000
+.TP
+.B \-l LOOPS, \-\-loops=LOOPS
+number of loops: default=0 (endless)
+.TP
+.B \-n, \-\-nanosleep
+use clock_nanosleep
+.TP
+.B \-p PRIO, \-\-prio=PRIO
+priority of highest prio thread
+.TP
+.B \-q, \-\-quiet
+print only a summary on exit
+.TP
+.B \-r, \-\-relative
+use relative timer instead of absolute
+.\".TP
+.\".B \-s, \-\-system
+.\"use sys_nanosleep and sys_setitimer
+.TP
+.B \-t NUM, \-\-threads=NUM
+number of threads: default=1
+.TP
+.B \-v, \-\-verbose
+output values on stdout for statistics
+
+format: n:c:v n=tasknum c=count v=value in us
+.SH AUTHOR
+\fBcyclictest\fP was written by Thomas Gleixner <tglx@domain.hid>. This man page
+was written by Roland Stigge <stigge@domain.hid>.
diff -ruN xenomai-2.4.3.orig/doc/man/irqbench.man.in xenomai-2.4.3/doc/man/irqbench.man.in
--- xenomai-2.4.3.orig/doc/man/irqbench.man.in	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.4.3/doc/man/irqbench.man.in	2008-04-20 00:03:48.000000000 +0200
@@ -0,0 +1,46 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for irqbench
+.\"
+.\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH IRQBENCH 1 "2008-04-19" "@PACKAGE_VERSION@" "Xenomai"
+.SH NAME
+irqbench \- Xenomai IRQ benchmark, host control
+.SH SYNOPSIS
+.\" The general command line
+.B irqbench
+.RI [ options ]
+.SH DESCRIPTION
+\fBirqbench\fP is part of the Xenomai test suite and benchmarks IRQs. It is the
+controlling part running on a plain Linux host, connected via RS232 or Laplink
+with the target which is running a suitable Xenomai enabled kernel with the
+respective module (xeno_posix). The target must run \fBirqloop\fP (1).
+.SH OPTIONS
+\fBirqbench\fP accepts the following options:
+.TP
+.B \-p <period_us>
+signal period, default=100 us
+.TP
+.B \-T <test_duration_seconds>
+default=0, so ^C to end
+.TP
+.B \-o <port_type>
+0=serial (default), 1=parallel
+.TP
+.B \-a <port_io_address>
+default=0x3f8/0x378
+.TP
+.B \-f
+freeze trace for each new max latency
+.SH "SEE ALSO"
+.BR /usr/share/doc/xenomai-doc/txt/irqbench.txt,
+.BR irqloop (1)
+.SH AUTHOR
+\fBirqbench\fP was written by Jan Kiszka <jan.kiszka@domain.hid>. This man page
+was written by Roland Stigge <stigge@domain.hid>.
diff -ruN xenomai-2.4.3.orig/doc/man/irqloop.man.in xenomai-2.4.3/doc/man/irqloop.man.in
--- xenomai-2.4.3.orig/doc/man/irqloop.man.in	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.4.3/doc/man/irqloop.man.in	2008-04-20 00:03:48.000000000 +0200
@@ -0,0 +1,59 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for irqloop
+.\"
+.\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH IRQLOOP 1 "2008-04-19" "@PACKAGE_VERSION@" "Xenomai"
+.SH NAME
+irqloop \- Xenomai IRQ benchmark, target program
+.SH SYNOPSIS
+.\" The general command line
+.B irqloop
+.RI [ options ]
+.SH DESCRIPTION
+\fBirqloop\fP is part of the Xenomai test suite and benchmarks IRQs. It is the
+program running on the target machine which is running a suitable Xenomai
+enabled kernel with the respective module (xeno_posix). The additional tool
+\fBirqbench\fP (1) is running on a plain Linux host, connected via RS232 or
+Laplink with the target.
+.SH OPTIONS
+\fBirqloop\fP accepts the following options:
+.TP
+.B \-D <testing_device_no>
+number of testing device, default=0
+.TP
+.B \-t <test_mode>
+.RS 1.5i
+0=user task (default)
+.P
+1=kernel task
+.P
+2=IRQ handler
+.P
+3=hard-IRQ handler
+.RE
+.TP
+.B \-P <priority>
+task priority (test mode 0 and 1 only)
+.TP
+.B \-o <port_type>
+0=serial (default), 1=parallel
+.TP
+.B \-a <port_io_address>
+default=0x3f8/0x378
+.TP
+.B \-i <port_irq>
+default=4/7
+
+.SH "SEE ALSO"
+.BR /usr/share/doc/xenomai-doc/txt/irqloop.txt,
+.BR irqbench (1)
+.SH AUTHOR
+\fBirqloop\fP was written by Jan Kiszka <jan.kiszka@domain.hid>. This man page
+was written by Roland Stigge <stigge@domain.hid>.
diff -ruN xenomai-2.4.3.orig/doc/man/klatency.man.in xenomai-2.4.3/doc/man/klatency.man.in
--- xenomai-2.4.3.orig/doc/man/klatency.man.in	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.4.3/doc/man/klatency.man.in	2008-04-20 00:03:48.000000000 +0200
@@ -0,0 +1,39 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for klatency
+.\"
+.\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH KLATENCY 1 "2008-04-19" "@PACKAGE_VERSION@" "Xenomai"
+.SH NAME
+klatency \- Xenomai kernel latency test
+.SH SYNOPSIS
+.\" The general command line
+.B klatency
+.RI [ options ]
+.SH DESCRIPTION
+\fBklatency\fP is part of the Xenomai test suite. It is a latency measurement
+tool dedicated to kernel-based activities.  The system must run a suitable
+Xenomai enabled kernel with the respective module (klat_pipe).
+.SH OPTIONS
+\fBklatency\fP accepts the following options:
+.TP
+.B \-l <data-lines per header>
+default=21, 0 to suppress headers
+.TP
+.B \-T <test_duration_seconds>
+default=0, so ^C to end
+.TP
+.B \-q
+supresses RTD, RTH lines if -T is used
+.TP
+.B \-P <rt_pipe_no>
+number of testing pipe, default=auto
+.SH AUTHOR
+\fBklatency\fP was written by Philippe Gerum <rpm@xenomai.org>. This man page
+was written by Roland Stigge <stigge@domain.hid>.
diff -ruN xenomai-2.4.3.orig/doc/man/latency.man.in xenomai-2.4.3/doc/man/latency.man.in
--- xenomai-2.4.3.orig/doc/man/latency.man.in	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.4.3/doc/man/latency.man.in	2008-04-20 00:03:48.000000000 +0200
@@ -0,0 +1,66 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for latency
+.\"
+.\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH LATENCY 1 "2008-04-19" "@PACKAGE_VERSION@" "Xenomai"
+.SH NAME
+latency \- Xenomai timer latency benchmark
+.SH SYNOPSIS
+.\" The general command line
+.B latency
+.RI [ options ]
+.SH DESCRIPTION
+\fBlatency\fP is part of the Xenomai test suite. It is a timer latency
+benchmark program.  The system must run a suitable Xenomai enabled kernel with
+the respective module (xeno_timerbench).
+.SH OPTIONS
+\fBlatency\fP accepts the following options:
+.TP
+.B \-h
+print histograms of min, avg, max latencies
+.TP
+.B \-s
+print statistics of min, avg, max latencies
+.TP
+.B \-H <histogram-size>
+default = 200, increase if your last bucket is full
+.TP
+.B \-B <bucket-size>
+default = 1000ns, decrease for more resolution
+.TP
+.B \-p <period_us>
+sampling period
+.TP
+.B \-l <data-lines per header>
+default=21, 0 to supress headers
+.TP
+.B \-T <test_duration_seconds>
+default=0, so ^C to end
+.TP
+.B \-q
+supresses RTD, RTH lines if -T is used
+.TP
+.B \-D <testing_device_no>
+number of testing device, default=0
+.TP
+.B \-t <test_mode>
+0=user task (default), 1=kernel task, 2=timer IRQ
+.TP
+.B \-f
+freeze trace for each new max latency
+.TP
+.B \-c <cpu>
+pin measuring task down to given CPU
+.TP
+.B \-P <priority>
+task priority (test mode 0 and 1 only)
+.SH AUTHOR
+\fBlatency\fP was written by Philippe Gerum <rpm@xenomai.org>. This man page
+was written by Roland Stigge <stigge@domain.hid>.
diff -ruN xenomai-2.4.3.orig/doc/man/Makefile.am xenomai-2.4.3/doc/man/Makefile.am
--- xenomai-2.4.3.orig/doc/man/Makefile.am	2007-12-09 11:46:55.000000000 +0100
+++ xenomai-2.4.3/doc/man/Makefile.am	2008-04-20 00:05:25.000000000 +0200
@@ -1,2 +1,7 @@
-man1_MANS = xeno-config.man xeno-info.man xeno-load.man xeno-test.man
+man1_MANS = xeno-config.man xeno-info.man xeno-load.man xeno-test.man \
+	    clocktest.man.in cyclictest.man.in irqbench.man.in irqloop.man.in \
+	    klatency.man.in latency.man.in rtcanconfig.man.in \
+	    rtcanrecv.man.in rtcansend.man.in switchbench.man.in \
+	    switchtest.man.in
+
 man5_MANS = runinfo.man
diff -ruN xenomai-2.4.3.orig/doc/man/rtcanconfig.man.in xenomai-2.4.3/doc/man/rtcanconfig.man.in
--- xenomai-2.4.3.orig/doc/man/rtcanconfig.man.in	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.4.3/doc/man/rtcanconfig.man.in	2008-04-20 00:03:48.000000000 +0200
@@ -0,0 +1,45 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for rtcanconfig
+.\"
+.\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH RTCANCONFIG 1 "2008-04-19" "@PACKAGE_VERSION@" "Xenomai"
+.SH NAME
+rtcanconfig \- Xenomai tool for configuring the CAN controller
+.SH SYNOPSIS
+.\" The general command line
+.B rtcanconfig
+.RI "<can-interface> [options] [up|down|start|stop|sleep]"
+.SH DESCRIPTION
+\fBrtcanconfig\fP is part of Xenomai. It is used to configure the CAN
+controller. The system must run a suitable Xenomai enabled kernel with the
+respective module (CAN).
+.SH OPTIONS
+\fBrtcanconfig\fP accepts the following options:
+.TP
+.B \-v, \-\-verbose
+be verbose
+.TP
+.B \-h, \-\-help
+a usage description
+.TP
+.B \-c, \-\-ctrlmode=CTRLMODE
+listenonly, loopback or none
+.TP
+.B \-b, \-\-baudrate=BPS
+baudrate in bits/sec
+.TP
+.B \-B, \-\-bittime=BTR0:BTR1
+BTR or standard bit-time
+.TP
+.B \-B, \-\-bittime=BRP:PROP_SEG:PHASE_SEG1:PHASE_SEG2:SJW:SAM
+.SH AUTHORS
+\fBrtcanconfig\fP was written by Wolfgang Grandegger <wg@domain.hid> and
+Sebastian Smolorz <Sebastian.Smolorz@domain.hid>. This man page was
+written by Roland Stigge <stigge@domain.hid>.
diff -ruN xenomai-2.4.3.orig/doc/man/rtcanrecv.man.in xenomai-2.4.3/doc/man/rtcanrecv.man.in
--- xenomai-2.4.3.orig/doc/man/rtcanrecv.man.in	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.4.3/doc/man/rtcanrecv.man.in	2008-04-20 00:03:48.000000000 +0200
@@ -0,0 +1,57 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for rtcanrecv
+.\"
+.\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH RTCANRECV 1 "2008-04-19" "@PACKAGE_VERSION@" "Xenomai"
+.SH NAME
+rtcanrecv \- Xenomai tool for receiving CAN messages
+.SH SYNOPSIS
+.\" The general command line
+.B rtcanrecv
+.RI "[<can-interface>] [Options]"
+.SH DESCRIPTION
+\fBrtcanrecv\fP is part of Xenomai. It is used to receive messages via a CAN
+interface. The system must run a suitable Xenomai enabled kernel with the
+respective module (xeno_native and the CAN driver).
+.SH OPTIONS
+<can-interface> is the CAN interface file.
+
+\fBrtcanrecv\fP accepts the following options:
+.TP
+.B \-f, \-\-filter=id:mask[:id:mask]...
+apply filter
+.TP
+.B \-e, \-\-error=mask
+receive error messages
+.TP
+.B \-t, \-\-timeout=MS
+timeout in ms
+.TP
+.B \-T, \-\-timestamp
+with absolute timestamp
+.TP
+.B \-R, \-\-timestamp-rel
+with relative timestamp
+.TP
+.B \-v, \-\-verbose
+be verbose
+.TP
+.B \-p, \-\-print=MODULO
+print every MODULO message
+.TP
+.B \-h, \-\-help
+this help
+.SH "SEE ALSO"
+.BR rtcanconfig (1),
+.BR rtcanrecv (1)
+.SH AUTHORS
+\fBrtcanrecv\fP was written by Wolfgang Grandegger <wg@domain.hid>, Jan
+Kiszka <jan.kiszka@domain.hid> and Philippe Gerum <rpm@xenomai.org>. This man page
+was written by Roland Stigge <stigge@domain.hid>.
diff -ruN xenomai-2.4.3.orig/doc/man/rtcansend.man.in xenomai-2.4.3/doc/man/rtcansend.man.in
--- xenomai-2.4.3.orig/doc/man/rtcansend.man.in	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.4.3/doc/man/rtcansend.man.in	2008-04-20 00:03:48.000000000 +0200
@@ -0,0 +1,71 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for rtcansend
+.\"
+.\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH RTCANSEND 1 "2008-04-19" "@PACKAGE_VERSION@" "Xenomai"
+.SH NAME
+rtcansend \- Xenomai tool for sending CAN messages
+.SH SYNOPSIS
+.\" The general command line
+.B rtcansend
+.RI "<can-interface> [Options] <can-msg>"
+.SH DESCRIPTION
+\fBrtcansend\fP is part of Xenomai. It is used to send messages via a CAN
+interface. The system must run a suitable Xenomai enabled kernel with the
+respective module (xeno_native and the CAN driver).
+.SH OPTIONS
+<can-interface> is the CAN interface file.
+
+<can-msg> can consist of up to 8 bytes given as a space separated list.
+
+\fBrtcansend\fP accepts the following options:
+.TP
+.B \-i, \-\-identifier=ID
+CAN Identifier (default = 1)
+.TP
+.B \-r, \-\-rtr
+send remote request
+.TP
+.B \-e, \-\-extended
+send extended frame
+.TP
+.B \-l, --loop=COUNT
+send message COUNT times
+.TP
+.B \-c, \-\-count
+message count in data[0-3]
+.TP
+.B \-d, \-\-delay=MS
+delay in ms (default = 1ms)
+.TP
+.B \-s, \-\-send
+use send instead of sendto
+.TP
+.B \-t, \-\-timeout=MS
+timeout in ms
+.TP
+.B \-L, \-\-loopback=0|1
+switch local loopback off or on
+.TP
+.B \-v, \-\-verbose
+be verbose
+.TP
+.B \-p, \-\-print=MODULO
+print every MODULO message
+.TP
+.B \-h, \-\-help
+a usage description
+.SH "SEE ALSO"
+.BR rtcanconfig (1),
+.BR rtcanrecv (1)
+.SH AUTHORS
+\fBrtcansend\fP was written by Wolfgang Grandegger <wg@domain.hid>, Jan
+Kiszka <jan.kiszka@domain.hid> and Philippe Gerum <rpm@xenomai.org>. This man page
+was written by Roland Stigge <stigge@domain.hid>.
diff -ruN xenomai-2.4.3.orig/doc/man/switchbench.man.in xenomai-2.4.3/doc/man/switchbench.man.in
--- xenomai-2.4.3.orig/doc/man/switchbench.man.in	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.4.3/doc/man/switchbench.man.in	2008-04-20 00:03:48.000000000 +0200
@@ -0,0 +1,40 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for switchbench
+.\"
+.\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH SWITCHBENCH 1 "2008-04-19" "@PACKAGE_VERSION@" "Xenomai"
+.SH NAME
+switchbench \- Xenomai latency test for task switches
+.SH SYNOPSIS
+.\" The general command line
+.B switchbench
+.RI [ options ]
+.SH DESCRIPTION
+\fBswitchbench\fP is part of Xenomai. It can be used to test task switch
+latencies. A suitable Xenomai enabled kernel with the respective module
+(xeno_posix) must be installed.
+.SH OPTIONS
+\fBswitchbench\fP accepts the following options:
+.TP
+.B \-h
+enable histogram
+.TP
+.B \-p <period_us>
+timer period
+.TP
+.B \-n <samples>
+number of samples to collect
+.TP
+.B \-i <samples>
+number of _first_ samples to ignore
+.SH AUTHOR
+\fBswitchbench\fP was written by Philippe Gerum <rpm@xenomai.org> and  Max
+Krasnyansky <maxk@domain.hid>. This man page was written by
+Roland Stigge <stigge@domain.hid>.
diff -ruN xenomai-2.4.3.orig/doc/man/switchtest.man.in xenomai-2.4.3/doc/man/switchtest.man.in
--- xenomai-2.4.3.orig/doc/man/switchtest.man.in	1970-01-01 01:00:00.000000000 +0100
+++ xenomai-2.4.3/doc/man/switchtest.man.in	2008-04-20 00:03:48.000000000 +0200
@@ -0,0 +1,88 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for switchtest
+.\"
+.\" Copyright (C) 2008 Roland Stigge <stigge@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH SWITCHTEST 1 "2008-04-19" "@PACKAGE_VERSION@" "Xenomai"
+.SH NAME
+switchtest \- Xenomai context switch test
+.SH SYNOPSIS
+.\" The general command line
+.B switchtest
+.RI "[options] threadspec threadspec..."
+.SH DESCRIPTION
+\fBswitchtest\fP is part of Xenomai. It can be used to test thread context
+switches. \fBswitchtest\fP creates threads of various types and attempts to
+switch context between these threads, printing the count of context switches
+every second. A suitable Xenomai enabled kernel with the respective module
+(xeno_posix) must be installed.
+.SH OPTIONS
+Each threadspec specifies the characteristics of a thread to be created:
+
+threadspec = (rtk|rtup|rtus|rtuo)(_fp|_ufpp|_ufps)*[0-9]*
+
+.B rtk
+for a kernel-space real-time thread
+
+.B rtup
+for a user-space real-time thread running in primary mode
+
+.B rtus
+for a user-space real-time thread running in secondary mode
+
+.B rtuo
+for a user-space real-time thread oscillating between primary and secondary mode
+
+.B _fp
+means that the created thread will have the XNFPU bit armed (only valid for rtk)
+
+.B _ufpp
+means that the created thread will use the FPU when in primary mode\n(invalid for rtus)
+
+.B _ufps
+means that the created thread will use the FPU when in secondary mode (invalid for rtk and rtup)
+
+.B "[0-9]*" specifies the ID of the CPU where the created thread will run, 0 if unspecified
+
+Passing no
+.B threadspec
+is equivalent to running:
+
+switchtest rtkN rtkN rtk_fpN rtk_fpN rtk_fp_ufppN rtk_fp_ufppN rtupN rtupN rtup_ufppN
+rtup_ufppN rtusN rtusN rtus_ufpsN rtus_ufpsN rtuoN rtuoN rtuo_ufppN rtuo_ufppN rtuo_ufpsN
+rtuo_ufpsN rtuo_ufpp_ufpsN rtuo_ufpp_ufpsN
+
+with N=1,...,nr_cpus, i.e. occurrences of all the arguments for each CPU
+
+Passing only the \-\-nofpu or \-n argument is equivalent to running:
+
+switchtest rtkN rtkN rtupN rtupN rtusN rtusN rtuoN rtuoN
+
+similar to the above.
+
+\fBswitchtest\fP accepts the following options:
+.TP
+.B \-\-help, \-h
+print usage information and exit
+.TP
+.B \-\-lines <lines>, \-l <lines>
+print headers every <lines> lines
+.TP
+.B \-\-quiet or \-q
+prevent this program from printing every second the count of ncontext switches
+.TP
+.B \-\-timeout <duration>, \-T <duration>
+limit the test duration to <duration> seconds
+.TP
+.B \-\-nofpu, \-n
+disables any use of FPU instructions
+.SH AUTHOR
+\fBswitchtest\fP was written by Philippe Gerum <rpm@xenomai.org> and Gilles
+Chanteperdrix <gilles.chanteperdrix@xenomai.org>. This man page was written by
+Roland Stigge <stigge@domain.hid>.

--------------000304030602060008060504--

