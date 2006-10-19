Message-ID: <453727F4.5010604@domain.hid>
Date: Thu, 19 Oct 2006 09:23:32 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] BUG: sleeping function called from invalid context
	at kernel/xenomai/skins/posix/syscall.c:272
References: <45366314.5000904@domain.hid> <45367E43.5020208@domain.hid>
In-Reply-To: <45367E43.5020208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> when I start the RT-Socket-CAN program rtcan_rtt.c, I get the attached
>> error message. Any idea where the problem could be? It was working with
>> Xenomai under Linux 2.4.25.
>>
>> Thanks.
>>
>> Wolfgang.
>>
>>
>>
>> ------------------------------------------------------------------------
>>
>> bash-3.00# rtcan_rtt rtcan0 rtcan1
>> BUG: sleeping function called from invalid context at kernel/xenomai/skins/posix/syscall.c:272
>> in_atomic():0, irqs_disabled():1
> 
> Leaking lock somewhere? Some suggestions:
> 
> - Does it also happen with rtcan_virt?
> - If no: switch on XENO_OPT_DEBUG and then XENO_OPT_DEBUG_RTDM (may
>   catch leaking locks of the CAN driver)
> - If yes: what arch are you on? PPC? On x86/2.6 I do not have problems
>   with your demo over rtcan_virt.

Thanks for the hints. I will continue testing later today on my MPC5200 
(PPC).

Wolfgang.


