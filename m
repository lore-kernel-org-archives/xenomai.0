Message-ID: <48B275F3.6040204@domain.hid>
Date: Mon, 25 Aug 2008 11:05:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48AEE3AB.6070001@domain.hid>
	<48AEE945.8000503@domain.hid>	<48AFCD61.8040203@domain.hid>
	<48AFE515.70003@domain.hid> <48AFEA3B.4070702@domain.hid>
	<48B265A4.5040003@domain.hid> <48B266B9.50100@domain.hid>
	<48B2680D.2000303@domain.hid>
In-Reply-To: <48B2680D.2000303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/2] Unify asm-x86/atomic.h
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> +#include <asm/atomic.h>
>>> +
>>> +#if BITS_PER_LONG != 32
>>> +#error Upgrade to kernel 2.6!
>>> +#endif
>> I am not well versed with the 2.4 support. But are we sure we support no
>> 64 bits architecture with 2.4 ? What about ppc64 ?
> 
> AFAIK, only ppc32 is supported on kernel 2.4 now, and I don't think
> ppc64 ever was. Just i386 and ppc32 should bother us /wrt wrapping.

It is OK for me then.

-- 
                                                 Gilles.

