Date: Wed, 22 Dec 2010 18:18:47 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1293031751.22129.21.camel@domain.hid>
Message-ID: <alpine.DEB.1.10.1012221805260.11502@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012221306370.10955@domain.hid>
	<1293025850.22129.15.camel@domain.hid>
	<alpine.DEB.1.10.1012221511320.11502@domain.hid>
	<1293027465.22129.17.camel@domain.hid>
	<alpine.DEB.1.10.1012221612360.11502@domain.hid>
	<1293031751.22129.21.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai GNA <xenomai@xenomai.org>

Hi,

> Check whether the thread manager does attempt to call into the Xenomai
> replacement for the pthread_cond_wait call.

I have to apologize; the pthread_cond_wait -> EPERM appeared after enabling
debug output to trace the actual problem I had when I started this mail thread,
but is seems unrelated. I have completely disabled that part of code, and with
it also disabled the use of all pthread* functions. Only native skin functions
are used by my remaining code and I'm back to the original problem (gdb hangs
at some point when stepi'ing through rt_task_start).

Even though debugging is enabled, nothing is printed on the console. The target
cannot be reached on the console (Ctrl-C doesn't work) and GDB also doesn't 
react on Ctrl-C. telnet to the target works, however. cat /proc/xenomai/sched
shows the half started task as "X Console_Output_Thread":

/ # cat /proc/xenomai/sched
CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
   0  0      rt      49      -         master     R          ROOT
   0  303    rt      49      -         master     RT         main
   0  305    rt      49      -         master     X          Console_Output_Thread

Kolja






