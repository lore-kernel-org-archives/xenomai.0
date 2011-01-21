From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1101211225490.3495@domain.hid>
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
	<4D38809E.3080906@domain.hid> <4D388975.80606@domain.hid>
	<alpine.DEB.1.10.1101211225490.3495@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 Jan 2011 15:00:31 +0100
Message-ID: <1295618431.1828.52.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org, Pierre.QUELIN@solystic.com

On Fri, 2011-01-21 at 13:03 +0100, Kolja Waschk wrote:
> Hi,
> 
> > The following patch seems to fix the issue, but I am not yet sure
> > diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> 
> Yes it does fix it for me too. The output of my "try" program when run with
> gdbserver still differs from the output when run standalone, but at least there
> are no EPERM results anymore. The first two tasks cycle pthread_cond_wait more
> than once.
> 
> 0 3x 0x0010
> 1 2x 0x0010
> 2 1x 0x0010
> 
> If I remove the pthread_yield() again there'll be a lockup again, for which I
> cannot see an actual reason. Now, there's no need to explain why this code
> can enter an endless loop and that it's no good style to do nothing with error
> return codes. But.. shouldn't I be able to break in with gdb via gdbserver
> anyway and see where the application is stuck? To interrupt - by chance - the
> loop in the right moment to be able a look at my result variable "r"...  Even
> if the loop is in a RT task with highest priority?
> 
> According to
> http://www.xenomai.org/index.php/FAQs#How_can_GDB_be_used.3F
> there are no limitations. Maybe it is specific to uClinux/linuxthreads/...?

This doc only says that GDB can be used the usual way, but it does not
guarantee that GDB may respond properly in case your real-time system
prevents the linux kernel from running.

> 
> I was originally expecting that I could hit Ctrl-C on the gdb host at any
> moment, type "info threads" and get an idea of what is happening in my stuck
> app (taking into account that afterwards some threads might have left their
> domain just because I interacted).

There is no way this could work if your target is stuck in an endless
primary mode loop. In that case, the gdb stub which is part of the
regular kernel just can't receive the remote "break" command packet sent
from your host, simply because the remote linux  kernel is not given any
CPU time. You have to enable the Xenomai watchdog for exiting this
situation.

I suspect that if pthread_yield() allows you to regain control via ^C,
then it is likely not the Xenomai wrapped service which gets called, but
rather the plain glibc one, which moves your thread to secondary mode,
hence resumes the linux kernel for a while, enough to process the
interrupt packet.

> 
> Kolja
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



