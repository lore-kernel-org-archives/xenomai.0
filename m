Message-ID: <43EB2412.8040704@domain.hid>
Date: Thu, 09 Feb 2006 12:14:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [Combo-PATCH] Shared interrupts (final)
References: <b647ffbd0602070104s63275903q@domain.hid>	<43E86F4D.4050400@domain.hid>	<43E8DFC4.4010805@domain.hid>	<43E9CE95.3070806@domain.hid>
	<43EAFD8B.7020400@domain.hid>
	<43EB1279.3040902@domain.hid> <43EB1741.9080809@domain.hid>
In-Reply-To: <43EB1741.9080809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Anders Blomdell wrote:
>>
>>
>>>My distinct feeling is that the return value should be a scalar and
>>>not a set!
>>>
>>
>>To sum up, the valid return values are HANDLED, HANDLED | ENABLE (*),
>>HANDLED | CHAINED and CHAINED. It's currently a set because I once
>>thought that the "handled" indication (or lack of) could be a valuable
>>information to gather at nucleus level to detect unhandled RT
>>interrupts. Fact is that we currently don't use this information,
> 
> 
> But it is required for the edge-triggered case to detect when the IRQ
> line was at least shortly released. I guess Dmitry introduced that NOINT
> just because HANDLED equals 0 so far. As I would say HANDLED == !NOINT,
> we could avoid this new flag by just making HANDLED non-zero.
> 

Yes, we could. HANDLED is currently zero only because the nucleus does not care of 
the !handled case, yet.

> 
>>though. IOW, we could indeed define some enum and have a scalar there
>>instead of a set; or we could just leave this as a set, but whine when
>>detecting the invalid ENABLE | CHAINED combination.
> 
> 
> In combination with the change above and some doc improvement ("valid
> combinations are: ..."), I could also live with keeping the flags. The
> advantage were that we wouldn't break existing applications.
> 
> 
>>(*) because the handler does not necessary know how to ->end() the
>>current IRQ at IC level, but Xenomai always does.
>>
> 
> 
> Jan
> 


-- 

Philippe.

