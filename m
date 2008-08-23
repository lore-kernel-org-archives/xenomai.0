Message-ID: <48AFE515.70003@domain.hid>
Date: Sat, 23 Aug 2008 12:23:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48AEE3AB.6070001@domain.hid> <48AEE945.8000503@domain.hid>
	<48AFCD61.8040203@domain.hid>
In-Reply-To: <48AFCD61.8040203@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
>>> ...and also automatically fixes the missing LOCK prefix for
>>> pthread_mutex_* services on x86_32 SMP.
>> This looks to me as a half-way unification. Can we not totally get rid
>> of atomic_32.h and atomic_64.h ? I mean since we are using unsigned long
>> as atomic_t on both platforms, there should not be much difference
>> (except maybe the inline asm).
>>
> 
> I could merge all atomic_32/64.h hunks into atomic.h if that this
> preferred, but I cannot help getting rid of the atomic_t vs. atomic64_t
> differences, thus the sub-arch specific part cannot be reduced as far as
> I see it ATM.

We could use atomic_long_t on the two arches.

-- 
					    Gilles.

