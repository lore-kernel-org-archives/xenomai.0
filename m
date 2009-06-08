From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <8bd0f97a0906081015k59a49a1dre38622401f011362@domain.hid>
References: <8bd0f97a0906081015k59a49a1dre38622401f011362@domain.hid>
Content-Type: text/plain
Date: Mon, 08 Jun 2009 22:14:39 +0200
Message-Id: <1244492079.7890.70.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] irq hooking and irqflags
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Mike Frysinger <vapier.adi@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2009-06-08 at 13:15 -0400, Mike Frysinger wrote: 
> i just finished converting Blackfin to the new irqflags.h system which
> included punting pretty much all of the irq.h guts (including IPIPE).
> since irqflags.h is directly designed for hooking the lower irq stuff,
> do we still need this stuff patched into the Blackfin code ?  seems
> like patching linux/irqflags.h would get you support for pretty much
> all arches for free ...

I wish it was so, but we do need to override the native routines that
manipulate the hw interrupt state when the I-pipe is enabled, and using
the irqflags framework will still require the implementation to provide
the raw_local_irq* helpers linux/irqflags.h requires, in some arch-dep
companion file for the Blackfin. This is the one we want to patch for
the I-pipe, to get them virtualized.

> -mike
-- 
Philippe.



