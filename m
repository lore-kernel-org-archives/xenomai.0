Message-ID: <4887231E.8050503@domain.hid>
Date: Wed, 23 Jul 2008 14:25:02 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4887020A.9060700@domain.hid>
In-Reply-To: <4887020A.9060700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Thread policy and priority in secondary mode
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Hello,
> 
> when a Xenomai POSIX thread switches to secondary mode, how can I define 
> the policy and priority under which it should run under the Linux 
> scheduler, especially, with SCHED_FIFO.
> 
> The Xenomai POSIX API function pthread_setschedparam() described in
> 
> http://www.xenomai.org/documentation/trunk/html/api/group__posix__sched.html#g95276f88e1a2cae7a37f792123a99144
> 
> does switch the thread to primary mode when the SCHED_FIFO policy is 
> specified and therefore cannot be use for the secondary mode.
>

__real_pthread_setschedparam(). Note: this will propagate the priority to the
underlying Xenomai thread as well.

> Wolfgang.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

