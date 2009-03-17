Message-ID: <49BFF579.3020408@domain.hid>
Date: Tue, 17 Mar 2009 20:09:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49BFED6E.4090009@domain.hid> <49BFEEE4.6020204@domain.hid>
	<49BFF0C7.7010001@domain.hid> <49BFF131.7070607@domain.hid>
	<49BFF332.9080809@domain.hid> <49BFF38B.1000509@domain.hid>
In-Reply-To: <49BFF38B.1000509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] posix: Fix error checks when copying
 user strings
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
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Obviously a conversion error while switching to __xn_safe*.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>>> Well, I have just checked the kernel code, and 0 as a return value of
>>>>> strncpy_from_user is treated as a value in most places, even if not -EFAULT.
>>>>>
>>>> Better check our code: :) __xn_safe_strncpy_from_user works differently.
>>> Then I would tend to consider that xn_safe_strncpy is broken.
>> No, because it not a derivate of strncpy_from_user, but an internal
>> service optimized for the most common use cases (where you don't care
>> about the precise return value).
> 
> So, what should I call if I care about the return value ?

The old combo of access_rok() and __xn_strncpy_from_user() - ah, I see
the issue: POSIX requires the length to report overflows to the users.
Hmm, then back to the old code, just adding the missing address range check.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

