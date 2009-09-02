Message-ID: <4A9E5917.8060200@domain.hid>
Date: Wed, 02 Sep 2009 13:37:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0909021159100.22914@domain.hid>
	<4A9E3AAB.2070404@domain.hid>
	<Pine.LNX.4.64.0909021233110.22914@domain.hid>
	<4A9E4D84.20602@domain.hid>
	<Pine.LNX.4.64.0909021359060.22914@domain.hid>
	<4A9E5424.9070500@domain.hid>
	<Pine.LNX.4.64.0909021418300.22914@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0909021418300.22914@domain.hid>
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
> On Wed, 2 Sep 2009, Gilles Chanteperdrix wrote:
> 
> :> :> :Using the RTDM skin.
> :> :> Can you show this paradigm on pipe.c exmaple from Xenomai docs ?
> :> :We are talking about drivers, then just design your driver as you would
> :> :design a Linux driver.
> :> :For instance, you would implement the "write" method of the driver to
> :> :pass data between the user-space task and the driver.
> :>  This is RT driver not simply Linux driver. The previous rt_pipe_read() 
> :> call was running in RT task context. Now it is not clear how this can be 
> :> achieved with new RTDM driver model in kernel space.
> :
> :The write method of an RTDM driver can run in rt context too. If the
> :task which issues the call to "write" is a Xenomai user-space task
> :running in primary mode.
> 
>  Please note - I do not have any Xenomai user-space tasks running - only 
> normal user space programs. The Xenomai-2.4 allows developing of RT driver 
> in kernel space - leaving untouchable user space processes. If such new 
> paradigm need to write the intermediate user-space RT task proxy - than 
> it is wrong. Simply because its adds unneeded complexity to developing RT 
> kernel hardware drivers.

You do not need a proxy. What you need to do is to create the previous
non real-time task as a Xenomai task, using rt_task_create, or the
Xenomai posix skin's pthread_create. Then you would change this task to
use RTDM's write instead of write. That is all. Everything else stays
the same. And as an additonal benefit, you have one less task running if
you can avoid to create the kernel-space task, and do everything in the
write callback.

Separating clearly the driver code running in kernel-space from the
application code running in user-space is clear win. It leads to a code
easier to maintain, and avoid taking risks of running too many code in
the unprotected kernel-space.

-- 
                                          Gilles


