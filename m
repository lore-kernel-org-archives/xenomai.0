Message-ID: <fb449ebaab2d4e71a032af35d5a881b6.squirrel@127.0.0.1>
In-Reply-To: <524E7D5B.5080004@siemens.com>
References: <1380568915-32582-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<524E7D5B.5080004@siemens.com>
Date: Fri, 4 Oct 2013 10:53:53 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH] x86/ipipe: get FPU backup area allocated for
 all threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka wrote:
>> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>> index a00bed1..4716eb2 100644
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -73,14 +73,6 @@ int arch_dup_task_struct(struct task_struct *dst,
>> struct task_struct *src)
>>  		if (ret)
>>  			return ret;
>>  		fpu_copy(dst, src);
>> -	} else {
>> -#ifdef CONFIG_IPIPE
>> -		/* unconditionally allocate, RT domain may need it */
>> -		memset(&dst->thread.fpu, 0, sizeof(dst->thread.fpu));
>> -		ret = fpu_alloc(&dst->thread.fpu);
>> -		if (ret)
>> -			return ret;
>> -#endif
>
> Why removing the systematic allocation? This is not explained above and
> seems counterproductive.

Because when we stop deleting the fpu backup area upon exec, no fork ever
takes place for source thread without an fpu backup area. So, the "else"
clause never happens, and we can remove it entirely.


-- 
                                              Gilles


