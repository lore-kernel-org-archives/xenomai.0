Message-ID: <48EC908D.9060902@domain.hid>
Date: Wed, 08 Oct 2008 12:50:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <563071.90718.qm@domain.hid>
In-Reply-To: <563071.90718.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] trap exceptions in user
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Gabriele Moabiti wrote:
> 
>> I think you are traping yourself with impossible constraints.
>>
>> Anyway, the only way is register a custom exception handler using rthal
>> functions. In your trap handler, you may wake up a user-space server
>> thread which role is to handle exceptions (in user-space). This means that:
>> - upon exception, you have a switch to the user-space server thread
>> context, this will be slow;
> 
> Do I change rthal inside xenomai? How can I do?
> Is there a benchmark or some number to understand better this slowness (in us)?

Every context switch (including kernel/user switches) costs time. There
is a switchbench test which measures the user to user context switch
time. Look at rthal_trap_catch. In your exception handler, you have to
take care about whether the fault was directed to your particular
application and let the fault be handled normally otherwise.

> 
>> - you have to rewrite the exception handling code, you can not rely
>> on the exception handling code that was written in the assembly blob.
>>
>> I do not think it is a good idea to simply override the exception
>> vectors, the kernel uses them, and you certainly want the kernel to
>> continue working.
>  
> Yes I think so
> 
> Now SIS is about 500 kb of pure asm and works with a big cli on start and a sti
> on finish @ring 0 and reprogram the exception vectors but I want to integrate into xenomai. 
> 
> Proposal:
> 
> - At start SIS save the addresses of the exception vectors
> - When an exception is raised then the processor switch to the custom exception vectors but
>   if the SIS is not currently active then jump to the old exception vectors

You say yes, then propose to do what I told you was a bad idea. So, I
repeat: this is a bad idea. I think it is better not to touch the
hardware vector and use the trap interception mechanism proposed by
Xenomai rthal. And split exception handling in a kernel-space handler
which signals a user-space server thread.

-- 
					    Gilles.

