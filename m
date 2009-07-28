Date: Tue, 28 Jul 2009 19:12:01 +0200 (CEST)
From: "Waschk,Kolja" <xenoka09@domain.hid>
In-Reply-To: <1248517986.4438.1.camel@domain.hid>
Message-ID: <alpine.DEB.2.00.0907281859210.4673@domain.hid>
References: <Pine.LNX.4.62.0907241731170.11473@domain.hid>
	<1248453047.3998.168.camel@domain.hid>
	<alpine.DEB.2.00.0907241917480.4343@domain.hid>
	<1248461458.3998.183.camel@domain.hid>
	<alpine.DEB.2.00.0907242259430.4343@domain.hid>
	<1248517986.4438.1.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] POSIX skin/Blackfin: SIGSEGV when stracing or
 gdb'ing
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

I've finally found a configuration of releases that works for me, good enough
to continue with the actual project development for now. It consists of
Blackfin tools 2009R1-RC10, dist 2009R1-RC2 including kernel and nucleus 2.4.7,
and external Xenomai 2.4.8 in userspace.

It's still not doing all what I expect, but the remaining problems probably are
caused by incorrect memory access in my application and/or driver. The
application runs with POSIX calls and critical threads controlled using the
native API (using rt_task_shadow), or all threads controlled via POSIX skin,
and it is well debuggable. Only when I tried to use the native skin for
everything, I ran into problems this time.

When there's time I'll again take a look at newer versions.

Thanks for the help so far!

Kolja




