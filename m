Message-ID: <48D8AC60.3020908@domain.hid>
Date: Tue, 23 Sep 2008 10:44:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CE7BD7.6060504@domain.hid>
	<48D620DB.2070101@domain.hid>	<48D688EE.7010404@domain.hid>
	<48D68D6D.9070909@domain.hid> <48D69A7A.7090302@domain.hid>
	<48D752BA.3000403@domain.hid> <48D754D8.30205@domain.hid>
	<48D75DE5.9020805@domain.hid> <48D7E6E7.9050302@domain.hid>
In-Reply-To: <48D7E6E7.9050302@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH] Factor out xnsynch_acquire/release
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
>>>>>
>>>>>> [1]http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/5412/focus=5405
>>>>>>
>>>>> always-put-xnthread-base-into-registry.patch:
>>>>> 	I understand the need, but I will cowardly let Philippe decide whether
>>>>> he likes the implementation details.
>>>>>
>>>>> handle-base-xn_sys_current-1.patch:
>>>>> 	In some places (pse51_mutex_timedlock_inner for instances) you use
>>>>> XN_NO_HANDLE, in others (pse51_mutex_timedlock for instances) you use
>>>>> NULL, are the two equivalents ? If yes, should not we always use the
>>>>> same consistently ? Otherwise looks ok.
>>>> I fail to find the NULL spots - which pse51_mutex_timedlock do you mean?
>>> A few excerpts:
>> Ah, you mean checking against non-zero - that can be changed of course.
>> Updated patch below, hope I caught them all.
> 
> Ok. Looks good to me. Minus the bug in mutex_save_count, but this can be
> changed later.

??? Which bug?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

