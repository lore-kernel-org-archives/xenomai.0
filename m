Message-ID: <4721A628.6040908@domain.hid>
Date: Fri, 26 Oct 2007 10:32:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4720F828.1030200@domain.hid>
	<4720FB07.10606@domain.hid>	<4720FE77.2020302@domain.hid>
	<47210488.9060908@domain.hid>
In-Reply-To: <47210488.9060908@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Proposed arch/powerpc/sysdev/uic.c patch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Steven A. Falco wrote:
>>>> I applied the uic patch:
>>>>
>>>> diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
>>>> index eeb38e2..5a38086 100644
>>>> --- a/arch/powerpc/sysdev/uic.c
>>>> +++ b/arch/powerpc/sysdev/uic.c
>>>> @@ -48,7 +48,7 @@ struct uic {
>>>>     int index;
>>>>     int dcrbase;
>>>>
>>>> -    spinlock_t lock;
>>>> +    ipipe_spinlock_t lock;
>>>>
>>>>     /* The remapper for this UIC */
>>>>     struct irq_host    *irqhost;
>>>>
>>>> However, this would not compile because of a type mismatch.  I have
>>>> added the attached patch, and it now compiles and runs.  But I'm not
>>>> sure if this is the right way to fix it.  Comments?
>>>>
>>> This will work for the purpose of running an I-pipe enabled kernel, but
>>> would fail with CONFIG_IPIPE disabled. Since we need to provide both,
>>> I'm going to work on the proper patch for fixing the issue both ways.
>>> Still, your patch will work as expected for running Xenomai.
>> To be consequent, we would have to wrap spin_lock_init just like the
>> other operations. Suggestion (not really tested):
>>
> 
> Thanks. I have committed a tested variant.

The additional #ifdef CONFIG_IPIPE for spin_lock_init should be
redundant, in theory. What makes it necessary in practice?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

