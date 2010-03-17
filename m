Message-ID: <4BA0EFBD.4040500@domain.hid>
Date: Wed, 17 Mar 2010 16:05:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C2CF9F5.7000408@domain.hid>	<bcc5a9cc1002071243i27ed36a9k38152e5d29034ad4@domain.hid>
	<132c37c.bd80.1276c73c215.Coremail.robert165@domain.hid>
In-Reply-To: <132c37c.bd80.1276c73c215.Coremail.robert165@domain.hid>
Content-Type: text/plain; charset=x-gbk
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

robert165 wrote:
> Hi everyone!
> 
> I'm writing a gpio driver in RTDM. I start it with the demo "Hard real time RTDM driver skeleton v1.1" of Jan Kiszka.
> If I used rtdm_task_sleep in rt_ioctrl  function,  it return that "Xenomai: assertion failed at kernel/xenomai/skins/rtdm/drvlib.c:372 (!xnpod_unblockable_p())"  when running.
> It is said that rtdm_task_sleep can be called from Kernel-based task. Why I can't use it in my driver. Optionally, I can do this in user-space by periodic calling the driver, but it seems slower than in kernel space.

The terms "kernel-based task" or "user space task" can be misleading.
This services requires a real-time task context. That can either be a
kernel-based *RT* task or a Xenomai shadow (aka *RT*) task in user space
that has invoked some driver service, and that driver can then call
rtdm_task_sleep on behalf of the user space task.

Blocking RTDM service *must not* be called by ordinary Linux kernel
threads or on behalf of ordinary (non-shadowed) Linux user space
threads. That's why the assertion failed for you.

HTH,
Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

