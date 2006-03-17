Message-ID: <441AC7D5.1040106@domain.hid>
Date: Fri, 17 Mar 2006 15:29:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][PATCH] security check for skin access
References: <441ABA73.2020903@domain.hid>
In-Reply-To: <441ABA73.2020903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> you all may know that Xenomai provides a bulk of very powerful
> interfaces to userspace real-time applications. But not everyone may
> have thought about the fact yet that these syscall extensions are
> accessible for *all* users in the system!
> 
> Well, real-time and security is a more complex topic, but we should at
> least restore the same level of security which Linux provides. For this
> purpose, the attached (and long-planned) patch adds basic access control
> to all Xenomai skin services by requiring CAP_SYS_NICE, i.e. the same
> capability that is also required to manipulate the normal Linux
> scheduling parameters.
> 
> I would suggest to merge it, either as an option (with default=y), or
> unconditionally (it's just a tiny additional check in the syscall path).

Also added the CONFIG_OPT_SECURITY_ACCESS switch to make this check conditional.

> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> Index: ksrc/nucleus/shadow.c
> ===================================================================
> --- ksrc/nucleus/shadow.c	(revision 719)
> +++ ksrc/nucleus/shadow.c	(working copy)
> @@ -1141,6 +1141,12 @@ static inline int do_hisyscall_event (un
>      if (!__xn_reg_mux_p(regs))
>  	goto linux_syscall;
>  
> +    if (unlikely(!cap_raised(p->cap_effective, CAP_SYS_NICE)))
> +	{
> +	__xn_error_return(regs,-EPERM);
> +	return RTHAL_EVENT_STOP;
> +	}
> +
>      muxid = __xn_mux_id(regs);
>      muxop = __xn_mux_op(regs);
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

