Message-ID: <4B6B0158.10702@domain.hid>
Date: Thu, 04 Feb 2010 18:18:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1Nd53b-0001k7-Np@domain.hid> <4B6AFF4A.2010705@domain.hid>
In-Reply-To: <4B6AFF4A.2010705@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : RTDM: Split up
 application and driver debugging
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> GIT version control wrote:
>> Module: xenomai-jki
>> Branch: for-upstream
>> Commit: 134378c9ff2bc597aaa908564323afb744cbbf01
>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=134378c9ff2bc597aaa908564323afb744cbbf01
>>
>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>> Date:   Thu Feb  4 17:55:36 2010 +0100
>>
>> RTDM: Split up application and driver debugging
>>
>> There are use cases where you prefer to leave driver-level debugging
>> checks on while preventing that user space can flood the log via unclean
>> terminations. Split up the RTDM debug switch to reflect this.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>
>> ---
>>
>>  ksrc/skins/rtdm/Kconfig |    9 +++++++++
>>  ksrc/skins/rtdm/core.c  |    2 +-
>>  2 files changed, 10 insertions(+), 1 deletions(-)
>>
>> diff --git a/ksrc/skins/rtdm/Kconfig b/ksrc/skins/rtdm/Kconfig
>> index 5eeb2f3..f0741d6 100644
>> --- a/ksrc/skins/rtdm/Kconfig
>> +++ b/ksrc/skins/rtdm/Kconfig
>> @@ -55,4 +55,13 @@ config XENO_OPT_DEBUG_RTDM
>>  	It is a recommended option for analysing potential issues in RTDM
>>  	drivers. A minor runtime overhead is added.
>>  
>> +config XENO_OPT_DEBUG_RTDM_APPL
>> +	bool "RTDM application debugging support"
>> +	depends on XENO_OPT_DEBUG
>> +	default y
>> +	help
>> +
>> +	When enabled, this option makes the RTDM skin warn about
>> +	auto-clean operations executed upon application termination.
>> +
>>  endif
>> diff --git a/ksrc/skins/rtdm/core.c b/ksrc/skins/rtdm/core.c
>> index bc3dccc..3bc13f1 100644
>> --- a/ksrc/skins/rtdm/core.c
>> +++ b/ksrc/skins/rtdm/core.c
>> @@ -396,7 +396,7 @@ void cleanup_owned_contexts(void *owner)
>>  		xnlock_put_irqrestore(&rt_fildes_lock, s);
>>  
>>  		if (context) {
>> -			if (XENO_DEBUG(RTDM))
>> +			if (XENO_DEBUG(RTDM_APPL))
>>  				xnprintf("RTDM: closing file descriptor %d.\n",
>>  					 fd);
> 
> Are you sure you are not missing a hunk like this ?
> #ifndef CONFIG_XENO_OPT_DEBUG_RTDM_APPL
> #define CONFIG_XENO_OPT_DEBUG_RTDM_APPL        0
> #endif /* CONFIG_XENO_OPT_DEBUG_RTDM_APPL */
> 

Of course - I wonder who designed this... :)

Just pushed v2.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

