From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB0DA@rennsmail04.eu.thmulti.com>
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0DA@rennsmail04.eu.thmulti.com>
Content-Type: text/plain
Date: Wed, 16 May 2007 21:21:41 +0200
Message-Id: <1179343301.5010.53.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Adeos for Linux 2.6.19 PowerPC kernels.
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
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-05-16 at 20:07 +0200, Fillod Stephane wrote:
> Philippe Gerum wrote:
> >The other issue is an old bug of mine for this port, specifically we
> >need to call irq_enter()/irq_exit() for virtual interrupts too;
> >otherwise, softirqs triggered by virtual ones might be delayed until
> the
> >next hw interrupt comes in. Something like this would do:
> 
> Would this qualify for a new adeos-ipipe-2.6.19-ppc-1.5-02.patch ?
> 

Yes, definitely.

> >--- 2.6.19-ppc/include/asm/ipipe.h~ 2007-02-18 15:55:03 +0100
> >+++ 2.6.19-ppc/include/asm/ipipe.h	 2007-05-14 10:50:45 +0200
> [...]
> >--- 2.6.19-ppc/arch/powerpc/kernel/time.c~ 2006-11-29 22:57:37 +0100
> >+++ 2.6.19-ppc/arch/powerpc/kernel/time.c 2007-05-14 11:02:45 +0200
> [..]
> 
> Regards,
-- 
Philippe.



