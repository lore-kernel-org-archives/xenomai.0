Message-ID: <4DDBB82D.6040803@domain.hid>
Date: Tue, 24 May 2011 15:52:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DDA66CF.2010307@domain.hid> <4DDB349B.5030209@domain.hid>
	<4DDB76C6.2090008@domain.hid> <4DDB7B3D.2030607@domain.hid>
	<4DDB7C2C.4030206@domain.hid> <4DDB8136.10506@domain.hid>
	<4DDB8A1D.4050704@domain.hid> <4DDB8B5F.9070906@domain.hid>
	<4DDBA341.6060009@domain.hid> <4DDBA4D6.5070106@domain.hid>
In-Reply-To: <4DDBA4D6.5070106@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL] native: Fix msendq fastlock leakage
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 2011-05-24 14:30, Gilles Chanteperdrix wrote:
>>>>>> Do you already have an idea how to get that info to the delete hook
>>>>>> function?
>>>>>
>>>>> Yes. We start by not applying the list reversal patch, then the sys_ppd
>>>>> is the first in the list. So, we can, in the function ppd_remove_mm,
>>>>> start by removing all the others ppd, then remove the sys ppd (that is
>>>>> the first), last. This changes a few signatures in the core code, a lot
>>>>> of things in the skin code, but that would be for the better...
>>>>
>>>> I still don't see how this affects the order we use in
>>>> do_taskexit_event, the one that prevents xnsys_get_ppd usage even when
>>>> the mm is still present.
>>>
>>> The idea is to change the cleanup routines not to call xnsys_get_ppd.
>>
>> ...and use what instead? Sorry, I'm slow today.
> 
> The sys_ppd passed as other argument to the cleanup function.

That would affect all thread hooks, not only the one for deletion. And
it would pull in more shadow-specific bits into the pod.

Moreover, I think we would still be in troubles as mm, thus ppd,
deletion takes place before last task deletion, thus taskexit hook
invocation. That's due to the cleanup ordering in the kernel's do_exit.

However, if you have a patch, I'd be happy to test and rework my leakage
fix.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

