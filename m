Date: Wed, 2 Sep 2009 14:25:24 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
In-Reply-To: <4A9E5424.9070500@domain.hid>
Message-ID: <Pine.LNX.4.64.0909021418300.22914@domain.hid>
References: <Pine.LNX.4.64.0909021159100.22914@domain.hid>
	<4A9E3AAB.2070404@domain.hid>
	<Pine.LNX.4.64.0909021233110.22914@domain.hid>
	<4A9E4D84.20602@domain.hid>
	<Pine.LNX.4.64.0909021359060.22914@domain.hid>
	<4A9E5424.9070500@domain.hid>
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

On Wed, 2 Sep 2009, Gilles Chanteperdrix wrote:

:> :> :Using the RTDM skin.
:> :> Can you show this paradigm on pipe.c exmaple from Xenomai docs ?
:> :We are talking about drivers, then just design your driver as you would
:> :design a Linux driver.
:> :For instance, you would implement the "write" method of the driver to
:> :pass data between the user-space task and the driver.
:>  This is RT driver not simply Linux driver. The previous rt_pipe_read() 
:> call was running in RT task context. Now it is not clear how this can be 
:> achieved with new RTDM driver model in kernel space.
:
:The write method of an RTDM driver can run in rt context too. If the
:task which issues the call to "write" is a Xenomai user-space task
:running in primary mode.

 Please note - I do not have any Xenomai user-space tasks running - only 
normal user space programs. The Xenomai-2.4 allows developing of RT driver 
in kernel space - leaving untouchable user space processes. If such new 
paradigm need to write the intermediate user-space RT task proxy - than 
it is wrong. Simply because its adds unneeded complexity to developing RT 
kernel hardware drivers.


		Rus

