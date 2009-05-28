From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1243526358.898.21.camel@domain.hid>
References: <1243526358.898.21.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 28 May 2009 18:52:13 +0200
Message-Id: <1243529533.22173.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running out of stack memory in kernel-space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2009-05-28 at 11:59 -0400, Andreas Glatz wrote:
> Hi,
> 
> We have to start 40+ Xenomai tasks in kernel space.

Why subjecting yourself to the pain of running a complex application in
kernel space? The difference between kernel and userland latencies on an
mpc836x should not be worth it.

> We want to allocate at least 4kbyte of stack memory
> for each of them. So we need the stack heap size 
> to be more than 160kbyte. 
> 
> In the documentation it says that the total 
> stack heap size cannot be more than 128kbyte
> (the limit of kmalloc).
> 
> Now my idea is to modify the Xenomai code to have 
> more than one stack heaps. So when I'm running out
> of space in one heap I can switch to the next heap...
> 
> Is there an easier way to increase the max. stack heap size?
> 
> Best regards, 
> Andreas 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



