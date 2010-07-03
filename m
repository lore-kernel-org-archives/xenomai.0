Message-ID: <4C2F9028.7010406@domain.hid>
Date: Sat, 03 Jul 2010 21:31:52 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
	<1278071353-13836-5-git-send-email-wolfgang.mauerer@domain.hid>
	<4C2F25C1.3050801@domain.hid>
In-Reply-To: <4C2F25C1.3050801@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 4/7] nucleus: Add CLOCK_HOST_REALTIME
 bits to	nkvdso
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Mauerer wrote:
>> Augment the shared vdso page with all data required to
>> implement a clock CLOCK_HOST_REALTIME that provides time
>> information synchronised with the NTP-corrected time
>> in the Linux kernel.
>>
>> The definition of the hostrt data is placed in a separate
>> head file so that we can use it irregardless of pervasive
>> rt support is compiled in or not.
> 
> Ok. Would not it be more simple to define the nkvdso even without
> pervasive support?

Thought about that, but having a shared kernel/userland object
without pervasive RT support seemed a bit unnatural to me.
> 
>> +#if defined(CONFIG_XENO_OPT_HOSTRT) && !defined(CONFIG_XENO_OPT_PERVASIVE)
>> +	nkhostrt_data = xnarch_alloc_host_mem(sizeof(struct xnarch_hostrt_data));
> 
> should be sizeof(*nkhostrt_data)
> 
> But why a dynamic allocation at all?

not really required, can also make it static if you prefer.

Best regards, Wolfgang

