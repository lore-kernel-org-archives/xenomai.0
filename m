Message-ID: <4B0183FB.6030400@domain.hid>
Date: Mon, 16 Nov 2009 17:55:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1NA3bT-0002c1-7v@domain.hid> <4B01792A.4090206@domain.hid>
	<4B017F7A.4090409@domain.hid> <4B0180A6.80207@domain.hid>
In-Reply-To: <4B0180A6.80207@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Include all
	heaps in statistics
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
>>> GIT version control wrote:
>>>> +void xnheap_set_label(xnheap_t *heap, const char *label, ...)
>>>> +{
>>>> +	va_list args;
>>>> +	spl_t s;
>>>> +
>>>> +	va_start(args, label);
>>>> +
>>>> +	xnlock_get_irqsave(&nklock, s);
>>>> +	vsnprintf(heap->label, sizeof(heap->label), label, args);
>>>> +	xnlock_put_irqrestore(&nklock, s);
>>> Why do we need locking here ?
>>>
>> We already registered the heap, so I want to avoid that someone dumping
>> /proc sees an inconsistent string - or even an unterminated one.
> 
> There are other ways to avoid that, but, I am over-reacting to printf.
> But it is not really a printf, it is an snprintf, which is not that heavy.

Right, this was a lazy approach due to the fact that we call snprintf
under nklock already.

Jan

PS: I just force-updated my queue for a cosmetic change
("unlabeled (%p)" -> "unlabeled @0x%p").

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

