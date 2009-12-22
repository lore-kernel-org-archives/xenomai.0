Message-ID: <4B30B231.3080705@domain.hid>
Date: Tue, 22 Dec 2009 12:49:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1261411260-839-1-git-send-email-wolfgang.mauerer@domain.hid>
	<4B30958D.6060108@domain.hid>
In-Reply-To: <4B30958D.6060108@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Add support for sharing kernel/userland
 data	between Xenomai and Linux
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: wolfgang.mauerer@domain.hid
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> wolfgang.mauerer@domain.hid wrote:
>> +/*
>> + * We re-use the global semaphore heap to provide a multi-purpose shared
>> + * memory area between Xenomai and Linux - for both kernel and userland
>> + */
>> +void __init xnheap_init_shared(void)
>> +{
>> +	xnshared = (struct xnshared *)xnheap_alloc(&__xnsys_global_ppd.sem_heap,
>> +						  sizeof(struct xnshared));

Also:

Xenomai style: s/sizeof(struct xnshared)/sizeof(*xnshared)/

-- 
					    Gilles.

