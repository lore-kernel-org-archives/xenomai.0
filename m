Subject: Re: [PATCH] arm64/ipipe: Add support for userspace return notifier
References: <e8d943ee-1103-07ec-bede-c36b4a06c745@siemens.com>
 <1692186.oXRrdl6OMX@omoikane>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1b138a5d-3b5f-07da-6f22-8ce74a04df93@siemens.com>
Date: Wed, 9 Oct 2019 07:22:14 +0200
MIME-Version: 1.0
In-Reply-To: <1692186.oXRrdl6OMX@omoikane>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "steven.seeger flightsystems.net" <steven.seeger@flightsystems.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09.10.19 03:00, steven.seeger flightsystems.net wrote:
> On Tuesday, October 8, 2019 12:55:36 PM EDT Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This adds the arm64-specific bits to implement the userspace return
>> notifier.
>>
>> @@ -954,8 +954,23 @@ finish_ret_to_user:
>>  	enable_step_tsk x1, x2
>>  #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>>  	bl	stackleak_erase
>> +#endif
>> +#ifdef CONFIG_IPIPE
>> +	ldr	x0, [tsk, #TSK_TI_IPIPE]
>> +	tst	x0, #_TIP_USERINTRET
>> +	b.ne	call_user_intret_notifier
>> +exit_head:
> 
> Shouldn't exit_head: be a few lines up where work is checked? In other 
> patches, it seems _TIF_WORK_MASK is checked again after 
> ipipe_notify_user_intreturn returns 0.

It is if you look below:

> 
>>  #endif
>>  	kernel_exit 0
>> +#ifdef CONFIG_IPIPE
>> +call_user_intret_notifier:
>> +	enable_daif
>> +	bl     	__ipipe_notify_user_intreturn
>> +	disable_daif
>> +	cmp    	x0, #0
>> +	b.ne    exit_head
>> +	b	ret_to_user_noirq

When __ipipe_notify_user_intreturn returns 0, we go back to
ret_to_user_noirq, and that checks again. I think I inverted the jump
ordering here, compared to ARM.

Jan

>> +#endif
>>  ENDPROC(ret_to_user)
>>
>>  /*
> 
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

