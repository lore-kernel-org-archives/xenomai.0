Message-ID: <48B569D1.90607@domain.hid>
Date: Wed, 27 Aug 2008 16:50:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid> <48B55F7C.5030901@domain.hid>
	<48B56685.4060500@domain.hid> <48B56876.3090601@domain.hid>
In-Reply-To: <48B56876.3090601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH 2/3] Switch to handle-based fast
	mutex owners
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>
>>> -#define test_claimed(owner) ((long) (owner) & 1)
>>> -#define clear_claimed(owner) ((xnthread_t *) ((long) (owner) & ~1))
>>> -#define set_claimed(owner, bit) \
>>> -        ((xnthread_t *) ((long) clear_claimed(owner) | !!(bit)))
>>> +#define __CLAIMED_BIT		XN_HANDLE_SPARE3
>>> +
>>> +#define test_claimed(owner)	xnhandle_test_spare(owner, __CLAIMED_BIT)
>>> +#define clear_claimed(owner)	xnhandle_mask_spare(owner)
>>> +#define set_claimed(owner, bit) ({ \
>>> +	xnhandle_t __tmp = xnhandle_mask_spare(owner); \
>>> +	if (bit) \
>>> +		xnhandle_set_spare(__tmp, __CLAIMED_BIT); \
>>> +	__tmp; \
>>> +})
>> I liked doing this with no conditional.
> 
> You mean let the caller pass 'bit' as 0 or __CLAIMED_BIT (the latter
> would require some renaming then, I guess)?

the if is ok. I guess the compiler does !! with an if too...

-- 
                                                 Gilles.

