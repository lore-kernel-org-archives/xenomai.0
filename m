Message-ID: <4E0323A7.2040107@domain.hid>
Date: Thu, 23 Jun 2011 13:29:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E0264CE.9060508@domain.hid> <4E02ED7E.7040204@domain.hid>
	<4E0301C4.8080605@domain.hid> <4E0302B3.3090201@domain.hid>
In-Reply-To: <4E0302B3.3090201@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RFC: use a pool of pre-allocated buffers in
	rt_printf
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/23/2011 11:09 AM, Jan Kiszka wrote:
> On 2011-06-23 11:05, Gilles Chanteperdrix wrote:
>> On 06/23/2011 09:38 AM, Jan Kiszka wrote:
>>>> +#ifdef CONFIG_XENO_FASTSYNCH
>>>> +	if (xeno_get_current() != XN_NO_HANDLE &&
>>>> +	    !(xeno_get_current_mode() & XNRELAX) && buf_pool_get()) {
>>>> +		struct print_buffer *old;
>>>> +
>>>> +		old = buf_pool_get();
>>>> +		while (old != buffer) {
>>>> +			buffer = old;
>>>> +			old = buf_pool_cmpxchg(buffer, buffer->pool_next);
>>>
>>> Though unlikely, it's still possible: The buffer obtained in the last
>>> round may have been dequeued meanwhile and then freed (in case a third
>>> buffer was released to the pool, filling it up to pool_capacity).
>>
>> I do not get it: it seems to me that if the current head (that is
>> buf_pool_get()) is freed, then the cmpxchg will fail, so we will loop
>> and try again.
> 
> Problematic is the dereferencing of the stale buffer pointer obtained
> during the last cmpxchg or via buf_pool_get. This happens before the new
> cmpxchg.

Ok. Got it, that would be a problem only if the stale pointer pointed to
an unmapped area, but ok, better avoid freeing the buffers. I guess it
would not be a problem as applications tend to have a fixed number of
threads anyway.

-- 
                                                                Gilles.

