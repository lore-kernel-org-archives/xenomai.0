Message-ID: <4B17BF4E.7080509@domain.hid>
Date: Thu, 03 Dec 2009 14:38:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B1663B9.8030306@domain.hid>	<4B166A5B.6030400@domain.hid>	<4B166EFB.8050309@domain.hid>	<4B16769A.9060700@domain.hid>	<4B167A55.8080407@domain.hid>	<4B167B4B.3010804@domain.hid>
	<4B167FC4.8080904@domain.hid>	<4B1681DA.3090108@domain.hid>
	<4B1684D7.2080501@domain.hid>	<4B1690EC.8030002@domain.hid>
	<4B16949B.2040806@domain.hid> <4B169CF7.2060108@domain.hid>
	<4B16D403.1070202@domain.hid> <4B16E417.3000400@domain.hid>
	<4B16E813.6050906@domain.hid>
	<36FCBE44-88E0-4AAA-9E83-1A9F9AB3F5D9@domain.hid>
	<4B17980A.3060503@domain.hid> <4B17B8E6.1060108@domain.hid>
	<4B17B9B1.3070606@domain.hid>
	<F41A4C16-8EF2-4B29-B79D-4549F0106D37@domain.hid>
In-Reply-To: <F41A4C16-8EF2-4B29-B79D-4549F0106D37@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Realtime gettimeofday()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wm@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Wolfgang Mauerer wrote:
> Hi,
> 
> On 03.12.2009, at 14:14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org 
>  > wrote:
> 
>> Wolfgang Mauerer wrote:
>>> Hi,
>>>
>>> Gilles Chanteperdrix wrote:
>>>> Wolfgang Mauerer wrote:
>>>>> So that means, in essence, that you would accept probabilistic
>>>>> algorithms in realtime context?
>>>> Ah, today's troll!
>>> though it seems that I have to replace Jan this time ;-)
>>>> As I think I explained, the use of a seqlock in real-time context  
>>>> when
>>>> the seqlock writer only happens in linux context is not  
>>>> probabilistic.
>>>> It will work every time the first pass.
>>> I still don't see why it should succeed every time: What about
>>> the case that the Linux kernel on CPU0 updates the data, while
>>> Xenomai accesses them on another CPU? This can lead to
>>> inconsistent data, and they must be reread on the Xenomai side.
>> Yeah, right. I was not thinking about SMP. But admit that in this  
>> case,
>> there will be only one retry, there is nothing pathological.
>>
>>> I'm asking because if this case can not happen, then there's
>>> nothing left to to as I have the code already at hand.
>> You have reworked the nucleus timers handling to adapt to this new
>> real-time clock ?
> 
> Nope. Sorry, I was a bit unclear: I'm just referring to the gtod  
> syscall that does the timer handling, Not any other adaptions.

Ok, but what good is the gtod syscall if you can not use it as a time
reference for other timing related services?

-- 
                                          Gilles


