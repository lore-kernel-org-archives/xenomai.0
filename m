Message-ID: <4B8C5843.1080907@domain.hid>
Date: Tue, 02 Mar 2010 01:13:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B757217.3060406@domain.hid>	<4B757306.5070102@domain.hid>	<4B7575B9.2060707@domain.hid>	<4B757BC8.7020305@domain.hid>	<4B75802B.1030900@domain.hid>	<4B7581FF.4040304@domain.hid>
	<4B75C4C4.70406@domain.hid>	<4B85272C.5000006@domain.hid>
	<4B8532CA.8020808@domain.hid> <4B8BC874.40309@domain.hid>
	<4B8BC8ED.5010105@domain.hid> <4B8BC996.20009@domain.hid>
In-Reply-To: <4B8BC996.20009@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Yet another ((weak)) bug
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Stefan Kisdaroczi wrote:
>>>>>>> Am 12.02.2010 17:22, schrieb Jan Kiszka:
>>>>>>>> libxnskin or so?
>>>>>>>>
>>>>>>>> Jan
>>>>>>>>
>>>>>>> libxenomai ?
>>>>>> Ok. Let's go for libxenomai. I will try and do that in the next few days.
>>>>>>
>>>>> Already had a chance to look into this?
>>>> No. I was off a few days. I just looked at it in the train, but could
>>>> not test it yet.
>>> If there is anything I can do to help accelerating it, please let me
>>> know. We need to bake a new Xenomai package this week for our customer,
>>> and at some point I need to decide between upstream and my temporary
>>> fix. Upstream is generally preferred - if available.
>> Yes, I have been a bit delayed, but should handle this this week, so as
>> to be ready for a release next week-end.
> 
> Anything in some private branch already?

Ok. Everything pushed. It works on ARM and x86. I have not tested in the
multilib and/or dlopen case, so please test it if you can.

> 
> Jan
> 


-- 
					    Gilles.

