Message-ID: <4926D702.9080409@domain.hid>
Date: Fri, 21 Nov 2008 16:42:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4926D312.3050707@domain.hid> <4926D3F4.3040207@domain.hid>
	<4926D453.9070900@domain.hid>
In-Reply-To: <4926D453.9070900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] nodiv xnarch_ns_to_tsc for x86-64
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
>>> Hi Gilles,
>>>
>>> I assumed you armed nodiv ns-to-tsc for x86-64, given that the services
>>> are in place now. But my test case just crashed another box even though
>>> latest SVN was installed. Any reason for not converting yet?
>> Yes, I only tested the routine performance, not tested xenomai running
>> on it.  I am in the middle of a reorganization of my test boxes, which
>> is taking more time than I initially thought, so could not test the
>> routine as soon as I would have liked.
> 
> Ah, ok. What's the rough schedule (few days, a week, ...)? And will you
> also take care of the 32-bit case or should I have a look?

Probably by the end of the week. And yes, I will take care of the 32
bits case. In fact, my plan is to have XNARCH_WANT_NODIV_MULDIV on all
architectures so that I can use this for the posix division needed to
convert between nanoseconds and timespecs or timevals.

Actually, I compiled the 32 bits version (just implementing
rthal_add96and64, and using the generic implementation of the nodiv
routine), but the result is just plain ugly, cluttered with many moves
between registers and stack, probably due to the lack of registers on
x86 coupled with gcc doing a really bad job at allocating registers.

If you really want to avoid the fault in the division, you can also
modify x86 div96by32 so that it does 3 64/32 divisions instead of 2.

-- 
                                                 Gilles.

