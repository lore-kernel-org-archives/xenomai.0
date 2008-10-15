Message-ID: <48F60EB2.9050100@domain.hid>
Date: Wed, 15 Oct 2008 17:39:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <373456.66216.qm@domain.hid>
In-Reply-To: <373456.66216.qm@domain.hid>
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
>> rtdm_printk (read 'k' as 'kernel') is for driver development in kernel
>> space only.
>>
>> What you are looking for is rt_printf from the rtdk lib. See related
>> example (examples/native/rtprint.c).
> 
> At kernel level I usually write defines like this
> 
> #define DBG_PRINTF(expr...) \
>   if (rtdm_in_rt_context()) \
>     rtdm_printk(expr); \
>   else if (kdb_on) \
>     printk(expr)
> 
> to manage xenomai and linux output for debugging.
> Is there something like rtdm_in_rt_context for the user space?

In both domains, this differentiation is unneeded.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

