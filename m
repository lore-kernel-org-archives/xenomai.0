Subject: Re: [Xenomai-core] [BUG] oops on skincall without nucleus being loaded
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17563.61309.258099.930934@domain.hid>
References: <449A7261.7040503@domain.hid> <449A7602.1020004@domain.hid>
	<17563.61309.258099.930934@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 18:26:11 +0200
Message-Id: <1151079971.4438.103.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Fri, 2006-06-23 at 15:41 +0200, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Jan Kiszka wrote:
>  > > Hi,
>  > > 
>  > > wondering why suddenly things crash on invoking the latency test, I
>  > > realised that I turned the nucleus into a module which was not yet
>  > > loaded. Here is the oops in this case:
>  > 
>  > Correction: the nucleus was still compiled in, the native skin was missing.
> 
> After a few investigation, the problem appears to be that the nucleus
> assume that user-space skins will issue a bind syscall before using a
> skin, and that the user-space RTDM library does not exit if binding
> fails.

I don't get it: the muxid should be invalid then(?)

>  So, there are two ways we can fix this problem:
> - either we make the nucleus paranoid and have it handle gracefully
>   syscalls to non loaded tables;
> - or we make the user-space RTDM library behave like other skins and
>   exit if the interface is not bound.

-- 
Philippe.



