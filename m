From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100923013842.06427B74815@domain.hid>
References: <20100923013842.06427B74815@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Sep 2010 07:56:17 +0200
Message-ID: <1285221377.1661.109.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to add "t_restart" to pSoS emulator
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gwysu@domain.hid
Cc: Xenomai-help@domain.hid

On Thu, 2010-09-23 at 09:38 +0800, gwysu@domain.hid wrote:
>  Hi all, 
> 
>  
> 
> Currenly, the pSoS emulator doesn't support the syscall "t_restart",
> Is it difficulty to add it to the pSoS emulator? Does anyone have a
> idea about it? Thanks.

Doable, but not trivial from user-space; you would need support from the
in-kernel emulator to reset the tcb properly, before playing the
setjmp/longjmp game in userland to emulate the code restart. The
t_restart() call already available from kernel space does most of the
first part, but the second one would require some work.

pSOS introduced t_restart() mainly as a way to force the target task to
run some cleanup code before self-deleting, because this call could
unblock that task from any syscall it was pending on. If this matches
your current use case, then you have other ways to emulate this in a
linux/Xenomai environment - typically sending a thread-directed linux
signal to the target task, running the cleanup code in the signal
handler, and issuing t_delete(0) to finish there.

> 
>  
> 
>  
> 
>  
> 
>  
> 
> Best regards
> 
> Wenyi Gao
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



