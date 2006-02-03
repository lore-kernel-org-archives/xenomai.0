Message-ID: <43E31B49.8050101@domain.hid>
Date: Fri, 03 Feb 2006 09:58:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] some results on my laptop
References: <43E288AA.3050203@domain.hid>
	<43E28EE8.3020103@domain.hid>	<43E2A31D.9000807@domain.hid>
	<43E30B8D.6030507@domain.hid> <43E31186.1000007@domain.hid>
	<43E313BF.2010104@domain.hid>
In-Reply-To: <43E313BF.2010104@domain.hid>
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
> Jan Kiszka wrote:
> 
>>...
>>What about other time sources on x86? Which systems already have HPET
>>these days, and does this source not suffer from frequency scaling? I
>>once read that HPET is quite easy to program, is this true? IOW, would
>>it be worth considering to add this to the HAL?
> 
> 
> There are actually only few registers:
> 
> http://www.intel.com/hardwaredesign/hpetspec_1.pdf
> 
> Even a replacement for the TSC is available ("Main Counter"), but I
> guess that some effort will be required to replace all direct usages of
> rdtsc in the current Xenomai code, right?
>

There should not be any direct usage, at least into the generic code, since it is 
aimed at running over the event-driven simulator too. Actually, the same goes for 
the x86-specific code, since we do support using the 8254 as an alternative to the 
TSC.

> Jan
> 


-- 

Philippe.

