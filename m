Message-ID: <4A9E5424.9070500@domain.hid>
Date: Wed, 02 Sep 2009 13:16:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0909021159100.22914@domain.hid>
	<4A9E3AAB.2070404@domain.hid>
	<Pine.LNX.4.64.0909021233110.22914@domain.hid>
	<4A9E4D84.20602@domain.hid>
	<Pine.LNX.4.64.0909021359060.22914@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0909021359060.22914@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Rus V. Brushkoff wrote:
> :> :>   Now as rt_task_create/rt_task_start are deprecated, can anybody 
> :> :> briefly describe how such driver need to be developed ?
> :> :
> :> :Using the RTDM skin.
> :> 
> :> Can you show this paradigm on pipe.c exmaple from Xenomai docs ?
> :
> :We are talking about drivers, then just design your driver as you would
> :design a Linux driver.
> :
> :For instance, you would implement the "write" method of the driver to
> :pass data between the user-space task and the driver.
> 
>  This is RT driver not simply Linux driver. The previous rt_pipe_read() 
> call was running in RT task context. Now it is not clear how this can be 
> achieved with new RTDM driver model in kernel space.

The write method of an RTDM driver can run in rt context too. If the
task which issues the call to "write" is a Xenomai user-space task
running in primary mode.

-- 
                                          Gilles


