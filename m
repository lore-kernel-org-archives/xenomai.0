Message-ID: <4B8C25B9.8090705@domain.hid>
Date: Mon, 01 Mar 2010 21:38:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>	<4B86EDC2.7010905@domain.hid>
	<4B86FCBB.10203@domain.hid>	<4B86FFA0.3000403@domain.hid>
	<4B870134.2040802@domain.hid>	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>	<4B87FC70.90903@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>
	<CF7FB0793253794F9F45991443E5FE2006483DE993@domain.hid>
	<4B8C2490.1040604@domain.hid>
In-Reply-To: <4B8C2490.1040604@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> Charlton, John wrote:
>> I added some printk output to the cond.c file in xenomai-2.5.1 and it shows that  xnsync_sleep_on returned -ETIMEDOUT as it should:
>> Xenomai: registered exported object M1-1908 (mutexes)
>> Xenomai: registered exported object C1-1908 (condvars)
>> xnsynch_sleep_on returned: -110
>> xnsynch_sleep_on returned: -110
>> xnsynch_sleep_on returned: -110
>> xnsynch_sleep_on returned: -110
>> xnsynch_sleep_on returned: -110
>> xnsynch_sleep_on returned: -110
>> xnsynch_sleep_on returned: -4
>> Xenomai: native: cleaning up cond "C1-1908" (ret=0).
>> Xenomai: unregistered exported object C1-1908 (condvars)
>> Xenomai: native: cleaning up mutex "M1-1908" (ret=0).
>> Xenomai: unregistered exported object M1-1908 (mutexes)
>> Xenomai: POSIX: destroyed thread df5a0800
>>
>> I put the printk on line cond.c:433 after err is set in rt_cond_wait_prologue():
>>
>> 	info = xnsynch_sleep_on(&cond->synch_base,
>> 				timeout, timeout_mode);
>> 	if (info & XNRMID)
>> 		err = -EIDRM;	/* Condvar deleted while pending. */
>> 	else if (info & XNTIMEO) {
>> 		err = -ETIMEDOUT;	/* Timeout. */
>>         }
>> 	else if (info & XNBREAK) {
>> 		err = -EINTR;	/* Unblocked. */
>> 	}
>>         printk(KERN_DEBUG "xnsynch_sleep_on returned: %d\n", err);
>>
>> I put a printk in rt_cond_wait_inner() which is called directly by rt_cond_wait() from user mode but did not see the output in the dmesg output for that one.
> 
> One of our problems is the prologue/epilogue split up (both in kernel
> and user space): the epilogue can eat the error code or the prologue,
> including the -ETIMEDOUT.

Ah. My fault. Looks user-space is Ok though. Only kernel-space has a
problem.

> 
> Jan
> 


-- 
					    Gilles.

