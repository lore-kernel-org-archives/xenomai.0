Subject: Re: [Adeos-main] adeos_enter/exit_syscall
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <0C53F2DBA565D411885300508B553B5204CCEAE9@domain.hid>
References: 
	 <0C53F2DBA565D411885300508B553B5204CCEAE9@domain.hid>
Content-Type: text/plain
Message-Id: <1091658284.618.149.camel@domain.hid>
Mime-Version: 1.0
Date: Thu, 05 Aug 2004 00:24:44 +0200
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: aaron durbin <aarondurbin@domain.hid>
Cc: "'adeos-main@gna.org'" <adeos-main@gna.org>

On Thu, 2004-08-05 at 00:16, aaron durbin wrote:
> I have a question concerning the adeos_enter_syscall routine.  Is there
> normally event monitors for syscall entry (SYSCALL_PROLOGUE)? 

Not normally when no domain is loaded. The Linux domain by itself does
not intercept (its own) syscalls. But other domains might want this
(RTAI does).

>  If so and
> handle_event returns non-zero then one automatically restores the registers
> and returns w/o calling the system call.  Doesn't this destroy the call?
> 

It prevents its execution by the Linux kernel actually. Think of a more
prioritary (in the sense higher in the pipeline than Linux) that wants
to intercept some specific syscalls issued by regular Linux apps, and
provides a replacement for them. In such a case, you might not want the
original syscall to be handled by Linux too; so you make sure that it is
not propagated to Linux -- this translates in having handle_event return
non-zero (because adeos_propagate_event is not called for the said
syscall in the upper domain handler).

> -Aaron
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 

Philippe.


