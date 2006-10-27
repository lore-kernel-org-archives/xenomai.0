Message-ID: <45421D05.8080909@domain.hid>
Date: Fri, 27 Oct 2006 16:51:49 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] prepare-kernel.sh
	breaks	linux-2.4	drivers/Makefile
References: <54823def0610261823n4c24b6bal31afd74f3e0d962e@domain.hid>
	<4541B59C.1070402@domain.hid>
In-Reply-To: <4541B59C.1070402@domain.hid>
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
To: Andrew Dennison <andrewd.lists@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
> Andrew Dennison wrote:
>> Running prepare-kernel on the denx 2.4 kernel adds the following line
>>
>> mod-subdirs := xenomai
>>
>> This prevents all other mod-subdirs under drivers from building.
> 
> What does not build. Non-Xenomai drivers as modules? 
>> Patch is against r1273 but still seems to apply (and be required) on 
>> head.
> 
> Going to check it soon.

It's obviously a bug and could cause modules not to get build under 
certain conditions. I was just wondering why I have not already realized 
it in the past.

Thanks.

Wolfgang.

> 
> Thanks.
> 
> Wolfgang.
> 
>> Andrew
>>
>>
>> ------------------------------------------------------------------------
>>
>> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
>> index fbc91ce..ca87e7f 100755
>> --- a/scripts/prepare-kernel.sh
>> +++ b/scripts/prepare-kernel.sh
>> @@ -455,7 +455,7 @@ EOF
>>      patch_ed drivers/Makefile <<EOF
>>  /include \$(TOPDIR)\/Rules.make
>>  i
>> -mod-subdirs := xenomai
>> +mod-subdirs += xenomai
>>  subdir-\$(CONFIG_XENOMAI) += xenomai
>>  
>>  .
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 
> 


