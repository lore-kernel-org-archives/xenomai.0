Date: Wed, 29 Jul 2009 10:23:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
In-reply-to: <alpine.DEB.2.00.0907281859210.4673@domain.hid>
Message-id: <1248855797.3247.16.camel@domain.hid>
MIME-version: 1.0
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.62.0907241731170.11473@domain.hid>
	<1248453047.3998.168.camel@domain.hid>
	<alpine.DEB.2.00.0907241917480.4343@domain.hid>
	<1248461458.3998.183.camel@domain.hid>
	<alpine.DEB.2.00.0907242259430.4343@domain.hid>
	<1248517986.4438.1.camel@domain.hid>
	<alpine.DEB.2.00.0907281859210.4673@domain.hid>
Subject: Re: [Xenomai-help] POSIX skin/Blackfin: SIGSEGV when stracing or
 gdb'ing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2009-07-28 at 19:12 +0200, Waschk,Kolja wrote:
> Hi,
> 
> I've finally found a configuration of releases that works for me, good enough
> to continue with the actual project development for now. It consists of
> Blackfin tools 2009R1-RC10, dist 2009R1-RC2 including kernel and nucleus 2.4.7,
> and external Xenomai 2.4.8 in userspace.

Albeit this combo will work since no ABI change may occur between
releases of the stable branch, this does not make much sense to combine
an older kernel support with newer userland libs during the development
stage. You may want to upgrade the Xenomai kernel space support of
2009R1-RC2 to 2.4.8 as well. This must work, or your current combo would
only work by luck and there would very likely still be a problem hiding
somewhere.

> 
> It's still not doing all what I expect, but the remaining problems probably are
> caused by incorrect memory access in my application and/or driver. The
> application runs with POSIX calls and critical threads controlled using the
> native API (using rt_task_shadow), or all threads controlled via POSIX skin,
> and it is well debuggable. Only when I tried to use the native skin for
> everything, I ran into problems this time.
> 

Any details about this? What did not work with GDB precisely (btw, did
you check the stack sizes used to create your native tasks)?

> When there's time I'll again take a look at newer versions.
> 
> Thanks for the help so far!
> 
> Kolja
> 
> 
> 
-- 
Philippe.



