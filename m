Message-ID: <444509F1.5090107@domain.hid>
Date: Tue, 18 Apr 2006 17:46:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Check for NPTL and factor user-space skins
	initialization.
References: <17476.64062.107556.216362@domain.hid>
	<44450359.2090203@domain.hid>
In-Reply-To: <44450359.2090203@domain.hid>
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
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
> Gilles Chanteperdrix wrote:
> 
>> For review...
>>
>>  
>>
>> +#ifndef __KERNEL__
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +
>> +static inline void xeno_x86_features_check(void)
>> +{
>> +#ifdef CONFIG_XENO_X86_SEP
>> +  size_t n = confstr(_CS_GNU_LIBPTHREAD_VERSION, NULL, 0);
>> +  if (n > 0)
>> +      {
>>
>>   
> 
> since this is user code, its possible to read /proc/cpuinfo,
> and find the sep flag.
> 
> Is this worth doing also ?

Some deeply embedded stuff (something like buried in the silicon 
actually...) might configure out CONFIG_PROC_FS, so we can't rely on 
this pseudo-fs to be always present.

> if so, I can work a patch up later, unless you feel the urge.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

