Message-ID: <4918560D.2000306@domain.hid>
Date: Mon, 10 Nov 2008 16:41:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E565DA7FA@oab1mx1.oneaccess.intra>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E565DA7FA@oab1mx1.oneaccess.intra>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai on blackfin svn4240
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
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Filip Van Rillaer wrote:
> Hello,
>  
> Starting from subversion revision 4240, xenomai is not compiling anymore
> for blackfin.
> I think that part of the problem is the absence of following parts in
> usermode (I mean not __KERNEL__) in the file asm-blackfin/atomic.h :
>  - typedef for xnarch_atomic_t is missing
>  - xnarch_atomic_get is missing
>  - xnarch_atomic_set is missing
>  - xnarch_atomic_cmpxchg is missing
>  
> I also had to make the function xeno_init_current_mode (file bind.h) as
> <<static inline>> to avoid a problem with multiple definitions when
> linking my user-application (it includes functions of native and rtdm
> library).
>  
> Finally rt_task_shadow fails and returns  EFAULT (but that problem can
> be caused by my own dummy implementation for the functions mentioned)
>

The build woes should be fixed, but I still need to validate the trunk on a
bf561 here.

> Best regards,
> Filip
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

