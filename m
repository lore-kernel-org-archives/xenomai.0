Message-ID: <48B65FCF.2060204@domain.hid>
Date: Thu, 28 Aug 2008 10:20:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid>	<48B55F7C.5030901@domain.hid>	<48B56685.4060500@domain.hid>	<48B570AF.4090900@domain.hid>	<48B57281.2090109@domain.hid>	<48B57626.8070404@domain.hid>	<48B576F2.5010409@domain.hid>	<48B57BE0.8000701@domain.hid>
	<48B57D32.60504@domain.hid>	<48B599DD.6070306@domain.hid>
	<48B5A4AB.3030909@domain.hid>	<48B5B9FC.2050900@domain.hid>
	<48B5DFE2.1080901@domain.hid> <48B65428.80201@domain.hid>
In-Reply-To: <48B65428.80201@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
>>> @@ -329,6 +326,13 @@ int pse51_mutex_timedlock_break(struct _
>>>  				break;
>>>  			}
>>>  		}
>>> +		if (!xnsynch_nsleepers(&mutex->synchbase)) {
>>> +			xnarch_atomic_set
>>> +				(mutex->owner,
>>> +				 clear_claimed
>>> +					(xnarch_atomic_get(mutex->owner)));
>>> +			xnsynch_set_owner(&mutex->synchbase, NULL);
>>> +		}
>>>  		xnlock_put_irqrestore(&nklock, s);
>> I do not like this at all. I mean, unless I am mistaken, we loose more
>> than we gain, we are adding a couple of atomic, hence heavy, operations
>> in a common case for handling a corner case. I still prefer emitting a
>> system call in the corner case.
> 
> The hunk above is in the mutex' deadlock path - I wouldn't call this a
> common case. Moreover, we don't any expensive cmpxchg here.
> 
> I haven't counted ops, but my strong feeling is that this patch actually
> shortens the common code paths + it safely avoids one syscall in the
> lock stealing case.

I have not yet understood how this happens.

-- 
                                                 Gilles.

