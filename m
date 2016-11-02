References: <550719c6-8d3d-1cb1-fc74-d0922b80deb3@siemens.com>
 <3440bd12-2bd3-7c09-1d51-a67853635ad7@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <85f76e95-d6e3-78e9-4401-f14163d6e81b@siemens.com>
Date: Wed, 2 Nov 2016 12:25:09 +0100
MIME-Version: 1.0
In-Reply-To: <3440bd12-2bd3-7c09-1d51-a67853635ad7@xenomai.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] Trying to flushing my queue...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-11-02 11:48, Philippe Gerum wrote:
> On 10/31/2016 04:55 PM, Jan Kiszka wrote:
>> Philippe,
>>
>> The following changes since commit 641827d0c029e3c2cf42cb02fdaa845da98b0619:
>>
>>   rtcan: ems_pci driver update to support more devices (2016-10-30 18:07:19 +0100)
>>
>> are available in the git repository at:
>>
>>   git://git.xenomai.org/xenomai-jki.git for-forge
>>
>> for you to fetch changes up to 8e74b54833473a96e813f787ba34980525dddf02:
>>
>>   boilerplate: Fix enabling Xenomai only in shared libs (2016-10-31 16:40:40 +0100)
>>
>>
>> Sorry in advance if I should have missed addressing some comment given
>> on one or the other patch before - some are now very old because I
>> didn't find the time to go after them. Let's retry.
>>
>> Jan
>>
>> ----------------------------------------------------------------
>> Jan Kiszka (6):
>>       testsuite/smokey: Add test case for setschedparam & Co,
> 
> Ok.
> 
>>       cobalt/kernel: Allow to restart clock_nanosleep and select after signal processing
> 
> Ok with the logic behind this. Implementation-wise,
> cobalt_get_restart_block() is definitely a wrapper, since it allows to
> adapt to changes in the mainline kernel, and/or provide an API which
> does not exist there for something we need.
> 
> For this reason, we don't need asm-generic/xenomai/ancillaries.h,
> asm-generic/xenomai/wrappers.h is the right place to define it.

OK, will change.

> 
>>       lib/cobalt: Provide RT-capable usleep
> 
> Ok.
> 
>>       cobalt/autotune: Rework autotune_ioctl_nrt/rt for more robust request handling
> 
> I replied to this one some time ago:
> http://xenomai.org/pipermail/xenomai/2016-June/036484.html
> 
> Basically, I would rather solve the serialization issue by making sure
> that no application can run while the core system is being calibrated.

Ah, right. I'll check if I can address that quickly.

> 
>>       cobalt/rtdm: Restore return code tracing
> 
> Ok.
> 
>>       boilerplate: Fix enabling Xenomai only in shared libs
> 
> Superseded by #91f7a0c and #82b6325.

Not quite: I had to apply my patch on top of next, otherwise loading
xenomai-dependent libs via dlopen didn't work. Apparently, __real_main
wasn't optimized out in my build, thus main was still pulled.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

