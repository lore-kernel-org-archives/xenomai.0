Date: Fri, 10 Apr 2009 15:15:52 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904081659110.22300@domain.hid>
Message-ID: <Pine.LNX.4.64.0904101250540.4820@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] Xeno-test bug
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

The xeno-test script doesn't work when /bin/sh isn't bash. In
particular, under Unbuntu and other recent debian derivatives,
xeno-test doesn't work, because such distributions use dash instead of
bash. See:

   http://en.wikipedia.org/wiki/Debian_Almquist_shell

Thus, when I run xeno-test on Ubuntu, I see the following:

   running: generate_loads 1
   dd workload started, pids 10309 stored in /var/lock/xeno-test.10169.pids
   10309 pts/0    00:00:00 dd
   something died a 10309 or
   something died a 10309 or
   something died a 10309 or
   ...ad infinitum...

However if I change the first line of xeno-test from "#! /bin/sh" to
"#! /bin/bash", then the script works.

The source of the problem is an interaction between the statement:
"eval $* &" in the following procedure, and the exit handler that is set
up in the generate_loads() procedure.

   loudly() {
       [ "$1" = "" ] && return
       # run task after announcing it
       echo; date;
       echo running: $*
       eval $* &                   # eval helps w complex cmds, like zegrep -E
       wait $!
   }

When the following statement is executed:

   loudly generate_loads $workload

"loudly" runs the generate_loads procedure as a background job (via
the "eval $* &" statement). One of the statements in generate_loads()
is the following:

   trap cleanup_load EXIT  # under all exit conditions

This is clearly intended to terminate the workload process when the
xeno-test script ends. However because the background_loads procedure
is executed as a background job (via the "eval $* &" statement of
loudly()), the cleanup_loads() procedure is called as soon as the
generate_loads() procedure finishes, not when the parent script that
ran it via loudly() exits, as appears to have been intended.

The generate_loads() script also binds the CHLD signal to the reaper()
procedure, which is what outputs the "something died" messages. This
is triggered by the completion of the next non-shell command. The
commands in the reaper() procedure itself, then themselves generate
CHLD signals, which result in reaper() effectively calling itself in
an infinite recursive loop.

So why doesn't this happen when the xeno-test script is run from bash?
First of all bash doesn't appear to execute exit handlers when a
procedure that is being run as a background job exits. I don't know
why, but I have verified this in small targetted test scripts.
Secondly, trapping CHLD signals in bash doesn't seem to work in any
circumstance, possibly because of the following clause in the bash
man-page:

   "Signals ignored upon entry to the shell cannot be trapped or reset."

In summary, the EXIT and CHLD signal handling in xeno-test doesn't
work in POSIX-compliant shells that actually trap these signals
correctly, and does nothing at all when run under bash. So it should
probably be removed from xeno-test.

To work around the problem for now, people running xeno-test on
systems that have bash, can change "#! /bin/sh" at the top of the
xeno-test script to "#! /bin/bash", or run it under busy-box.

Alternatively, edit xeno-test and remove the following lines:

     if test 0 -eq $withBusybox ; then
         reaper() { echo something died a $! or $* ; sleep 1;  }
         trap reaper CHLD
         trap cleanup_load EXIT  # under all exit conditions
     fi

Martin

