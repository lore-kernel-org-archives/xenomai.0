From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <003f01c9c524$dc109aa0$9431cfe0$@com>
References: <003f01c9c524$dc109aa0$9431cfe0$@com>
Content-Type: text/plain
Date: Sat, 25 Apr 2009 00:11:38 +0200
Message-Id: <1240611098.6990.92.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_alarm_create
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wcall@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2009-04-24 at 15:37 -0600, Wayne Call wrote:
> There are two rt_alarm_create functions.  One is for the kernel space
> and the other is for user space.  
> 
>  
> 
> I have a linux driver that has an interrupt service routine.  When the
> driver is loaded using insmod, it executes the rt_alarm_create.  When
> the interrupt is triggered, the interrupt service routine executes the
> rt_alarm_start function.  When the rt_alarm_start function expires, it
> executes the alarm handler code.  All this code is executed in kernel
> space. 
> 
>  
> 
> What I would like to do is create a user application that executes the
> alarm handler code rather than the linux driver in kernel space.  If
> the rt_alarm_create is executed in kernel space, is there a way to
> pass the alarm descriptor to user space?

You should use rt_alarm_create() from user-space. There is no binding
possible between alarms created in kernel space to userland.

> 
>  
> 
> Wayne
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



