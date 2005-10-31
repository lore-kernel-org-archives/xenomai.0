Message-ID: <436654ED.4010804@domain.hid>
Date: Mon, 31 Oct 2005 18:31:25 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pthread_attr_setfp_np needed in user space apps ?
References: <200510311453.14159.schwab@domain.hid>
In-Reply-To: <200510311453.14159.schwab@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ulrich Schwab <schwab@domain.hid>
Cc: xenomai@xenomai.org

Ulrich Schwab wrote:
> Hello,
> 
> I am in the progress of porting an application from RTLinux to Xenomai-2.0
> While compiling for a user space RT program with the posix skin I get
> the following warning:
> 
> warning: implicit declaration of function `pthread_attr_setfp_np'
> 
> is this call NOT needed in an user space app   ?
> 

It's not needed. If you selected FPU support in the "Machine" menu when 
configuring, then Xenomai will handle FPU switches properly.

> It is there in the sources, but does not seem to be exported to a user space 
> RT app.
> 
> Another point unclear to me is, how are printf's handled in RT user space 
> apps ?
> Isn't the RT scheduling affected, when done in a RT critical context ?
> 

Printf ends up calling the write(2) system call, which is indeed the issue.
When issuing a Linux call over a RT context, your thread automatically switches 
from primary execution mode (Xenomai) to secondary (Linux). The priority of this 
thread is kept across such migration (*), so the scheduling per se is not 
impacted. What's impacted is the overall determinism one could expect from 
running Linux code, which cannot be guaranteed with vanilla kernels: IOW, you 
would have unpredictable execution times in such context, since nothing could 
guarantee that the syscall some routine end up calling would not be delayed for 
an unbounded amount of time by lower priority kernel operations.

What Xenomai brings is the ability to keep the priority scheme intact in such 
circumstances, so that a high RT priority thread switching in secondary mode is 
still runnable before a low RT priority one. The day we have a really 
deterministic Linux kernel, this little thing will make a huge difference when 
it comes to provide a seamless RT service integration.

> Thanks, for any comments,
> Ulrich Schwab
> 


-- 

Philippe.

