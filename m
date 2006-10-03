Message-ID: <003101c6e6f6$1fa52de0$1501a8c0@domain.hid>
From: "Kiichi Kameda" <k-kameda@domain.hid>
References: <003e01c6e6ee$d0ba19e0$1501a8c0@domain.hid> <45211492.6080109@domain.hid>
Subject: Re: [Xenomai-help] SH4 port
Date: Tue, 3 Oct 2006 23:13:39 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

> >
> > So, I created modified version of  SH-Linux code , where "current" macro
> > uses
> > the stack pointer(SP & ~(THREAD_SIZE) -1).
> > After that, although Linux seems to work well, the Xenomai thread still
> > causes system panic, if I once run the Xenomai program that uses POSIX
> skin.
>
> And that's something I do not understand. What was your idea behind this
> step?
>

Just a try , because I realized overwriting "current" may not be right way.


>
> [ksrc/arch/sh/switch.c]
>
> void rthal_switch_to(xnarchtcb_t *prev, xnarchtcb_t *next)
> {
> ...
>         /*
>          * Restore the kernel mode register
>          *      k7 (r7_bank1)
>          */
>  if(next->user_task) {
>
>             asm volatile("ldc       %0, r5_bank"
>                      : /* no output */
>                      : "r" (next->user_task->thread_info));
>  }
>
> Is there a particular reason why comment and reality diverge regarding
> the thread_info register? Could this cause your troubles?
>

I'm sorry, the comment is wrong.
The code that uses r7_bank  results in overwriting "current".
To avoid this,  I changed  from r7_bank to r5_bank for Xenomai context
switch .
Also, I added to the Linux context switch code  so that thread_info is set
in r5_bank register  as well as in r7_bank regsiter.
r5_bank register is referenced in the page fault handling code.

Kiichi Kameda


