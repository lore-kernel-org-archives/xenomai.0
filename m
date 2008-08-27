Message-ID: <48B576F2.5010409@domain.hid>
Date: Wed, 27 Aug 2008 17:46:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid> <48B55F7C.5030901@domain.hid>
	<48B56685.4060500@domain.hid> <48B570AF.4090900@domain.hid>
	<48B57281.2090109@domain.hid> <48B57626.8070404@domain.hid>
In-Reply-To: <48B57626.8070404@domain.hid>
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
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> +	xnarch_atomic_set(mutex->owner,
>>>>> +		 	  set_claimed(xnthread_handle(owner),
>>>>> +				      xnsynch_nsleepers(&mutex->synchbase)));
>>>> Ok. I think you have spotted a bug here. This should be mutex->sleepers
>>>> instead of xnsynch_nsleepers.
>>> BTW, why do you need to track sleepers separately in POSIX? Native
>>> doesn't do so, e.g.
>> Because of the "syscall-needed-when-unlocking-stolen-mutex" issue I
>> already explained (sleepers - xnsynch_nsleepers is precisely the count
>> of pending threads which have been awake then robbed the mutex).
> 
> Hmm, sounds like the new lock owner should better clear the 'claimed'
> bit then, not the old one on return from unlock. Or where is the
> pitfall? How does the futex algorithm handle this scenario?

Ok. Please read my explanation again, I have already explained this in
another mail.

-- 
                                                 Gilles.

