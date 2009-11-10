Message-ID: <4AF96B35.4060102@domain.hid>
Date: Tue, 10 Nov 2009 14:31:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AF8A72E.1060204@domain.hid> <4AF8B50E.4010900@domain.hid>	
	<1257848915.2210.487.camel@domain.hid>	
	<4AF943BD.3020808@domain.hid>	
	<1257850543.2210.494.camel@domain.hid>	
	<4AF94F70.9060602@domain.hid>
	<1257859579.2210.599.camel@domain.hid>
In-Reply-To: <1257859579.2210.599.camel@domain.hid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] hal: Ensure atomicity of
	rthal_local_irq_disabled
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Tue, 2009-11-10 at 12:33 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Tue, 2009-11-10 at 11:43 +0100, Jan Kiszka wrote:
>> [...]
>>>> Oh, *_hw_smp is new, isn't it? Do we need to wrap it for older I-pipes?
>>> Yes, it was introduced to solve the SMP migration issue actually, so we
>>> need a wrapper. The advantage of having that wrapper instead of going
>>> for inlined #ifdef CONFIG_SMP is that I could simply get rid of that
>>> wrapper in 3.x, since all legacy pipeline patches would be deprecated
>>> there anyway.
>> Something like this, or where to put the wrapper?
>>
> 
> Better move it to asm-generic/hal.h like other i-pipe related
> conditionals.

OK, pushed a corresponding version.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

