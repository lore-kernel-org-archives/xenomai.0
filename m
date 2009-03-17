Message-ID: <49BFF131.7070607@domain.hid>
Date: Tue, 17 Mar 2009 19:51:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49BFED6E.4090009@domain.hid> <49BFEEE4.6020204@domain.hid>
	<49BFF0C7.7010001@domain.hid>
In-Reply-To: <49BFF0C7.7010001@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Obviously a conversion error while switching to __xn_safe*.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> Well, I have just checked the kernel code, and 0 as a return value of
>> strncpy_from_user is treated as a value in most places, even if not -EFAULT.
>>
> 
> Better check our code: :) __xn_safe_strncpy_from_user works differently.

Then I would tend to consider that xn_safe_strncpy is broken.

-- 
                                                 Gilles.

