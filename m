Date: Wed, 2 Sep 2009 14:11:26 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
In-Reply-To: <4A9E4D84.20602@domain.hid>
Message-ID: <Pine.LNX.4.64.0909021359060.22914@domain.hid>
References: <Pine.LNX.4.64.0909021159100.22914@domain.hid>
	<4A9E3AAB.2070404@domain.hid>
	<Pine.LNX.4.64.0909021233110.22914@domain.hid>
	<4A9E4D84.20602@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Xenomai-help] Deprecated kernel system calls in xenomai-head
 and new application development paradigm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

:> :>   Now as rt_task_create/rt_task_start are deprecated, can anybody 
:> :> briefly describe how such driver need to be developed ?
:> :
:> :Using the RTDM skin.
:> 
:> Can you show this paradigm on pipe.c exmaple from Xenomai docs ?
:
:We are talking about drivers, then just design your driver as you would
:design a Linux driver.
:
:For instance, you would implement the "write" method of the driver to
:pass data between the user-space task and the driver.

 This is RT driver not simply Linux driver. The previous rt_pipe_read() 
call was running in RT task context. Now it is not clear how this can be 
achieved with new RTDM driver model in kernel space.

:Could you please use a valid e-mail address? I am receiving bounces from
:your mail server when trying to reply.

 I'm receiving xenomai and couple of other mail-list with no problem. So 
have received this message. Please post privatly the exact SMTP bounce 
message - so I can investigate the problem.

TIA


		Rus

