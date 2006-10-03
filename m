Message-ID: <002901c6e6ff$3f519d00$1501a8c0@domain.hid>
From: "Kiichi Kameda" <k-kameda@domain.hid>
References: <003e01c6e6ee$d0ba19e0$1501a8c0@domain.hid> <45211492.6080109@domain.hid>
	<003101c6e6f6$1fa52de0$1501a8c0@domain.hid> <452125A4.4010705@domain.hid>
Subject: Re: [Xenomai-help] SH4 port
Date: Wed, 4 Oct 2006 00:18:57 +0900
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


> Kiichi Kameda wrote:
> >> [ksrc/arch/sh/switch.c]
> >>
> >> void rthal_switch_to(xnarchtcb_t *prev, xnarchtcb_t *next)
> >> {
> >> ...
> >>         /*
> >>          * Restore the kernel mode register
> >>          *      k7 (r7_bank1)
> >>          */
> >>  if(next->user_task) {
> >>
> >>             asm volatile("ldc       %0, r5_bank"
> >>                      : /* no output */
> >>                      : "r" (next->user_task->thread_info));
> >>  }
> >>
> >> Is there a particular reason why comment and reality diverge regarding
> >> the thread_info register? Could this cause your troubles?
> >>
> >
> > I'm sorry, the comment is wrong.
> > The code that uses r7_bank  results in overwriting "current".
>
> What code is it?

Above code(rthal_switch_to) is derived from Linux, which uses r7_bank.
At first I used r7_bank  in rthal_switch_to , but this code caused panic.

>
> > To avoid this,  I changed  from r7_bank to r5_bank for Xenomai context
> > switch .
>
> Wouldn't it be better to avoid that overwriting in the first place
> instead of escaping from it? You may not be safe from code running on
> behalf of a Xenomai user-space thread that assumes current is still in
> r7_bank.
>
> > Also, I added to the Linux context switch code  so that thread_info is
set
> > in r5_bank register  as well as in r7_bank regsiter.
> > r5_bank register is referenced in the page fault handling code.
>
> The handling code of Xenomai or Linux?

There exists only one page fault handling code for both Xenomai and Linux.
Is this a problem?

>
> The goal must be that the environment for a shadowed Xenomai thread
> looks (almost) like that of a normal Linux thread. If there is Xenomai
> code that messes this up on SH4, this has to be fixed. Patching Linux
> Linux outside the I-pipe context indicates that something is wrong with
> the design. This is what I can say from my distant POV without knowing
> the specific issues of SH4.
>

Yes I think so too.




