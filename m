Message-ID: <491C7089.4020206@domain.hid>
Date: Thu, 13 Nov 2008 19:23:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <491805AE.1060809@domain.hid> <491C6A95.9000802@domain.hid>
	<491C71AD.5010103@domain.hid>
In-Reply-To: <491C71AD.5010103@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mode switch when using RT heap on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Grandegger wrote:
>>> Hello,
>>>
>>> I realized that accessing memory allocated with rt_heap_alloc() causes
>>> mode switches on ARM i.mx31. The attached patch provides a demo program
>>> to demonstrate the problem, which actually does *not* show up on my
>>> PowerPC TQM5200 board.
>> Ok. I ran your test on an ARMv5 using an old version of Xenomai, and I
>> only get a fault on first write to the heap, being either cached or non
>> cached.
>>
>> I will now run the tests on AT91RM9200 with a more recent version of
>> xenomai to confirm that we get the same effect, but if we do, this means
>> that we are facing an armv6 specific issue and that for a workaround, we
>> need to understand armv6 memory management.
> 
> The problem seems to be more general. I have now use the TLSF allocator
> from Xenomai-solo for dynamic memory allocation and I still see the mode
> switch counter increasing. Again, no problems on my TQM5200 PowerPC
> board. I have the impression that the problems are related to armv6.

That is because you do unaligned accesses, on ARM they generate faults.

-- 
                                                 Gilles.

