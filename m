Message-ID: <4B95356E.8060408@domain.hid>
Date: Mon, 08 Mar 2010 18:35:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.4536.1268063545.8399.xenomai-git@xenomai.org>
	<4B9533D9.7050203@domain.hid>
In-Reply-To: <4B9533D9.7050203@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] posix: fix pthread_cond_*wait
	return value overwriting
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
>> diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
>> index 6c3ec3a..2a97a2d 100644
>> --- a/ksrc/skins/posix/syscall.c
>> +++ b/ksrc/skins/posix/syscall.c
>> @@ -1520,7 +1520,7 @@ static int __pthread_cond_wait_prologue(struct pt_regs *regs)
>>  	union __xeno_mutex mx, *umx;
>>  	unsigned timed, count;
>>  	struct timespec ts;
>> -	int err;
>> +	int err, perr = 0;
>>  
>>  	ucnd = (union __xeno_cond *)__xn_reg_arg1(regs);
>>  	umx = (union __xeno_mutex *)__xn_reg_arg2(regs);
>> @@ -1560,7 +1560,10 @@ static int __pthread_cond_wait_prologue(struct pt_regs *regs)
>>  						    &mx.shadow_mutex,
>>  						    &count, timed, XN_INFINITE);
>>  
>> -	if (err == 0 || err == ETIMEDOUT) {
>> +	switch(err) {
>> +	case 0:
>> +	case ETIMEDOUT:
>> +		perr = errno = err;
>>  		err = -pse51_cond_timedwait_epilogue(cur, &cnd.shadow_cond,
>>  					    	    &mx.shadow_mutex, count);
>>  		if (err == 0 &&
>> @@ -1569,14 +1572,20 @@ static int __pthread_cond_wait_prologue(struct pt_regs *regs)
>>  					   &mx.shadow_mutex.lockcnt,
>>  					   sizeof(umx->shadow_mutex.lockcnt)))
>>  			return -EFAULT;
>> +		break;
>> +
>> +	case EINTR:
>> +		perr = err;
> 
> Minor cleanup: This is not needed as err != 0, so perr will not be
> evaluated anymore. Same for native.

No, err may be 0, if the epilogue returns 0.

The following table should explains how I came to this solution:

perr		err		wanted		err == 0 ? perr : err
0		0		0          	0
0		EINTR		EINTR      	EINTR
0		*		*          	*
ETIMEDOUT  	0		ETIMEDOUT  	ETIMEDOUNT
ETIMEDOUT  	EINTR		EINTR      	EINTR
		    	  (epi ETIMEDOUT)
ETIMEDOUT  	*		*		*
EINTR	   	-(perr)		EINTR      	EINTR
*	   	-(perr)		*		*


-- 
					    Gilles.

