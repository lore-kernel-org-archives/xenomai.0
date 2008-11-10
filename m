Message-ID: <49184157.5010603@domain.hid>
Date: Mon, 10 Nov 2008 15:12:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <9c789a000811080803s26f3007bp390e34428bb36b26@domain.hid>	
	<4916BC63.20304@domain.hid>	
	<9c789a000811090446l5d172120mc6791c220373b118@domain.hid>	
	<49171204.705@domain.hid>
	<9c789a000811100152m68bf3cc5o74df47c2e5066df0@domain.hid>
In-Reply-To: <9c789a000811100152m68bf3cc5o74df47c2e5066df0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] SegFault on all demo apps!!
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
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Cristian Axenie wrote:
> 
> 
> 
> 
>     I understand that. The point is that you don't need Comedi for
>     validating the
>     environment, since you are stuck in the very early stages it seems.
>     What you
>     need is to get the plain latency test running, first of all. Therefore,
>     downgrading to 2.4.5 for the purpose of testing is the way to
>     determine whether
>     this is a Xenomai trunk/ vs stable/ issue, or a bad interaction
>     between any
>     Xenomai version and the standard libraries used on your board.
> 
>  
> I tested the demo apps on the kernel-2.6.24 and Xenomai 2.4.5 and I get
> the same results .
> So is it possible to be an incompatibility between the standard libs
> (glibc..) on the target and the standard libs from the host where I
> build my kernel and installed Xenomai ?
> Would be a good solution to create a new filesystem using the same
> libraries (on the host), should this approach eliminate the possibility
> of incompatibility that generates the SegFault?
>

Normally, you should be using the same libs on both sides, either for linking
your apps or running your target. The cross-compiler will use the proper target
libs to link your app against as available with the same ELDK it is part of, and
I assume you booted your target over the ELDK root fs suitable for your arch as
well. If this is not the case, e.g. if you have populated your target root fs
with your own recipe using buildroot or other means, then you may have
introduced the issue.

First of all, I would try booting the board on the NFS-mounted root fs the ELDK
provides for your arch, and run the Xenomai testsuite from there.

Please keep the list CCed; this conversation may help other people.

> 
> Best,
> 
> Cristian
> 
> 
> 


-- 
Philippe.

