Date: Wed, 22 Dec 2010 19:13:09 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1012221805260.11502@domain.hid>
Message-ID: <alpine.DEB.1.10.1012221912220.11502@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012221306370.10955@domain.hid>
	<1293025850.22129.15.camel@domain.hid>
	<alpine.DEB.1.10.1012221511320.11502@domain.hid>
	<1293027465.22129.17.camel@domain.hid>
	<alpine.DEB.1.10.1012221612360.11502@domain.hid>
	<1293031751.22129.21.camel@domain.hid>
	<alpine.DEB.1.10.1012221805260.11502@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: "Kolja Waschk,,," <kawk@domain.hid>
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai GNA <xenomai@xenomai.org>

> cannot be reached on the console (Ctrl-C doesn't work) and GDB also doesn't 
> react on Ctrl-C. telnet to the target works, however. cat /proc/xenomai/sched

gdb doesn't seem to follow the task that called rt_task_create, but, maybe, the
manager task? I was able to reproduce the behaviour with a small test program;
gdb also became unresponsive in the same way when I tried to step into or over
rt_task_create, but came back again when the created task finishes or a
breakpoint in the main task was reached. For me, this behavious was unexpected..

In my actual application however I never get past the rt_task_create, even if 
I set a breakpoint at some line somewhen later.

Kolja



