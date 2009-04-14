Date: Mon, 13 Apr 2009 18:55:42 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
Message-ID: <Pine.LNX.4.64.0904131821010.12546@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-core] Fixing xeno-test
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

I have been working on fixing the problems in xeno-test that I
reported a few days ago. After spending most of yesterday fighting
with the broken signal-handling behavior of the various bourne-shell
derivatives, I came to the conclusion that it was impossible to
reliably and portably clean up background workload processes using
just shell signal handling. I thus decided to write a separate program
that xeno-test could invoke, which would take care of running the
background processes, restart any that terminated before xeno-test
ended, and terminate them when xeno-test either exited normally or was
terminated by a signal. I have done this now, incorporated it into
xeno-test, and tested it while running xeno-test under bash, dash and
busybox. My question is whether this approach is acceptible, and if
so, how I should submit it for incorporation in xenomai?

In particular, for the program that manages the background workload
processes (which is currently called xeno-stress), should I create a
new directory for this under xenomai-head/src/testsuite/, and set up
makefiles etc there, or should it go somewhere else?

In case anybody wants to see the code first, you can find the program
source code and a simple makefile for compiling it, at:

   http://www.astro.caltech.edu/~mcs/xenomai/xeno-stress.c
   http://www.astro.caltech.edu/~mcs/xenomai/Makefile

It is run like:

   ./xeno-stress -n 2 -r 100 dd if=/dev/zero of=/dev/null &

where -n 2 means run two copies of the workload process, -r 100 means
don't restart the workload processes more than 100 times, and the
workload program and its arguments are the trailing arguments given to
xeno-stress. In the above case this is xeno-test's conventional dd
workload. Sending the xeno-stress process any TERM, INT, PIPE, HUP or
QUIT signal will cause it to terminate the workload processes that it
started. To avoid race conditions, it uses 2 threads; one which starts
the workload processes, then sits in wait(), restarting any processes
that end normally, or exiting if any end abnormally, and a second that
sits in sigwait(), watching for termination signals, and when one is
received, terminating all of the background processes before telling
the other thread to terminate itself.

Martin

