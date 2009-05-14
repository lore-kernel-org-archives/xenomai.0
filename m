Message-ID: <4A0C06DD.90104@domain.hid>
Date: Thu, 14 May 2009 13:56:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A0AC1C8.4050006@domain.hid>
	<4A0AC3F9.9090103@domain.hid>	<4A0AC8A6.1000701@domain.hid>	<1242220962.26544.955.camel@domain.hid>	<4A0AE726.5090107@domain.hid>	<Pine.LNX.4.64.0905131152460.1027@domain.hid>
	<4A0BF3A2.2040903@domain.hid>
In-Reply-To: <4A0BF3A2.2040903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Fix host IRQ propagation
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
> Martin Shepherd wrote:
>> On Wed, 13 May 2009, Jan Kiszka wrote:
>>> ...
>>> Martin, could you check if this helps you, too?
>> It doesn't appear to help. To check, first I turned on the HPET and PM
>> timer options, and recompiled the kernel without your patch, to verify
>> that this reproduced the problem. I then manually applied your patch
>> to include/asm-generic/xenomai/hal.h in the kernel source tree,
>> recompiled the kernel, installed etc, and rebooted. However even with
>> the patch in place, whenever I ran:
>>
>>   dd if=/dev/zero of=/dev/null count=20000000
>>
>> then initially top showed that dd was getting very little CPU time
>> (<10%), then after 30 seconds or so, the system became completely
>> unresponsive until the dd ended. This is how it acts without the patch
>> as well. So it doesn't appear that the patch has made any difference
>> to this problem.
> 
> Hmm, so there is no Xenomai task running during this test, just Linux
> load? Tried to reproduce with my kernel here (both HPET and PM enabled,
> as usual), but no success. Strange.

Just having HPET and PM_TIMER enabled is not enough: your CPU needs to
actually have an HPET timer or PM timer.

-- 
                                                 Gilles.

