From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4688E0BD.40709@domain.hid>
References: <4688E0BD.40709@domain.hid>
Content-Type: text/plain
Date: Mon, 02 Jul 2007 13:54:26 +0200
Message-Id: <1183377266.19565.14.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Switch to secondary mode
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

On Mon, 2007-07-02 at 13:25 +0200, Johan Borkhuis wrote:
> Hello,
> 
> I am having some problems with an application switching to secondary 
> mode. One of my applications is switching to secondary mode when a 
> function is called in a library. This function itself is empty (only 
> returning 0).
> When I move this function out of the library into the main C-file the 
> program stays in primary mode. What could be happening here?
> 

Late binding to functions performed on behalf of the dynamic loader
against shared libraries shall need the kernel during symbol resolution
(internal syscalls) or execution (e.g. demand loading, COW), hence the
switch. Unfortunately, the I-pipe patch for PPC does not support
disabling all on-demand memory mappings for selected Linux tasks (only
the x86 and ARM patches support this feature so far).

> This is the output of a backtrace:
> ./dsAuxEvQueTest1[0x10001858]
> /lib/ld.so.1[0x3001eaf8]
> [0x0]
> ./dsAuxEvQueTest1[0x100018f0]
> ./dsAuxEvQueTest1[0x10005c9c]
> /lib/libpthread.so.0[0xffd32fc]
> /lib/libc.so.6(__clone+0x84)[0xfe751e8]
> 
> Do I need to use some specific compile or link commandline arguments?
> 
> My architecture is ppc, Xenomai version 2.3.1 and kernel 2.6.14.
> 
> Kind regards,
>     Johan Borkhuis
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



