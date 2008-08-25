Message-ID: <48B28A21.40309@domain.hid>
Date: Mon, 25 Aug 2008 12:32:01 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48AEE3AB.6070001@domain.hid>	<48AEE945.8000503@domain.hid>	<48AFCD61.8040203@domain.hid>	<48AFE515.70003@domain.hid>
	<48AFEA3B.4070702@domain.hid>	<48B265A4.5040003@domain.hid>
	<48B266B9.50100@domain.hid>
In-Reply-To: <48B266B9.50100@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/2] Unify asm-x86/atomic.h
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-core@domain.hid

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> +#include <asm/atomic.h>
>> +
>> +#if BITS_PER_LONG != 32
>> +#error Upgrade to kernel 2.6!
>> +#endif
> 
> I am not well versed with the 2.4 support. But are we sure we support no
> 64 bits architecture with 2.4 ? What about ppc64 ?
> 

No other 2.4 port will be merged, so this should be ok. ppc64 is 2.6 only for us.

-- 
Philippe.

