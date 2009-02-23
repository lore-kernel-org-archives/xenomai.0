Message-ID: <49A30B86.7080106@domain.hid>
Date: Mon, 23 Feb 2009 21:48:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <67b6b3430902231216k11c5addahaafef823075e7e54@domain.hid>
In-Reply-To: <67b6b3430902231216k11c5addahaafef823075e7e54@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Error building 2.6.27.19
	w/	adeos-ipipe-2.6.27.19-x86-2.2-06.patch
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
To: Mark Saiia <mark.saiia@domain.hid>
Cc: xenomai@xenomai.org

Mark Saiia wrote:
> When building 2.6.27.19 w/ adeos-ipipe-2.6.27.19-x86-2.2-06.patch. I get
> the following error.
> 
> CC      kernel/xenomai/arch/generic/hal.o
> kernel/xenomai/arch/generic/hal.c: In function 'rthal_irq_host_pend':
> kernel/xenomai/arch/generic/hal.c:301: error: void value not ignored as
> it ought to be
> 
> 
> Has anyone else ran into this issue? 
>

This patch is supported by the v2.4.x maintenance branch, or the Xenomai dev trunk.

> Deleting the return on that line appears to fix the issue.
> 

This will work as well.

> Mark Saiia
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

