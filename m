From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <132c37c.bd80.1276c73c215.Coremail.robert165@domain.hid>
References: <4C2CF9F5.7000408@domain.hid>
	<bcc5a9cc1002071243i27ed36a9k38152e5d29034ad4@domain.hid>
	<132c37c.bd80.1276c73c215.Coremail.robert165@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Mar 2010 17:19:47 +0100
Message-ID: <1268842787.27899.336.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Sleep in rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: robert165 <robert165@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Wed, 2010-03-17 at 22:07 +0800, robert165 wrote:
> Hi everyone!
> 
> I'm writing a gpio driver in RTDM. I start it with the demo "Hard real
> time RTDM driver skeleton v1.1" of Jan Kiszka.
> If I used rtdm_task_sleep in rt_ioctrl  function,  it return that
> "Xenomai: assertion failed at kernel/xenomai/skins/rtdm/drvlib.c:372
> (!xnpod_unblockable_p())"  when running.
> It is said that rtdm_task_sleep can be called from Kernel-based task.
> Why I can't use it in my driver. Optionally, I can do this in
> user-space by periodic calling the driver, but it seems slower than in
> kernel space.

I'm puzzled: what does "slower" mean, regarding what operation?

>  
> Thank you very much!
>  
> Best regards
>  
> Luo
>  
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



