Date: Fri, 17 Apr 2009 16:34:54 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <49E87CB1.9070604@domain.hid>
Message-ID: <Pine.LNX.4.64.0904171435580.15466@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<Pine.LNX.4.64.0904101708030.4820@domain.hid>
	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
	<Pine.LNX.4.64.0904101729031.4820@domain.hid>
	<49E08F6F.8000604@domain.hid>
	<Pine.LNX.4.64.0904111233180.32647@domain.hid>
	<49E0F887.40805@domain.hid>
	<Pine.LNX.4.64.0904111820330.6444@domain.hid>
	<49E1B05A.4040705@domain.hid>
	<Pine.LNX.4.64.0904121206040.23562@domain.hid>
	<49E23FB1.5030505@domain.hid>
	<Pine.LNX.4.64.0904151951500.9694@domain.hid>
	<49E87CB1.9070604@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On Fri, 17 Apr 2009, Gilles Chanteperdrix wrote:
>>...
>> Yes, I started from the config that came with Ubuntu, which has lots
>> of things turned on. However most of them are modules for drivers that
>> will never be loaded.
>
> No, there are also options which I would not recommend to turn on, such
> as syscall auditing and the like.

Unfortunately I don't have enough experience to know which of the
hundreds of kernel features can or can't be turned off without messing
things up. That's why, based on the directions in the "Xenomai quick
build guide", I started from an Ubuntu kernel that I knew worked, and
only turned off things that I was absolutely sure weren't important.

> Ok. Could you try a kernel without Xenomai but only with the Adeos
> Interrupt pipeline enabled ?

I have have just finished doing this, and indeed, with just Adeos
patched into the kernel, the lockups still occur.

Interestingly, I have discovered that if I bound the "dd if=/dev/zero
of=/dev/null", by specifying the number of blocks to be transfered,
then dd does eventually finish, and things return to normal, except
that the system clock is slow by the amount of time that the system
appeared to be hung. As always, during these freezes, pings from other
systems didn't get through, but moving the mouse would bring the
system alive for a few seconds. If I look at /proc/interrupts just
before and just after dd hangs the system, I see that there are no
timer interrupts registered during that time.

Martin

