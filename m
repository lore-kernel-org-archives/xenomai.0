Message-ID: <497F0EBA.80302@domain.hid>
Date: Tue, 27 Jan 2009 13:40:10 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <496F0DBE.5010108@domain.hid>	<496F14B9.4010604@domain.hid>	<496F1CF2.1030401@domain.hid>	<496F275E.90407@domain.hid>	<496F4065.9040501@domain.hid>	<496F4558.8080603@domain.hid>	<49750A32.8080104@domain.hid>	<49750E55.8080000@domain.hid>	<4975901E.7040408@domain.hid>
	<497F07D2.6080501@domain.hid> <497F0C3C.5040004@domain.hid>
In-Reply-To: <497F0C3C.5040004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Pending patches
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> We should indeed postpone this just in case the upper layer indexes the extra
>>> state on the minor value. We can also simplify a few things doing so.
>>>
>>> --- ksrc/nucleus/pipe.c	(revision 4565)
>>> +++ ksrc/nucleus/pipe.c	(working copy)
>>> @@ -77,11 +77,9 @@
>>>
>>>  static inline void xnpipe_minor_free(int minor)
>>>  {
>>> -	if (minor < 0 || minor >= XNPIPE_NDEVS)
>>> -		return;
>>> -
>>> -	__clrbits(xnpipe_bitmap[minor / BITS_PER_LONG],
>>> -		  1UL << (minor % BITS_PER_LONG));
>>> +	/* May be called with nklock free. */
>>> +	clrbits(xnpipe_bitmap[minor / BITS_PER_LONG],
>>> +		1UL << (minor % BITS_PER_LONG));
>> Bad news: This doesn't fly as is. All modifying operations on
>> xnpipe_bitmap must be atomic and xnpipe_bitmap has to be
>> xnarch_atomic_t. But then find_first_zero_bit breaks. Is there some
>> version for atomic arrays? I guess we have to open-code this, at least
>> down to word-level...
>>
> 
> #define clrbits(flags,mask)  xnarch_atomic_clear_mask(&(flags),mask)
> 
> which is either translated to atomic_clear_mask() on x86 which works on a long
> value, or to any Xenomai-local implementation that work the same way for other
> archs. IOW, clrbits() shall be an atomic op by essence in our implementation.
> 
> The thing is that Linux atomic_set/clear_mask() on x86_64 is broken
> (s,andl,andq), so we may have to provide ours.

well, it may be a feature. Maybe they only need atomic ints.

-- 
                                                 Gilles.

