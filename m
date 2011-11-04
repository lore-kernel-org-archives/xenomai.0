Message-ID: <4EB3F297.2090403@domain.hid>
Date: Fri, 04 Nov 2011 15:11:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEcCJg_RWVBVzF5S=K+fdSvO1cQph7Haf2L8jkSxRsf+-g-Mkg@domain.hid>
In-Reply-To: <CAEcCJg_RWVBVzF5S=K+fdSvO1cQph7Haf2L8jkSxRsf+-g-Mkg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai thread crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: yibo dai <strlcopy@domain.hid>
Cc: Xenomai-help@domain.hid

On 11/04/2011 03:42 AM, yibo dai wrote:
> In my current project, there is a xenomai thread in the user space,It
> doing the following things:
> 1.recieve the TIPC message from other services then handle it
> 2.recieve the packet from RTNet then handle it
> Program is probably as follows:
> while(1) {
> 	select(...); /*block and waiting for TIPC messages */
> 	/*do something*/
> 	
> 	do {
> 		ret = rt_dev_recvmsg(...,MSG_DONTWAIT); /*recieve packets from RTNet*/
> 		/* do something */
> 	} while(ret > 0);
> }
> 
> the RTNet stack will trigger a virtual interrupt(use the
> rtdm_nrtsig_pend) when recieved a packet,then the virtual interrupt
> handler will send a SIGUSR2 to the xenomai thread,...,at last the

When you do that, you cause the real-time thread to switch to secondary
mode, it means, it is no longer real-time, and using RTnet is in fact
pointless.

> xenomai thread wake up.the problem is the xenomai thread will crash
> when calling rt_dev_recvmsg sometimes.i found that
> ops->operation##_nrt(i.e. ops->recvmsg_nrt) will be call(in the
> MAJOR_FUNCTION_WRAPPER_TH),but ops->recvmsg_nrt is NULL,so the xenomai
> thread crash.

It is hard to say anything without seeing any code.

> is my usage wrong?

Yes.

why the current domain become linux when executing
> xenomai syscall?

Because you are executing a syscall which does so, not all syscalls do that.

by the way,what is the reason to remove
> CONFIG_XENO_OPT_ISHIELD?

It had problems of its own. Beside, it gave the false impression that
thread could have some real-time guarantees in secondary mode.

-- 
                                                                Gilles.

