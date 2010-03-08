Message-ID: <4B952D6C.4060006@domain.hid>
Date: Mon, 08 Mar 2010 18:01:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.4538.1268063562.8399.xenomai-git@xenomai.org>
	<4B952AC1.5070106@domain.hid>
In-Reply-To: <4B952AC1.5070106@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] common: modify leak warning
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
> xenomai-git-request@domain.hid wrote:
>> diff --git a/src/skins/common/current.c b/src/skins/common/current.c
>> index 7277189..5d418a4 100644
>> --- a/src/skins/common/current.c
>> +++ b/src/skins/common/current.c
>> @@ -29,8 +29,6 @@ static inline unsigned long *create_current_mode(void)
>>  
>>  static inline void free_current_mode(unsigned long *mode) { }
>>  
>> -#define XENO_MODE_LEAK_WARNING ""
>> -
>>  #else /* !HAVE___THREAD */
>>  
>>  pthread_key_t xeno_current_key;
>> @@ -56,8 +54,9 @@ static inline void free_current_mode(unsigned long *mode)
>>  }
>>  
>>  #define XENO_MODE_LEAK_WARNING \
>> -	"         To reduce the probality, we leak a few bytes of heap " \
>> -	"per thread.\n"
>> +	"Xenomai: WARNING, this version of Xenomai kernel is anterior to" \
>> +	" 2.5.2.\nIn order to avoid getting memory corruption, we leak 4" \
>> +	" bytes per thread.\nUpgrade is recommended.\n"
>>  
>>  #endif /* !HAVE___THREAD */
>>  
>> @@ -70,20 +69,18 @@ static void cleanup_current_mode(void *key)
>>  
>>  	err = XENOMAI_SYSCALL0(__xn_sys_drop_u_mode);
>>  
>> -	if (err) {
>> +	if (!err)
>> +		free_current_mode(mode);
>> +#ifdef XENO_MODE_LEAK_WARNING
>> +	else {
>>  		static int warned;
>>  
>>  		if (!warned) {
>>  			warned = 1;
>> -			fprintf(stderr,
>> -				"\nXenomai: WARNING, this Xenomai kernel can "
>> -					"cause spurious application\n"
>> -				"         crashes on thread termination. "
>> -					"Upgrade is highly recommended.\n%s\n",
>> -				XENO_MODE_LEAK_WARNING);
>> +			fprintf(stderr, XENO_MODE_LEAK_WARNING);
>>  		}
>> -	} else
>> -		free_current_mode(mode);
>> +	}
>> +#endif /* XENO_MODE_LEAK_WARNING */
>>  }
>>  
>>  static void init_current_keys(void)
>>
> 
> This no longer issues a warning for the __thread case. We might have
> been lucky that there was no issue in practice, but are we sure? That
> was my motivation to warn about both scenarios.

No, you are right. I got all mixed up. I assumed that since we were
setting the current_mode to an invalid state, we were safe. But
obviously, this does not work with the older kernel-space support.

-- 
					    Gilles.

