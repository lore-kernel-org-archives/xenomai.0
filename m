Message-ID: <48F7BC58.7040506@domain.hid>
Date: Fri, 17 Oct 2008 00:12:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081016154620.320953568@domain.hid>	<20081016154621.318326730@domain.hid>
	<48F79C8E.3070900@domain.hid> <48F7B86D.8090204@domain.hid>
	<48F7B90D.3030107@domain.hid> <48F7BB23.9090600@domain.hid>
In-Reply-To: <48F7BB23.9090600@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 06/12] Lockless fast
	path	for	xnsynch_acquire/release
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>
>>>> Ok. Though I do not see the point of the FASTSEM/FASTSYNCH rename.
>>>> FASTSEM is short, and we are not much interested in getting anything
>>>> else than semaphores faster.
>>> We aren't optimizing semaphores (at least not yet), we are optimizing
>>> mutexes only. And if we ever optimize also semaphores, FASTSYNCH will
>>> luckily still fit. :)
>> The name was chosen because we plan to optimize semaphores as well, and
>> because mutexes are simply a special kind of semaphores, so, by saying
>> FASTSEM, we cover semaphores as well as mutexes.
> 
> That depends on how you define both - most semaphore definitions do not
> include the ownership concept, thus are not a superclass of
> (owner-tracking) mutexes we consider here.

>From my point of view, a mutex is a semaphore. If we imagine it in
simple OOP terms, the mutex class inherit from the semaphore class. Yes,
it has an owner member which the semaphore has not, but it still is a
semaphore.

-- 
					    Gilles.

