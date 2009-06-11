Message-ID: <4A30D3CD.8050908@domain.hid>
Date: Thu, 11 Jun 2009 13:52:13 +0400
From: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
MIME-Version: 1.0
References: <4A30CB83.5080504@domain.hid> <4A30CF49.8010007@domain.hid>
In-Reply-To: <4A30CF49.8010007@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] ksrc: respect struct proc_dir_entry
	changes in 2.6.30
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan,
I observed that LINUX_VERSION_CODE comparisons are common enough in
Xenomai code. Do you propose to make a separate header, which is
included from nucleus, drivers and arch files?

--
With best wishes,
Vladimir


Jan Kiszka wrote:
> Hi Vladimir,
> 
> Vladimir Zapolskiy wrote:
>> Hello,
>>
>> please apply the attached simple patch, which resolves a kind of
>> compilation problems against 2.6.30 kernel.
>>
>> -- 
>> With best wishes,
>> Vladimir 
>>
>> From 894660f7dc91b406d8e078247b46606778562de9 Mon Sep 17 00:00:00 2001
>> From: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
>> Date: Thu, 11 Jun 2009 12:32:00 +0400
>> Subject: [PATCH] Made conditional inclusion of owner field in struct proc_dir_entry due to changes in 2.6.30
>>
>> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>
>> ---
>>  ksrc/arch/generic/hal.c              |    6 ++++++
>>  ksrc/drivers/comedi/device.c         |    2 ++
>>  ksrc/drivers/comedi/rtdm_interface.c |    4 ++++
>>  ksrc/nucleus/registry.c              |    2 ++
>>  4 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/ksrc/arch/generic/hal.c b/ksrc/arch/generic/hal.c
>> index e4f0f31..b983b68 100644
>> --- a/ksrc/arch/generic/hal.c
>> +++ b/ksrc/arch/generic/hal.c
>> @@ -738,7 +738,9 @@ struct proc_dir_entry *rthal_add_proc_leaf(const char *name,
>>  	entry->data = data;
>>  	entry->read_proc = rdproc;
>>  	entry->write_proc = wrproc;
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
>>  	entry->owner = THIS_MODULE;
>> +#endif
> 
> I would suggest to squeeze all these assignments into a helper function
> that is void from 2.6.30 on, hiding the #ifdefs
> 
> Jan
> 

