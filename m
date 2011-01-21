Date: Fri, 21 Jan 2011 13:03:14 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D388975.80606@domain.hid>
Message-ID: <alpine.DEB.1.10.1101211225490.3495@domain.hid>
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
	<4D38809E.3080906@domain.hid> <4D388975.80606@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Pierre.QUELIN@solystic.com

Hi,

> The following patch seems to fix the issue, but I am not yet sure
> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c

Yes it does fix it for me too. The output of my "try" program when run with
gdbserver still differs from the output when run standalone, but at least there
are no EPERM results anymore. The first two tasks cycle pthread_cond_wait more
than once.

0 3x 0x0010
1 2x 0x0010
2 1x 0x0010

If I remove the pthread_yield() again there'll be a lockup again, for which I
cannot see an actual reason. Now, there's no need to explain why this code
can enter an endless loop and that it's no good style to do nothing with error
return codes. But.. shouldn't I be able to break in with gdb via gdbserver
anyway and see where the application is stuck? To interrupt - by chance - the
loop in the right moment to be able a look at my result variable "r"...  Even
if the loop is in a RT task with highest priority?

According to
http://www.xenomai.org/index.php/FAQs#How_can_GDB_be_used.3F
there are no limitations. Maybe it is specific to uClinux/linuxthreads/...?

I was originally expecting that I could hit Ctrl-C on the gdb host at any
moment, type "info threads" and get an idea of what is happening in my stuck
app (taking into account that afterwards some threads might have left their
domain just because I interacted).

Kolja












