Message-ID: <48F461A6.6010600@domain.hid>
Date: Tue, 14 Oct 2008 11:08:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F3C3E4.4020801@domain.hid> <48F45847.3030704@domain.hid>
In-Reply-To: <48F45847.3030704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __thread instead of pthread_get/setspecific
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
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> looking into the "xeno_in_primary_mode" thing I wondered how to make the
>> thread state quickly retrievable. Going via pthread_getspecific as we do
>> for xeno_get_current appears logical - but not optimal. Though
>> getspecific is optimized for speed, it remains a function call, a few
>> sanity checks, and only finally a TLS variable access. That could be
>> achieved in a much lighter way by using a __thread variable.
>>
>> But can we assume that all target we support also support the __thread
>> storage class? TLS is surely mandatory now: I assume pthread_getspecific
>> would become non-RT safe without it, right? Is there anything we
>> can/must check for during configure to verify __thread support?
> 
> I really think that this optimization is not worth the trouble. Anyway,

As long as we cannot specify the amount of "trouble", it's hard to
decide. Me current feeling is that it should rather simplify the
implementation + save us quite a few ops in the fast path (even more
with upcoming thread-mode check).

> I have one question: is an implementation guaranteed to support more
> than one __thread variable? Because from ARM implementation I would say
> that ARM has only one __thread variable.

That would be weird - there is no such limitation known to me. Anyway,
you could easily verify this with a simple test program I guess. /me
also wonders how the glibc/NPTL is maintaining certain per-thread
variables (and there are surely > 1) internally.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

