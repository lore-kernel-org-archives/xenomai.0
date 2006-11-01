Subject: Re: [Xenomai-core] [PATCH] removing atomic_xchg from
	incluce/asm-poerpc/atomic.h
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45487FF1.5090402@domain.hid>
References: <45487FF1.5090402@domain.hid>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 12:41:34 +0100
Message-Id: <1162381294.4983.23.camel@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Wed, 2006-11-01 at 12:07 +0100, Wolfgang Grandegger wrote:
> Hello,
> 
> the attached patch fixes:
> 
> 2006-11-01  Wolfgang Grandegger  <wg@domain.hid>
>         * include/asm-powerpc/atomic.h: remove atomic_xch because it's
>         used in the kernel since 2.6.18 with different arguments (pointer
>         of type atomic_t).

Applied, thanks.

> 
> Wolfgang.
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



