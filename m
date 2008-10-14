Message-ID: <48F472B2.7050302@domain.hid>
Date: Tue, 14 Oct 2008 12:21:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <621300.75012.qm@domain.hid>
In-Reply-To: <621300.75012.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] trap exceptions in user
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Gabriele Moabiti wrote:
>>>> You should trace the exception path in the I-pipe patch to find the
>>>>  point where your exception handling callback is not called.
>>> will it be a large print work or there are another ways to do that?
>>> :)
>> Yes, a small printk works. There is not that much code involved.
> 
> I have found the problem.
> I used a printf some instructions before the call to the asm blob.
> Once removed seems to work as expected.
> I've seen also that writing
>       printf(expr); \
>       rt_task_set_mode(0, T_PRIMARY, 0);
> it works (I think printf does a switch to secondary domain).
> Now I should use a user-space-no-problem print like rtdm_printk in kernel space.
> The docs says rtdm_in_rt_context and rtdm_printk are avalaible but in the rtdm.h
> there is no trace of them and I can't use rtdm_driver.h 'cause it's kernel only...

rtdm_printk (read 'k' as 'kernel') is for driver development in kernel
space only.

What you are looking for is rt_printf from the rtdk lib. See related
example (examples/native/rtprint.c).

Jan


-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

