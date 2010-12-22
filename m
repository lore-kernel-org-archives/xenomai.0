Date: Wed, 22 Dec 2010 20:00:45 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <1293042519.22129.91.camel@domain.hid>
Message-ID: <alpine.DEB.1.10.1012221944080.11502@domain.hid>
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
	<alpine.DEB.1.10.1012221912220.11502@domain.hid>
	<1293042519.22129.91.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
Reply-To: Kolja Waschk <xenoka09@domain.hid>
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

>> In my actual application however I never get past the rt_task_create, even if
>> I set a breakpoint at some line somewhen later.

> What if you don't single step but (c)ontinue?

It "hangs".

But wait, just in this moment I discovered that I can get further if I
set all priorities, i.e. priority of the main task (with rt_task_shadow) and the
tasks where I couldn't get past rt_task_create, to 0 instead of 49 as before. Then at
least "cont" works to the next breakpoint (stepping over with "next" still doesn't).

Debugging with gdb at the moment feels unnecessarily complicated. Very often
the "next" doesn't bring me to the next line in my current source, but to some unexpected
place (e.g. to a rt_mutex_acquire_inner() which was called in a subroutine four
levels deeper..). I don't remember me becoming that confused with my previous
setup (Blackfin 2.6.28 kernel with Xenomai 2.4.7) or in other C++ apps ;)

Kolja


